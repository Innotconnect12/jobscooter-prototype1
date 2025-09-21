const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { v4: uuidv4 } = require('uuid');
const router = express.Router();

// Middleware to get database
const getDb = (req) => req.app.locals.db;

// Generate JWT token
const generateToken = (user) => {
    return jwt.sign(
        {
            id: user.id,
            username: user.username,
            email: user.email
        },
        process.env.JWT_SECRET || 'fallback_secret_key',
        { expiresIn: '7d' }
    );
};

// Middleware to authenticate JWT token
const authenticateToken = (req, res, next) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];

    if (!token) {
        return res.status(401).json({ error: 'Access token required' });
    }

    jwt.verify(token, process.env.JWT_SECRET || 'fallback_secret_key', (err, user) => {
        if (err) {
            return res.status(403).json({ error: 'Invalid or expired token' });
        }
        req.user = user;
        next();
    });
};

// Create account from extracted ID data
router.post('/create-account', async (req, res) => {
//     try {
//         const {
//             first_name,
//             surname,
//             email,
//             phone,
//             country,
//             id_number,
//             id_extraction_confidence = 0.8
//         } = req.body;
//
//         // Validate required fields
//         if (!first_name || !surname || !email || !phone || !country || !id_number) {
//             return res.status(400).json({
//                 error: 'Missing required fields',
//                 required: ['first_name', 'surname', 'email', 'phone', 'country', 'id_number']
//             });
//        }

        const db = getDb(req);

        // Check if email already exists
        const existingUser = await new Promise((resolve, reject) => {
            db.query('SELECT id FROM applicants WHERE email = ?', [email], (err, results) => {
                if (err) reject(err);
                else resolve(results[0]);
            });
        });

        if (existingUser) {
            return res.status(400).json({ error: 'Email already registered' });
        }

        // Generate username and password
        const username = `user_${Date.now()}_${Math.floor(Math.random() * 1000)}`;
        const temporaryPassword = `temp_${Math.random().toString(36).substring(2, 15)}`;
        const hashedPassword = await bcrypt.hash(temporaryPassword, 10);

        // Generate public profile URL
        const profileUrlSlug = `${first_name.toLowerCase()}-${surname.toLowerCase()}-${Date.now()}`.slice(0, 50);

        // Insert new applicant
        const applicantId = await new Promise((resolve, reject) => {
            const sql = `
                INSERT INTO applicants (
                    username, password_hash, first_name, surname, email, phone, country,
                    id_number, id_extraction_confidence, status, completion_percentage,
                    traffic_light_status, traffic_light_score, created_at
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'pending', 20, 'red', 0, NOW())
            `;

            db.query(sql, [
                username, hashedPassword, first_name, surname, email, phone,
                country, id_number, id_extraction_confidence
            ], function(err, result) {
                if (err) reject(err);
                else resolve(result.insertId);
            });
        });

        // Create public profile
        await new Promise((resolve, reject) => {
            const profileSql = `
                INSERT INTO public_profiles (applicant_id, profile_url_slug, public_fields, is_active)
                VALUES (?, ?, ?, 1)
            `;
            const publicFields = JSON.stringify({
                visible_fields: ['first_name', 'traffic_light_status', 'general_field']
            });

            db.query(profileSql, [applicantId, profileUrlSlug, publicFields], (err) => {
                if (err) reject(err);
                else resolve();
            });
        });

        // Initialize traffic light score
        await new Promise((resolve, reject) => {
            const scoreSql = `
                INSERT INTO traffic_light_scores (
                    applicant_id, identity_score, language_score, certificate_score,
                    completeness_score, consistency_score, total_score, status
                ) VALUES (?, 10, 0, 0, 4, 6, 20, 'red')
            `;

            db.query(scoreSql, [applicantId], (err) => {
                if (err) reject(err);
                else resolve();
            });
        });

        // Generate JWT token
        const user = {
            id: applicantId,
            username,
            email,
            first_name,
            surname
        };
        const token = generateToken(user);

        // Send email with login credentials
        // const nodemailer = require('nodemailer');
        //
        // const transporter = nodemailer.createTransport({
        //     host: process.env.SMTP_HOST,
        //     port: parseInt(process.env.SMTP_PORT, 10),
        //     secure: false,
        //     auth: {
        //         user: process.env.SMTP_USER,
        //         pass: process.env.SMTP_PASS
        //     }
        // });

        const mailOptions = {
            from: process.env.SMTP_FROM,
            to: email,
            subject: 'Your JobScooter Account Credentials',
            html: `
                <p>Hello ${first_name},</p>
                <p>Your account has been created successfully. Here are your login details:</p>
                <ul>
                    <li>Username: <b>${username}</b></li>
                    <li>Temporary Password: <b>${temporaryPassword}</b></li>
                </ul>
                <p>Please <a href="https://jobscooter.co.za/login">login here</a> and change your password after your first login.</p>
                <p>Thank you for using JobScooter!</p>
            `
        };

        transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
                console.error('Error sending email:', error);
            } else {
                console.log('Email sent:', info.response);
            }
        });

        res.status(201).json({
            message: 'Account created successfully and email sent',
            user: {
                ...user,
                token,
                profileUrl: `/profile/${profileUrlSlug}`
            }
        });

    } catch (error) {
        console.error('Account creation error:', error);
        res.status(500).json({ error: 'Failed to create account' });
    }
});

// Login endpoint
router.post('/login', async (req, res) => {
    try {
        const { username, password } = req.body;

        if (!username || !password) {
            return res.status(400).json({ error: 'Username and password required' });
        }

        const db = getDb(req);

        // Find user
        const user = await new Promise((resolve, reject) => {
            db.query(
                'SELECT * FROM applicants WHERE username = ? OR email = ?',
                [username, username],
                (err, results) => {
                    if (err) reject(err);
                    else resolve(results[0]);
                }
            );
        });

        if (!user) {
            return res.status(401).json({ error: 'Invalid credentials' });
        }

        // Verify password
        const isValidPassword = await bcrypt.compare(password, user.password_hash);
        if (!isValidPassword) {
            return res.status(401).json({ error: 'Invalid credentials' });
        }

        // Update last login
        await new Promise((resolve, reject) => {
            db.query(
                'UPDATE applicants SET updated_at = NOW() WHERE id = ?',
                [user.id],
                (err) => {
                    if (err) reject(err);
                    else resolve();
                }
            );
        });

        // Generate token
        const token = generateToken(user);

        // Get public profile URL
        const publicProfile = await new Promise((resolve, reject) => {
            db.query(
                'SELECT profile_url_slug FROM public_profiles WHERE applicant_id = ?',
                [user.id],
                (err, results) => {
                    if (err) reject(err);
                    else resolve(results[0]);
                }
            );
        });

        // Remove password from response
        const { password_hash, ...userWithoutPassword } = user;

        res.json({
            message: 'Login successful',
            user: {
                ...userWithoutPassword,
                token,
                profileUrl: publicProfile ? `/profile/${publicProfile.profile_url_slug}` : null
            }
        });

    } catch (error) {
        console.error('Login error:', error);
        res.status(500).json({ error: 'Login failed' });
    }
});

// Verify email endpoint
router.post('/verify-email', async (req, res) => {
    try {
        const { email, verificationCode } = req.body;

        // In a real application, you would verify the code
        // For prototype, we'll just mark as verified

        const db = getDb(req);

        await new Promise((resolve, reject) => {
            db.query(
                'UPDATE applicants SET is_verified = 1, email_verified_at = NOW() WHERE email = ?',
                [email],
                function(err, result) {
                    if (err) reject(err);
                    else if (result.affectedRows === 0) reject(new Error('Email not found'));
                    else resolve();
                }
            );
        });

        res.json({ message: 'Email verified successfully' });

    } catch (error) {
        console.error('Email verification error:', error);
        res.status(500).json({ error: 'Email verification failed' });
    }
});

// Get current user profile
router.get('/profile', authenticateToken, async (req, res) => {
    try {
        const db = getDb(req);

        // Get user with additional data
        const user = await new Promise((resolve, reject) => {
            db.query(`
                SELECT a.*, p.profile_url_slug, tls.total_score, tls.status as traffic_status
                FROM applicants a
                LEFT JOIN public_profiles p ON a.id = p.applicant_id
                LEFT JOIN traffic_light_scores tls ON a.id = tls.applicant_id
                WHERE a.id = ?
            `, [req.user.id], (err, results) => {
                if (err) reject(err);
                else resolve(results[0]);
            });
        });

        if (!user) {
            return res.status(404).json({ error: 'User not found' });
        }

        // Get certificates count
        const certificatesCount = await new Promise((resolve, reject) => {
            db.query(
                'SELECT COUNT(*) as count FROM certificates WHERE applicant_id = ?',
                [user.id],
                (err, results) => {
                    if (err) reject(err);
                    else resolve(results[0] ? results[0].count : 0);
                }
            );
        });

        // Get languages count
        const languagesCount = await new Promise((resolve, reject) => {
            db.query(
                'SELECT COUNT(*) as count FROM language_verifications WHERE applicant_id = ?',
                [user.id],
                (err, results) => {
                    if (err) reject(err);
                    else resolve(results[0] ? results[0].count : 0);
                }
            );
        });

        // Remove password from response
        const { password_hash, ...userWithoutPassword } = user;

        res.json({
            user: {
                ...userWithoutPassword,
                certificates_count: certificatesCount,
                languages_count: languagesCount,
                profileUrl: user.profile_url_slug ? `/profile/${user.profile_url_slug}` : null
            }
        });

    } catch (error) {
        console.error('Profile fetch error:', error);
        res.status(500).json({ error: 'Failed to fetch profile' });
    }
});

// Update password
router.post('/update-password', authenticateToken, async (req, res) => {
    try {
        const { currentPassword, newPassword } = req.body;

        if (!currentPassword || !newPassword) {
            return res.status(400).json({ error: 'Current and new password required' });
        }

        if (newPassword.length < 6) {
            return res.status(400).json({ error: 'New password must be at least 6 characters' });
        }

        const db = getDb(req);

        // Get current user
        const user = await new Promise((resolve, reject) => {
            db.query('SELECT password_hash FROM applicants WHERE id = ?', [req.user.id], (err, results) => {
                if (err) reject(err);
                else resolve(results[0]);
            });
        });

        if (!user) {
            return res.status(404).json({ error: 'User not found' });
        }

        // Verify current password
        const isValidPassword = await bcrypt.compare(currentPassword, user.password_hash);
        if (!isValidPassword) {
            return res.status(401).json({ error: 'Current password is incorrect' });
        }

        // Hash new password
        const hashedNewPassword = await bcrypt.hash(newPassword, 10);

        // Update password
        await new Promise((resolve, reject) => {
            db.query(
                'UPDATE applicants SET password_hash = ?, updated_at = NOW() WHERE id = ?',
                [hashedNewPassword, req.user.id],
                function(err, result) {
                    if (err) reject(err);
                    else if (result.affectedRows === 0) reject(new Error('User not found'));
                    else resolve();
                }
            );
        });

        res.json({ message: 'Password updated successfully' });

    } catch (error) {
        console.error('Password update error:', error);
        res.status(500).json({ error: 'Failed to update password' });
    }
});

// Logout (client-side token removal, but we can log it)
router.post('/logout', authenticateToken, (req, res) => {
    // In a real application, you might want to blacklist the token
    // For now, we'll just confirm logout
    res.json({ message: 'Logged out successfully' });
});

// Export router and middleware
module.exports = router;
module.exports.authenticateToken = authenticateToken;

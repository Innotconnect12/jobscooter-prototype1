const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const AccountService = require('../services/account-service');

const accountService = new AccountService();
const router = express.Router();

// Middleware to get database
const getDb = (req) => req.app.locals.db;

// Generate JWT token
const generateToken = (user) => {
    return jwt.sign(
        { id: user.id, username: user.username, email: user.email },
        process.env.JWT_SECRET || 'fallback_secret_key',
        { expiresIn: '7d' }
    );
};

// Middleware to authenticate JWT token
const authenticateToken = (req, res, next) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader?.split(' ')[1];

    if (!token) return res.status(401).json({ error: 'Access token required' });

    jwt.verify(token, process.env.JWT_SECRET || 'fallback_secret_key', (err, user) => {
        if (err) return res.status(403).json({ error: 'Invalid or expired token' });
        req.user = user;
        next();
    });
};

// Create account endpoint
router.post('/create-account', async (req, res) => {
    const db = getDb(req);
    try {
        const result = await accountService.createAccount(req.body, db);
        res.status(201).json({
            message: 'Account created successfully. Please verify your email.',
            user: result.user,
            credentials: result.credentials,
            emailSent: result.emailSent
        });
    } catch (error) {
        console.error('Account creation error:', error);
        res.status(400).json({ error: error.message });
    }
});

// Login endpoint
router.post('/login', async (req, res) => {
    const db = getDb(req);
    const { username, password } = req.body;

    if (!username || !password) return res.status(400).json({ error: 'Username and password required' });

    try {
        const [user] = await db.promise().query(
            'SELECT * FROM applicants WHERE username = ? OR email = ?',
            [username, username]
        );

        if (!user || !user.length) return res.status(401).json({ error: 'Invalid credentials' });

        const foundUser = user[0];
        const isValidPassword = await bcrypt.compare(password, foundUser.password_hash);

        if (!isValidPassword) return res.status(401).json({ error: 'Invalid credentials' });

        // Update last login
        await db.promise().query('UPDATE applicants SET updated_at = NOW() WHERE id = ?', [foundUser.id]);

        // Generate token
        const token = generateToken(foundUser);

        // Get public profile slug
        const [profileResults] = await db.promise().query(
            'SELECT profile_url_slug FROM public_profiles WHERE applicant_id = ?',
            [foundUser.id]
        );
        const profileSlug = profileResults[0]?.profile_url_slug || null;

        const { password_hash, ...userWithoutPassword } = foundUser;

        res.json({
            message: 'Login successful',
            user: { ...userWithoutPassword, token, profileUrl: profileSlug ? `/profile/${profileSlug}` : null }
        });
    } catch (err) {
        console.error('Login error:', err);
        res.status(500).json({ error: 'Login failed' });
    }
});

// Verify email endpoint
router.post('/verify-email', async (req, res) => {
    const db = getDb(req);
    const { email } = req.body;

    try {
        const [result] = await db.promise().query(
            'UPDATE applicants SET is_verified = 1, email_verified_at = NOW() WHERE email = ?',
            [email]
        );

        if (result.affectedRows === 0) return res.status(404).json({ error: 'Email not found' });

        res.json({ message: 'Email verified successfully' });
    } catch (err) {
        console.error('Email verification error:', err);
        res.status(500).json({ error: 'Email verification failed' });
    }
});

// Get current user profile
router.get('/profile', authenticateToken, async (req, res) => {
    const db = getDb(req);

    try {
        const [users] = await db.promise().query(
            `SELECT a.*, p.profile_url_slug, tls.total_score, tls.status as traffic_status
            FROM applicants a
            LEFT JOIN public_profiles p ON a.id = p.applicant_id
            LEFT JOIN traffic_light_scores tls ON a.id = tls.applicant_id
            WHERE a.id = ?`,
            [req.user.id]
        );

        if (!users.length) return res.status(404).json({ error: 'User not found' });

        const user = users[0];

        const [[certificatesResult]] = await db.promise().query(
            'SELECT COUNT(*) as count FROM certificates WHERE applicant_id = ?',
            [user.id]
        );
        const [[languagesResult]] = await db.promise().query(
            'SELECT COUNT(*) as count FROM language_verifications WHERE applicant_id = ?',
            [user.id]
        );

        const { password_hash, ...userWithoutPassword } = user;

        res.json({
            user: {
                ...userWithoutPassword,
                certificates_count: certificatesResult.count || 0,
                languages_count: languagesResult.count || 0,
                profileUrl: user.profile_url_slug ? `/profile/${user.profile_url_slug}` : null
            }
        });
    } catch (err) {
        console.error('Profile fetch error:', err);
        res.status(500).json({ error: 'Failed to fetch profile' });
    }
});

// Update password
router.post('/update-password', authenticateToken, async (req, res) => {
    const db = getDb(req);
    const { currentPassword, newPassword } = req.body;

    if (!currentPassword || !newPassword)
        return res.status(400).json({ error: 'Current and new password required' });

    if (newPassword.length < 6)
        return res.status(400).json({ error: 'New password must be at least 6 characters' });

    try {
        const [[user]] = await db.promise().query('SELECT password_hash FROM applicants WHERE id = ?', [req.user.id]);

        if (!user) return res.status(404).json({ error: 'User not found' });

        const isValidPassword = await bcrypt.compare(currentPassword, user.password_hash);
        if (!isValidPassword) return res.status(401).json({ error: 'Current password is incorrect' });

        const hashedNewPassword = await bcrypt.hash(newPassword, 10);
        await db.promise().query(
            'UPDATE applicants SET password_hash = ?, updated_at = NOW() WHERE id = ?',
            [hashedNewPassword, req.user.id]
        );

        res.json({ message: 'Password updated successfully' });
    } catch (err) {
        console.error('Password update error:', err);
        res.status(500).json({ error: 'Failed to update password' });
    }
});

// Logout endpoint
router.post('/logout', authenticateToken, async (req, res) => {
    // For production, consider token blacklisting
    res.json({ message: 'Logged out successfully' });
});

module.exports = router;
module.exports.authenticateToken = authenticateToken;

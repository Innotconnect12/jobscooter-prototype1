// To be able to send emails to registered participants
const nodemailer = require('nodemailer');

// Creating a transporter with the production SMTP settings
const transporter = nodemailer.createTransport({
    host: process.env.SMTP_HOST,
    port: process.env.SMTP_PORT || 465,
    secure: false, // true for 465, false for 587
    auth: {
        user: process.env.SMTP_USER,
        pass: process.env.SMTP_PASS,
    }
});

// Testing email connection
transporter.verify((error, success) => {
    if (error) {
        console.error('❌ Email service configuration error:', error.message);
    } else {
        console.log('✅ Email service ready - SMTP connection verified');
    }
});

class EmailService {
    // Send a welcome email with login credentials
    static async sendWelcomeEmail(userEmail, loginCredentials, verificationToken) {
        try {
            const verificationUrl = `${process.env.FRONTEND_URL}/verify-email?token=${verificationToken}`;

            const mailOptions = {
                from: `"JobScooter Support" <${process.env.SMTP_FROM}>`,
                to: userEmail,
                subject: '🚀 Welcome to JobScooter - Account Created Successfully!',
                html: `
                <!DOCTYPE html>
                <html>
                <head>
                    <meta charset="utf-8">
                    <title>Welcome to JobScooter</title>
                    <style>
                        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; line-height: 1.6; color: #333; }
                        .container { max-width: 600px; margin: 0 auto; padding: 20px; }
                        .header { background: linear-gradient(135deg, #4f46e5, #7c3aed); color: white; padding: 30px; text-align: center; border-radius: 10px 10px 0 0; }
                        .content { background: white; padding: 30px; border: 1px solid #e2e8f0; }
                        .credentials { background: #f8fafc; padding: 20px; border-radius: 8px; margin: 20px 0; border-left: 4px solid #4f46e5; }
                        .button { display: inline-block; background: linear-gradient(45deg, #ff6b6b, #ee5a24); color: white; padding: 15px 30px; text-decoration: none; border-radius: 25px; margin: 20px 0; }
                        .footer { background: #f8fafc; padding: 20px; text-align: center; border-radius: 0 0 10px 10px; font-size: 14px; color: #666; }
                    </style>
                </head>
                <body>
                    <div class="container">
                        <div class="header">
                            <h1>🚀 Welcome to JobScooter!</h1>
                            <p>Your AI-powered job application account is ready</p>
                        </div>
                        
                        <div class="content">
                            <h2>Account Created Successfully</h2>
                            <p>Great news! Your JobScooter account has been created successfully. We've generated secure login credentials for you:</p>
                            
                            <div class="credentials">
                                <h3>🔐 Your Login Credentials</h3>
                                <p><strong>Username:</strong> ${loginCredentials.username}</p>
                                <p><strong>Password:</strong> ${loginCredentials.password}</p>
                                <p><strong>Login URL:</strong> <a href="${process.env.FRONTEND_URL}/login">${process.env.FRONTEND_URL}/login</a></p>
                            </div>
                            
                            <p><strong>⚠️ Important:</strong> Please save these credentials securely and change your password after the first login.</p>
                            
                            <h3>📧 Verify Your Email</h3>
                            <p>To complete your account setup and continue with your job application, please verify your email address:</p>
                            
                            <a href="${verificationUrl}" class="button">✅ Verify Email Address</a>
                            
                            <h3>🎯 Next Steps</h3>
                            <ol>
                                <li>Click the verification link above</li>
                                <li>Log in with your credentials</li>
                                <li>Continue with your job application process</li>
                                <li>Complete your profile for the best results</li>
                            </ol>
                            
                            <h3>🚀 Why JobScooter?</h3>
                            <ul>
                                <li>🤖 AI-powered document verification</li>
                                <li>🎯 Traffic Light scoring system</li>
                                <li>🏆 Verified professional profiles</li>
                                <li>⚡ 3x faster application process</li>
                            </ul>
                        </div>
                        
                        <div class="footer">
                            <p>If you didn't create this account, please contact our support team immediately.</p>
                            <p>📧 <a href="mailto:support@jobscooter.co.za">support@jobscooter.co.za</a> | 🌐 <a href="https://www.jobscooter.co.za">www.jobscooter.co.za</a></p>
                            <p>© 2024 JobScooter. All rights reserved.</p>
                        </div>
                    </div>
                </body>
                </html>
                `
            };

            const result = await transporter.sendMail(mailOptions);
            console.log('✅ Welcome email sent successfully:', result.messageId);
            return { success: true, messageId: result.messageId };

        } catch (error) {
            console.error('❌ Failed to send welcome email:', error);
            return { success: false, error: error.message };
        }
    }

    // Send email verification reminder
    static async sendVerificationReminder(userEmail, verificationToken) {
        try {
            const verificationUrl = `${process.env.FRONTEND_URL}/verify-email?token=${verificationToken}`;

            const mailOptions = {
                from: `"JobScooter Support" <${process.env.SMTP_FROM}>`,
                to: userEmail,
                subject: '📧 Please Verify Your JobScooter Email Address',
                html: `
                <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;">
                    <h2 style="color: #4f46e5;">📧 Email Verification Required</h2>
                    <p>We noticed you haven't verified your email address yet. Please click the button below to verify your account and continue with your job application:</p>
                    <p style="text-align: center; margin: 30px 0;">
                        <a href="${verificationUrl}" style="background: #4f46e5; color: white; padding: 15px 30px; text-decoration: none; border-radius: 5px;">Verify Email Address</a>
                    </p>
                    <p>Or copy and paste this link in your browser:<br>
                    <a href="${verificationUrl}">${verificationUrl}</a></p>
                    <p>Best regards,<br>The JobScooter Team</p>
                </div>
                `
            };

            const result = await transporter.sendMail(mailOptions);
            console.log('✅ Verification reminder sent:', result.messageId);
            return { success: true, messageId: result.messageId };

        } catch (error) {
            console.error('❌ Failed to send verification reminder:', error);
            return { success: false, error: error.message };
        }
    }

    // Send application status update
    static async sendApplicationStatusUpdate(userEmail, userName, status, completionPercentage) {
        try {
            let statusMessage, statusColor, nextSteps;

            switch (status) {
                case 'green':
                    statusMessage = '🟢 Excellent! Your profile is complete and employer-ready';
                    statusColor = '#10b981';
                    nextSteps = 'Your profile is now live and visible to employers. Great job!';
                    break;
                case 'yellow':
                    statusMessage = '🟡 Good progress! Minor improvements recommended';
                    statusColor = '#f59e0b';
                    nextSteps = 'Complete the remaining sections to achieve Green status.';
                    break;
                case 'red':
                    statusMessage = '🔴 Attention needed - Please complete your profile';
                    statusColor = '#ef4444';
                    nextSteps = 'Please upload missing documents and complete all sections.';
                    break;
                default:
                    statusMessage = 'Profile update';
                    statusColor = '#6b7280';
                    nextSteps = 'Continue with your application process.';
            }

            const mailOptions = {
                from: `"JobScooter Support" <${process.env.SMTP_FROM}>`,
                to: userEmail,
                subject: `🎯 JobScooter Profile Update - ${completionPercentage}% Complete`,
                html: `
                <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;">
                    <h2 style="color: ${statusColor};">${statusMessage}</h2>
                    <p>Hi ${userName},</p>
                    <p>Your JobScooter profile has been updated. Here's your current status:</p>
                    
                    <div style="background: #f8fafc; padding: 20px; border-radius: 8px; margin: 20px 0;">
                        <h3>📊 Profile Completion: ${completionPercentage}%</h3>
                        <div style="background: #e5e7eb; height: 10px; border-radius: 5px; margin: 10px 0;">
                            <div style="background: ${statusColor}; height: 10px; width: ${completionPercentage}%; border-radius: 5px;"></div>
                        </div>
                        <p><strong>Traffic Light Status:</strong> <span style="color: ${statusColor}; font-weight: bold;">${status.toUpperCase()}</span></p>
                    </div>
                    
                    <h3>🎯 Next Steps:</h3>
                    <p>${nextSteps}</p>
                    
                    <p style="text-align: center; margin: 30px 0;">
                        <a href="${process.env.FRONTEND_URL}/dashboard" style="background: #4f46e5; color: white; padding: 15px 30px; text-decoration: none; border-radius: 5px;">View Your Dashboard</a>
                    </p>
                    
                    <p>Keep up the great work!</p>
                    <p>Best regards,<br>The JobScooter Team</p>
                </div>
                `
            };

            const result = await transporter.sendMail(mailOptions);
            console.log('✅ Status update email sent:', result.messageId);
            return { success: true, messageId: result.messageId };

        } catch (error) {
            console.error('❌ Failed to send status update email:', error);
            return { success: false, error: error.message };
        }
    }

    // Test email functionality
    static async sendTestEmail(testEmail) {
        try {
            const mailOptions = {
                from: `"JobScooter Support" <${process.env.SMTP_FROM}>`,
                to: testEmail,
                subject: '✅ JobScooter Email Service Test',
                html: `
                <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;">
                    <h2 style="color: #4f46e5;">✅ Email Service Working!</h2>
                    <p>This is a test email to verify that the JobScooter email service is configured correctly.</p>
                    <p><strong>Configuration Details:</strong></p>
                    <ul>
                        <li>SMTP Host: ${process.env.SMTP_HOST}</li>
                        <li>SMTP Port: ${process.env.SMTP_PORT}</li>
                        <li>From Address: ${process.env.SMTP_FROM}</li>
                        <li>Timestamp: ${new Date().toISOString()}</li>
                    </ul>
                    <p>🎉 All systems operational!</p>
                </div>
                `
            };

            const result = await transporter.sendMail(mailOptions);
            console.log('✅ Test email sent successfully:', result.messageId);
            return { success: true, messageId: result.messageId };

        } catch (error) {
            console.error('❌ Failed to send test email:', error);
            return { success: false, error: error.message };
        }
    }
}


module.exports = EmailService;

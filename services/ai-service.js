const Tesseract = require('tesseract.js');
const sharp = require('sharp');
const Jimp = require('jimp');
const pdf = require('pdf-parse');
const crypto = require('crypto-js');
const moment = require('moment');
const fs = require('fs');
const path = require('path');

class AIService {
    constructor() {
        this.ocrWorker = null;
        this.initializeOCR();
        
        // Accredited institutions database (sample)
        this.accreditedInstitutions = [
            'University of Cape Town',
            'University of the Witwatersrand',
            'Stellenbosch University',
            'University of Pretoria',
            'Rhodes University',
            'Goethe Institute',
            'TestDaF Institute',
            'TELC',
            'Cambridge Assessment English',
            'British Council',
            // Add more accredited institutions
        ];
    }

    async initializeOCR() {
        try {
            console.log('Initializing OCR worker...');
            // OCR worker will be created on-demand to avoid startup delays
            console.log('✅ OCR service ready');
        } catch (error) {
            console.error('❌ OCR initialization failed:', error);
        }
    }

    async processIDDocument(imagePath) {
        try {
            console.log('Processing ID document:', imagePath);

            // Check if file is PDF - currently not supported
            const path = require('path');
            const fileExt = path.extname(imagePath).toLowerCase();
            if (fileExt === '.pdf') {
                throw new Error('PDF ID documents are not currently supported. Please upload a JPG or PNG image of your ID document.');
            }

            // Preprocess image for better OCR results
            const processedImagePath = await this.preprocessImage(imagePath);
            
            if (!processedImagePath) {
                throw new Error('Unsupported file format. Please upload a JPG or PNG image.');
            }
            
            // Extract text using OCR
            const extractedText = await this.extractTextFromImage(processedImagePath);
            
            // Parse extracted data
            const parsedData = this.parseIDData(extractedText);
            
            // Clean up processed image
            if (processedImagePath !== imagePath && fs.existsSync(processedImagePath)) {
                fs.unlinkSync(processedImagePath);
            }
            
            return {
                success: true,
                extractedData: parsedData,
                confidence: parsedData.confidence || 0.7
            };
        } catch (error) {
            console.error('ID processing failed:', error);
            return {
                success: false,
                error: error.message,
                requiresManualEntry: true
            };
        }
    }

    async preprocessImage(imagePath) {
        try {
            // Generate a unique output path to avoid same file input/output error
            const path = require('path');
            const parsedPath = path.parse(imagePath);
            const outputPath = path.join(parsedPath.dir, parsedPath.name + '_processed.png');
            
            // Check if input is PDF - skip preprocessing for PDFs since OCR can't handle them
            if (parsedPath.ext.toLowerCase() === '.pdf') {
                console.log('PDF detected - OCR cannot process PDF files directly');
                return null; // Signal that PDF processing is not supported
            }
            
            console.log('Preprocessing image from:', imagePath, 'to:', outputPath);
            
            // Enhance image for better OCR
            await sharp(imagePath)
                .resize({ width: 1200, height: 800, fit: 'inside' })
                .grayscale()
                .normalize()
                .sharpen()
                .png()
                .toFile(outputPath);
                
            return outputPath;
        } catch (error) {
            console.error('Image preprocessing failed:', error);
            return imagePath; // Return original if preprocessing fails
        }
    }

    async extractTextFromImage(imagePath) {
        try {
            if (!this.ocrWorker) {
                this.ocrWorker = await Tesseract.createWorker('eng');
                await this.ocrWorker.setParameters({
                    tessedit_char_whitelist: 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .,/-:',
                });
            }

            const { data: { text, confidence } } = await this.ocrWorker.recognize(imagePath);
            console.log('OCR confidence:', confidence);
            
            return {
                text: text.trim(),
                confidence: confidence / 100
            };
        } catch (error) {
            console.error('OCR extraction failed:', error);
            throw new Error('Failed to extract text from image');
        }
    }

    parseIDData(extractedData) {
        const text = extractedData.text || '';
        const confidence = extractedData.confidence || 0;
        
        const result = {
            confidence: confidence,
            extractedFields: {}
        };

        // South African ID parsing patterns
        const patterns = {
            idNumber: /(\d{13})/g,
            surname: /Surname[:\s]+([A-Z\s]+)/i,
            names: /Names?[:\s]+([A-Z\s]+)/i,
            dateOfBirth: /Date of Birth[:\s]+(\d{2}[-/]\d{2}[-/]\d{4})/i,
            nationality: /Nationality[:\s]+([A-Z\s]+)/i,
            sex: /Sex[:\s]+([MF])/i
        };

        // Extract information using patterns
        for (const [field, pattern] of Object.entries(patterns)) {
            const match = text.match(pattern);
            if (match) {
                result.extractedFields[field] = match[1].trim();
            }
        }

        // Additional parsing for common ID formats
        if (!result.extractedFields.idNumber) {
            // Try alternative ID number patterns
            const idMatch = text.match(/(\d{6}\s?\d{4}\s?\d{2}\s?\d)/);
            if (idMatch) {
                result.extractedFields.idNumber = idMatch[1].replace(/\s/g, '');
            }
        }

        // Validate and structure the extracted data
        if (result.extractedFields.idNumber) {
            const validation = this.validateSouthAfricanID(result.extractedFields.idNumber);
            result.extractedFields.isValidID = validation.isValid;
            if (validation.isValid) {
                result.extractedFields.inferredDateOfBirth = validation.dateOfBirth;
                result.extractedFields.inferredGender = validation.gender;
            }
        }

        return result;
    }

    validateSouthAfricanID(idNumber) {
        if (!/^\d{13}$/.test(idNumber)) {
            return { isValid: false };
        }

        try {
            // Extract date of birth (YYMMDD)
            const year = parseInt(idNumber.substr(0, 2));
            const month = parseInt(idNumber.substr(2, 2));
            const day = parseInt(idNumber.substr(4, 2));
            
            // Determine century
            const fullYear = year <= 21 ? 2000 + year : 1900 + year;
            
            // Extract gender digit
            const genderDigit = parseInt(idNumber.substr(6, 4));
            const gender = genderDigit < 5000 ? 'Female' : 'Male';
            
            // Basic validation
            if (month < 1 || month > 12 || day < 1 || day > 31) {
                return { isValid: false };
            }

            const dateOfBirth = `${fullYear}-${month.toString().padStart(2, '0')}-${day.toString().padStart(2, '0')}`;

            return {
                isValid: true,
                dateOfBirth: dateOfBirth,
                gender: gender
            };
        } catch (error) {
            return { isValid: false };
        }
    }

    async processCertificate(filePath) {
        try {
            console.log('Processing certificate:', filePath);
            
            let extractedText;
            const fileExtension = path.extname(filePath).toLowerCase();
            
            if (fileExtension === '.pdf') {
                extractedText = await this.extractTextFromPDF(filePath);
            } else {
                extractedText = await this.extractTextFromImage(filePath);
            }
            
            const certificateData = this.parseCertificateData(extractedText.text || extractedText);
            
            return {
                success: true,
                certificateData: certificateData,
                confidence: extractedText.confidence || 0.8
            };
        } catch (error) {
            console.error('Certificate processing failed:', error);
            return {
                success: false,
                error: error.message
            };
        }
    }

    async extractTextFromPDF(pdfPath) {
        try {
            const dataBuffer = fs.readFileSync(pdfPath);
            const data = await pdf(dataBuffer);
            return {
                text: data.text,
                confidence: 0.95 // PDFs generally have high text extraction confidence
            };
        } catch (error) {
            console.error('PDF text extraction failed:', error);
            throw new Error('Failed to extract text from PDF');
        }
    }

    parseCertificateData(text) {
        const result = {
            type: 'unknown',
            subject: '',
            institution: '',
            dateIssued: '',
            grade: '',
            holderName: '',
            isAccredited: false,
            classification: ''
        };

        // Detect certificate type
        if (this.containsAny(text.toLowerCase(), ['certificate', 'diploma', 'degree'])) {
            if (this.containsAny(text.toLowerCase(), ['bachelor', 'bsc', 'ba', 'bcom'])) {
                result.type = 'Bachelor\'s Degree';
                result.classification = 'academic';
            } else if (this.containsAny(text.toLowerCase(), ['master', 'msc', 'ma', 'mcom', 'mba'])) {
                result.type = 'Master\'s Degree';
                result.classification = 'academic';
            } else if (this.containsAny(text.toLowerCase(), ['phd', 'doctorate', 'doctoral'])) {
                result.type = 'Doctorate';
                result.classification = 'academic';
            } else if (this.containsAny(text.toLowerCase(), ['diploma'])) {
                result.type = 'Diploma';
                result.classification = 'professional';
            } else {
                result.type = 'Certificate';
                result.classification = 'professional';
            }
        } else if (this.containsAny(text.toLowerCase(), ['reference', 'recommendation', 'letter'])) {
            result.type = 'Reference Letter';
            result.classification = 'reference';
        }

        // Extract institution
        for (const institution of this.accreditedInstitutions) {
            if (text.toLowerCase().includes(institution.toLowerCase())) {
                result.institution = institution;
                result.isAccredited = true;
                break;
            }
        }

        // Extract dates
        const datePatterns = [
            /(\d{1,2}[-/]\d{1,2}[-/]\d{4})/g,
            /(\d{4}[-/]\d{1,2}[-/]\d{1,2})/g,
            /(January|February|March|April|May|June|July|August|September|October|November|December)\s+\d{1,2},?\s+\d{4}/gi
        ];

        for (const pattern of datePatterns) {
            const matches = text.match(pattern);
            if (matches && matches.length > 0) {
                result.dateIssued = matches[matches.length - 1]; // Usually the last date is the issue date
                break;
            }
        }

        // Extract subject/field of study
        const subjectPatterns = [
            /(?:in|of)\s+([A-Za-z\s]+)(?:\s+has|successfully)/i,
            /qualification in\s+([A-Za-z\s]+)/i,
            /(?:bachelor|master|diploma)(?:'s)?\s+(?:of|in)\s+([A-Za-z\s]+)/i
        ];

        for (const pattern of subjectPatterns) {
            const match = text.match(pattern);
            if (match) {
                result.subject = match[1].trim();
                break;
            }
        }

        // Extract holder name
        const namePatterns = [
            /(?:this is to certify that|certifies that|awarded to)\s+([A-Z][a-z]+(?:\s+[A-Z][a-z]+)+)/i,
            /(?:Mr\.?|Mrs\.?|Ms\.?|Miss)\s+([A-Z][a-z]+(?:\s+[A-Z][a-z]+)+)/i
        ];

        for (const pattern of namePatterns) {
            const match = text.match(pattern);
            if (match) {
                result.holderName = match[1].trim();
                break;
            }
        }

        // Extract grade/classification
        const gradePatterns = [
            /(?:with|grade|class)\s+([A-Za-z\s]+)(?:\s+class|\s+distinction)/i,
            /(?:first class|second class|third class|distinction|pass)/gi
        ];

        for (const pattern of gradePatterns) {
            const match = text.match(pattern);
            if (match) {
                result.grade = match[0].trim();
                break;
            }
        }

        return result;
    }

    containsAny(text, keywords) {
        return keywords.some(keyword => text.includes(keyword));
    }

    async verifyGermanLanguageCertificate(certificateData) {
        // German language certificate verification
        const germanInstitutions = [
            'Goethe Institut',
            'TestDaF Institute',
            'TELC',
            'ÖSD',
            'Deutsche Sprachprüfung',
            'Zertifikat Deutsch'
        ];

        const isGermanCert = germanInstitutions.some(inst => 
            certificateData.institution?.toLowerCase().includes(inst.toLowerCase()) ||
            certificateData.subject?.toLowerCase().includes('german') ||
            certificateData.subject?.toLowerCase().includes('deutsch')
        );

        if (!isGermanCert) {
            return {
                isValid: false,
                reason: 'Certificate is not from a recognized German language institution'
            };
        }

        // Check for common German proficiency levels
        const germanLevels = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2', 'DSH', 'TestDaF'];
        const hasLevel = germanLevels.some(level => 
            certificateData.subject?.includes(level) ||
            certificateData.grade?.includes(level)
        );

        return {
            isValid: isGermanCert && certificateData.isAccredited,
            level: hasLevel ? 'Verified German Proficiency' : 'Basic German',
            institution: certificateData.institution
        };
    }

    generateTrafficLightScore(profileData) {
        let score = 0;
        const factors = {
            idVerified: profileData.idVerified ? 20 : 0,
            certificatesCount: Math.min(profileData.certificates?.length || 0, 5) * 10,
            accreditedCertificates: (profileData.accreditedCertificatesCount || 0) * 15,
            languageVerified: profileData.languagesVerified ? 15 : 0,
            hasProfilePicture: profileData.profilePicture ? 10 : 0,
            hasVideoIntro: profileData.videoIntroduction ? 10 : 0,
            profileCompletion: (profileData.completionPercentage || 0) * 0.2
        };

        score = Object.values(factors).reduce((sum, value) => sum + value, 0);

        // Determine traffic light status
        if (score >= 80) {
            return {
                status: 'green',
                score: score,
                message: 'Profile is complete and ready for employers',
                recommendations: []
            };
        } else if (score >= 60) {
            return {
                status: 'yellow',
                score: score,
                message: 'Profile needs minor improvements',
                recommendations: this.generateRecommendations(profileData)
            };
        } else {
            return {
                status: 'red',
                score: score,
                message: 'Profile requires significant attention',
                recommendations: this.generateRecommendations(profileData)
            };
        }
    }

    generateRecommendations(profileData) {
        const recommendations = [];

        if (!profileData.idVerified) {
            recommendations.push('Complete ID verification');
        }
        if (!profileData.certificates || profileData.certificates.length === 0) {
            recommendations.push('Upload your certificates and qualifications');
        }
        if (!profileData.languagesVerified) {
            recommendations.push('Verify your language skills');
        }
        if (!profileData.profilePicture) {
            recommendations.push('Add a professional profile picture');
        }
        if (!profileData.videoIntroduction) {
            recommendations.push('Record a video introduction');
        }
        if (profileData.accreditedCertificatesCount === 0) {
            recommendations.push('Ensure certificates are from accredited institutions');
        }

        return recommendations;
    }

    async cleanup() {
        try {
            if (this.ocrWorker) {
                await this.ocrWorker.terminate();
                this.ocrWorker = null;
            }
        } catch (error) {
            console.error('Cleanup failed:', error);
        }
    }
}

module.exports = AIService;
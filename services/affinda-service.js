require('dotenv').config();
const axios = require('axios');
const path = require('path');
const fs = require('fs'); 
const FormData = require('form-data');

class AffindaService {
    constructor() {
        this.apiKey = process.env.AFFINDA_API_KEY;
        this.baseUrl = 'https://api.affinda.com/api/v3'; // adjust if needed
    }

    async processIDDocument(filePath) {
        try {
            const formData = new FormData();
            formData.append('file', fs.createReadStream(filePath));

            const response = await axios.post(`${this.baseUrl}/id_documents`, formData, {
                headers: {
                    'Authorization': `Bearer ${this.apiKey}`,
                    ...formData.getHeaders()
                }
            });

            return {
                success: true,
                extractedData: response.data,
                confidence: response.data.confidence || 0.85
            };
        } catch (error) {
            console.error('Affinda ID extraction error:', error.response?.data || error.message);
            return { success: false, error: error.message };
        }
    }

    async processCertificate(filePath) {
        try {
            const formData = new FormData();
            formData.append('file', fs.createReadStream(filePath));

            const response = await axios.post(`${this.baseUrl}/certificates`, formData, {
                headers: {
                    'Authorization': `Bearer ${this.apiKey}`,
                    ...formData.getHeaders()
                }
            });

            return {
                success: true,
                certificateData: response.data,
                confidence: response.data.confidence || 0.8
            };
        } catch (error) {
            console.error('Affinda certificate extraction error:', error.response?.data || error.message);
            return { success: false, error: error.message };
        }
    }
}

module.exports = AffindaService;

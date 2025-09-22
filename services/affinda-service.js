require('dotenv').config();
const fs = require('fs');
const path = require('path');
const { AffindaAPI, AffindaCredential } = require('@affinda/affinda');

class AffindaService {
    constructor() {
        const credential = new AffindaCredential(process.env.AFFINDA_API_KEY);
        this.client = new AffindaAPI(credential);
        this.workspaceId = process.env.WORKSPACE_ID;
    }

    async processIDDocument(filePath) {
        try {
            const fileStream = fs.createReadStream(filePath);
            const fileName = path.basename(filePath);

            const doc = await this.client.createDocument({
                file: fileStream,
                workspace: this.workspaceId,
                fileName,
                documentType: "IDAndPassport"
            });

            const fields = doc.data?.extractedFields || {};

            // Defensive mapping for ID and Passport
            const mappedData = {
                first_name: fields.givenNames || '',
                surname: fields.surname || '',
                id_number: fields.identityNumber || '',
                country: fields.nationality || fields.countryCode || '',
                date_of_birth: fields.dateOfBirth || '',
                gender: fields.sex || ''
            };

            return {
                success: true,
                extractedData: mappedData,
                confidence: doc.data?.confidence || 0.85
            };

        } catch (error) {
            console.error('Affinda ID extraction error:', error.response?.data || error.message);
            return { success: false, error: error.message };
        }
    }

    async processCertificate(filePath) {
        try {
            const fileStream = fs.createReadStream(filePath);
            const fileName = path.basename(filePath);

            const doc = await this.client.createDocument({
                file: fileStream,
                workspace: this.workspaceId,
                fileName,
                documentType: "Certificate"
            });

            return {
                success: true,
                certificateData: doc.data?.extractedFields || {},
                confidence: doc.data?.confidence || 0.8
            };

        } catch (error) {
            console.error('Affinda certificate extraction error:', error.response?.data || error.message);
            return { success: false, error: error.message };
        }
    }
}

module.exports = AffindaService;

-- Update script to add missing fields to application_sessions table
-- This script should be run against the database to update the structure

-- First check if the columns already exist, if not add them
ALTER TABLE application_sessions 
ADD COLUMN IF NOT EXISTS user_agent text DEFAULT NULL,
ADD COLUMN IF NOT EXISTS ip_address varchar(45) DEFAULT NULL,
ADD COLUMN IF NOT EXISTS legal_agreements_accepted longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(legal_agreements_accepted)),
ADD COLUMN IF NOT EXISTS legal_accepted_at timestamp NULL DEFAULT NULL,
ADD COLUMN IF NOT EXISTS updated_at timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp();

-- Update existing records to have updated_at = created_at for consistency
UPDATE application_sessions SET updated_at = created_at WHERE updated_at IS NULL;

-- For MariaDB/MySQL that doesn't support IF NOT EXISTS, use this alternative:
-- You can run this manually if the above doesn't work

-- SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS 
-- WHERE TABLE_SCHEMA = 'jobscootercoz614_jobscooter' 
-- AND TABLE_NAME = 'application_sessions' 
-- AND COLUMN_NAME = 'user_agent';

-- If the above query returns no results, run these:
-- ALTER TABLE application_sessions ADD user_agent text DEFAULT NULL;
-- ALTER TABLE application_sessions ADD ip_address varchar(45) DEFAULT NULL;
-- ALTER TABLE application_sessions ADD legal_agreements_accepted longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL;
-- ALTER TABLE application_sessions ADD legal_accepted_at timestamp NULL DEFAULT NULL;
-- ALTER TABLE application_sessions ADD updated_at timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp();

-- Also add missing fields to applicants table
-- Check and add email_verification_token field
ALTER TABLE applicants 
ADD COLUMN IF NOT EXISTS email_verification_token varchar(255) DEFAULT NULL,
ADD COLUMN IF NOT EXISTS manual_id_entry tinyint(1) DEFAULT 0;

-- For MariaDB/MySQL that doesn't support IF NOT EXISTS, use these:
-- ALTER TABLE applicants ADD email_verification_token varchar(255) DEFAULT NULL;
-- ALTER TABLE applicants ADD manual_id_entry tinyint(1) DEFAULT 0;

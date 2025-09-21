-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 17, 2025 at 07:20 PM
-- Server version: 10.11.14-MariaDB
-- PHP Version: 8.3.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `jobscootercoz614_jobscooter`
--

DELIMITER $$
--
-- Procedures
--
$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `accredited_institutions`
--

CREATE TABLE `accredited_institutions` (
  `id` int(11) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `institution_type` varchar(100) DEFAULT NULL,
  `accreditation_body` varchar(100) DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT 1,
  `website_url` varchar(255) DEFAULT NULL,
  `verification_patterns` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `accredited_institutions`
--

INSERT INTO `accredited_institutions` (`id`, `name`, `country`, `institution_type`, `accreditation_body`, `is_verified`, `website_url`, `verification_patterns`, `created_at`) VALUES
(1, 'University of Cape Town', 'South Africa', 'University', 'CHE', 1, 'https://www.uct.ac.za', '{\"patterns\": [\"uct.ac.za\", \"University of Cape Town\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 11:59:24'),
(2, 'University of the Witwatersrand', 'South Africa', 'University', 'CHE', 1, 'https://www.wits.ac.za', '{\"patterns\": [\"wits.ac.za\", \"University of the Witwatersrand\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 11:59:24'),
(3, 'Stellenbosch University', 'South Africa', 'University', 'CHE', 1, 'https://www.sun.ac.za', '{\"patterns\": [\"sun.ac.za\", \"Stellenbosch University\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 11:59:24'),
(4, 'University of Pretoria', 'South Africa', 'University', 'CHE', 1, 'https://www.up.ac.za', '{\"patterns\": [\"up.ac.za\", \"University of Pretoria\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 11:59:24'),
(5, 'University of Johannesburg', 'South Africa', 'University', 'CHE', 1, 'https://www.uj.ac.za', '{\"patterns\": [\"uj.ac.za\", \"University of Johannesburg\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 11:59:24'),
(6, 'Cape Peninsula University of Technology', 'South Africa', 'University of Technology', 'CHE', 1, 'https://www.cput.ac.za', '{\"patterns\": [\"cput.ac.za\", \"Cape Peninsula University of Technology\"], \"certificate_keywords\": [\"National Diploma\", \"Bachelor\", \"Advanced Diploma\"]}', '2025-09-12 11:59:24'),
(7, 'Durban University of Technology', 'South Africa', 'University of Technology', 'CHE', 1, 'https://www.dut.ac.za', '{\"patterns\": [\"dut.ac.za\", \"Durban University of Technology\"], \"certificate_keywords\": [\"National Diploma\", \"Bachelor\", \"Advanced Diploma\"]}', '2025-09-12 11:59:24'),
(8, 'Tshwane University of Technology', 'South Africa', 'University of Technology', 'CHE', 1, 'https://www.tut.ac.za', '{\"patterns\": [\"tut.ac.za\", \"Tshwane University of Technology\"], \"certificate_keywords\": [\"National Diploma\", \"Bachelor\", \"Advanced Diploma\"]}', '2025-09-12 11:59:24'),
(9, 'University of KwaZulu-Natal', 'South Africa', 'University', 'CHE', 1, 'https://www.ukzn.ac.za', '{\"patterns\": [\"ukzn.ac.za\", \"University of KwaZulu-Natal\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 11:59:24'),
(10, 'Rhodes University', 'South Africa', 'University', 'CHE', 1, 'https://www.ru.ac.za', '{\"patterns\": [\"ru.ac.za\", \"Rhodes University\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 11:59:24'),
(11, 'Nelson Mandela University', 'South Africa', 'University', 'CHE', 1, 'https://www.mandela.ac.za', '{\"patterns\": [\"mandela.ac.za\", \"Nelson Mandela University\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 11:59:24'),
(12, 'North-West University', 'South Africa', 'University', 'CHE', 1, 'https://www.nwu.ac.za', '{\"patterns\": [\"nwu.ac.za\", \"North-West University\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 11:59:24'),
(13, 'University of the Free State', 'South Africa', 'University', 'CHE', 1, 'https://www.ufs.ac.za', '{\"patterns\": [\"ufs.ac.za\", \"University of the Free State\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 11:59:24'),
(14, 'University of Limpopo', 'South Africa', 'University', 'CHE', 1, 'https://www.ul.ac.za', '{\"patterns\": [\"ul.ac.za\", \"University of Limpopo\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 11:59:24'),
(15, 'University of Venda', 'South Africa', 'University', 'CHE', 1, 'https://www.univen.ac.za', '{\"patterns\": [\"univen.ac.za\", \"University of Venda\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 11:59:24'),
(16, 'Walter Sisulu University', 'South Africa', 'University', 'CHE', 1, 'https://www.wsu.ac.za', '{\"patterns\": [\"wsu.ac.za\", \"Walter Sisulu University\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 11:59:24'),
(17, 'Sefako Makgatho Health Sciences University', 'South Africa', 'University', 'CHE', 1, 'https://www.smu.ac.za', '{\"patterns\": [\"smu.ac.za\", \"Sefako Makgatho Health Sciences University\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 11:59:24'),
(18, 'University of Fort Hare', 'South Africa', 'University', 'CHE', 1, 'https://www.ufh.ac.za', '{\"patterns\": [\"ufh.ac.za\", \"University of Fort Hare\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 11:59:24'),
(19, 'University of Zululand', 'South Africa', 'University', 'CHE', 1, 'https://www.unizulu.ac.za', '{\"patterns\": [\"unizulu.ac.za\", \"University of Zululand\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 11:59:24'),
(20, 'Sol Plaatje University', 'South Africa', 'University', 'CHE', 1, 'https://www.spu.ac.za', '{\"patterns\": [\"spu.ac.za\", \"Sol Plaatje University\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 11:59:24'),
(21, 'British Council', 'United Kingdom', 'Language Testing Organization', 'EAQUALS', 1, 'https://www.britishcouncil.org', '{\"patterns\": [\"British Council\", \"IELTS\"], \"certificate_keywords\": [\"IELTS\", \"English\", \"Language Certificate\"]}', '2025-09-12 11:59:24'),
(22, 'Goethe-Institut', 'Germany', 'Language Testing Organization', 'ALTE', 1, 'https://www.goethe.de', '{\"patterns\": [\"Goethe-Institut\", \"Goethe Institute\"], \"certificate_keywords\": [\"German\", \"Deutsch\", \"Sprachdiplom\"]}', '2025-09-12 11:59:24'),
(23, 'Alliance Française', 'France', 'Language Testing Organization', 'EAQUALS', 1, 'https://www.alliancefr.org', '{\"patterns\": [\"Alliance Française\"], \"certificate_keywords\": [\"French\", \"Français\", \"DELF\", \"DALF\"]}', '2025-09-12 11:59:24'),
(24, 'Instituto Cervantes', 'Spain', 'Language Testing Organization', 'ALTE', 1, 'https://www.cervantes.es', '{\"patterns\": [\"Instituto Cervantes\"], \"certificate_keywords\": [\"Spanish\", \"Español\", \"DELE\"]}', '2025-09-12 11:59:24'),
(25, 'Confucius Institute', 'China', 'Language Testing Organization', 'HANBAN', 1, 'https://www.chinese.cn', '{\"patterns\": [\"Confucius Institute\"], \"certificate_keywords\": [\"Chinese\", \"Mandarin\", \"HSK\"]}', '2025-09-12 11:59:24'),
(26, 'University of Cape Town', 'South Africa', 'University', 'CHE', 1, 'https://www.uct.ac.za', '{\"patterns\": [\"uct.ac.za\", \"University of Cape Town\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 12:20:39'),
(27, 'University of the Witwatersrand', 'South Africa', 'University', 'CHE', 1, 'https://www.wits.ac.za', '{\"patterns\": [\"wits.ac.za\", \"University of the Witwatersrand\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 12:20:39'),
(28, 'Stellenbosch University', 'South Africa', 'University', 'CHE', 1, 'https://www.sun.ac.za', '{\"patterns\": [\"sun.ac.za\", \"Stellenbosch University\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 12:20:39'),
(29, 'University of Pretoria', 'South Africa', 'University', 'CHE', 1, 'https://www.up.ac.za', '{\"patterns\": [\"up.ac.za\", \"University of Pretoria\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 12:20:39'),
(30, 'University of Johannesburg', 'South Africa', 'University', 'CHE', 1, 'https://www.uj.ac.za', '{\"patterns\": [\"uj.ac.za\", \"University of Johannesburg\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 12:20:39'),
(31, 'Cape Peninsula University of Technology', 'South Africa', 'University of Technology', 'CHE', 1, 'https://www.cput.ac.za', '{\"patterns\": [\"cput.ac.za\", \"Cape Peninsula University of Technology\"], \"certificate_keywords\": [\"National Diploma\", \"Bachelor\", \"Advanced Diploma\"]}', '2025-09-12 12:20:39'),
(32, 'Durban University of Technology', 'South Africa', 'University of Technology', 'CHE', 1, 'https://www.dut.ac.za', '{\"patterns\": [\"dut.ac.za\", \"Durban University of Technology\"], \"certificate_keywords\": [\"National Diploma\", \"Bachelor\", \"Advanced Diploma\"]}', '2025-09-12 12:20:39'),
(33, 'Tshwane University of Technology', 'South Africa', 'University of Technology', 'CHE', 1, 'https://www.tut.ac.za', '{\"patterns\": [\"tut.ac.za\", \"Tshwane University of Technology\"], \"certificate_keywords\": [\"National Diploma\", \"Bachelor\", \"Advanced Diploma\"]}', '2025-09-12 12:20:39'),
(34, 'University of KwaZulu-Natal', 'South Africa', 'University', 'CHE', 1, 'https://www.ukzn.ac.za', '{\"patterns\": [\"ukzn.ac.za\", \"University of KwaZulu-Natal\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 12:20:39'),
(35, 'Rhodes University', 'South Africa', 'University', 'CHE', 1, 'https://www.ru.ac.za', '{\"patterns\": [\"ru.ac.za\", \"Rhodes University\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 12:20:39'),
(36, 'Nelson Mandela University', 'South Africa', 'University', 'CHE', 1, 'https://www.mandela.ac.za', '{\"patterns\": [\"mandela.ac.za\", \"Nelson Mandela University\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 12:20:39'),
(37, 'North-West University', 'South Africa', 'University', 'CHE', 1, 'https://www.nwu.ac.za', '{\"patterns\": [\"nwu.ac.za\", \"North-West University\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 12:20:39'),
(38, 'University of the Free State', 'South Africa', 'University', 'CHE', 1, 'https://www.ufs.ac.za', '{\"patterns\": [\"ufs.ac.za\", \"University of the Free State\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 12:20:39'),
(39, 'University of Limpopo', 'South Africa', 'University', 'CHE', 1, 'https://www.ul.ac.za', '{\"patterns\": [\"ul.ac.za\", \"University of Limpopo\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 12:20:39'),
(40, 'University of Venda', 'South Africa', 'University', 'CHE', 1, 'https://www.univen.ac.za', '{\"patterns\": [\"univen.ac.za\", \"University of Venda\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 12:20:39'),
(41, 'Walter Sisulu University', 'South Africa', 'University', 'CHE', 1, 'https://www.wsu.ac.za', '{\"patterns\": [\"wsu.ac.za\", \"Walter Sisulu University\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 12:20:39'),
(42, 'Sefako Makgatho Health Sciences University', 'South Africa', 'University', 'CHE', 1, 'https://www.smu.ac.za', '{\"patterns\": [\"smu.ac.za\", \"Sefako Makgatho Health Sciences University\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 12:20:39'),
(43, 'University of Fort Hare', 'South Africa', 'University', 'CHE', 1, 'https://www.ufh.ac.za', '{\"patterns\": [\"ufh.ac.za\", \"University of Fort Hare\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 12:20:39'),
(44, 'University of Zululand', 'South Africa', 'University', 'CHE', 1, 'https://www.unizulu.ac.za', '{\"patterns\": [\"unizulu.ac.za\", \"University of Zululand\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 12:20:39'),
(45, 'Sol Plaatje University', 'South Africa', 'University', 'CHE', 1, 'https://www.spu.ac.za', '{\"patterns\": [\"spu.ac.za\", \"Sol Plaatje University\"], \"certificate_keywords\": [\"Bachelor\", \"Master\", \"Doctor\", \"Diploma\"]}', '2025-09-12 12:20:39'),
(46, 'British Council', 'United Kingdom', 'Language Testing Organization', 'EAQUALS', 1, 'https://www.britishcouncil.org', '{\"patterns\": [\"British Council\", \"IELTS\"], \"certificate_keywords\": [\"IELTS\", \"English\", \"Language Certificate\"]}', '2025-09-12 12:20:39'),
(47, 'Goethe-Institut', 'Germany', 'Language Testing Organization', 'ALTE', 1, 'https://www.goethe.de', '{\"patterns\": [\"Goethe-Institut\", \"Goethe Institute\"], \"certificate_keywords\": [\"German\", \"Deutsch\", \"Sprachdiplom\"]}', '2025-09-12 12:20:39'),
(48, 'Alliance Française', 'France', 'Language Testing Organization', 'EAQUALS', 1, 'https://www.alliancefr.org', '{\"patterns\": [\"Alliance Française\"], \"certificate_keywords\": [\"French\", \"Français\", \"DELF\", \"DALF\"]}', '2025-09-12 12:20:39'),
(49, 'Instituto Cervantes', 'Spain', 'Language Testing Organization', 'ALTE', 1, 'https://www.cervantes.es', '{\"patterns\": [\"Instituto Cervantes\"], \"certificate_keywords\": [\"Spanish\", \"Español\", \"DELE\"]}', '2025-09-12 12:20:39'),
(50, 'Confucius Institute', 'China', 'Language Testing Organization', 'HANBAN', 1, 'https://www.chinese.cn', '{\"patterns\": [\"Confucius Institute\"], \"certificate_keywords\": [\"Chinese\", \"Mandarin\", \"HSK\"]}', '2025-09-12 12:20:39'),
(51, 'British Council', 'United Kingdom', 'Language Testing Organization', 'EAQUALS', 1, 'https://www.britishcouncil.org', '{\"patterns\": [\"British Council\", \"IELTS\"], \"certificate_keywords\": [\"IELTS\", \"English\", \"Language Certificate\"]}', '2025-09-12 12:37:06'),
(52, 'Goethe-Institut', 'Germany', 'Language Testing Organization', 'ALTE', 1, 'https://www.goethe.de', '{\"patterns\": [\"Goethe-Institut\", \"Goethe Institute\"], \"certificate_keywords\": [\"German\", \"Deutsch\", \"Sprachdiplom\"]}', '2025-09-12 12:37:06'),
(53, 'Alliance Française', 'France', 'Language Testing Organization', 'EAQUALS', 1, 'https://www.alliancefr.org', '{\"patterns\": [\"Alliance Française\"], \"certificate_keywords\": [\"French\", \"Français\", \"DELF\", \"DALF\"]}', '2025-09-12 12:37:06'),
(54, 'Instituto Cervantes', 'Spain', 'Language Testing Organization', 'ALTE', 1, 'https://www.cervantes.es', '{\"patterns\": [\"Instituto Cervantes\"], \"certificate_keywords\": [\"Spanish\", \"Español\", \"DELE\"]}', '2025-09-12 12:37:06'),
(55, 'Confucius Institute', 'China', 'Language Testing Organization', 'HANBAN', 1, 'https://www.chinese.cn', '{\"patterns\": [\"Confucius Institute\"], \"certificate_keywords\": [\"Chinese\", \"Mandarin\", \"HSK\"]}', '2025-09-12 12:37:06'),
(56, 'University of Cape Town', 'South Africa', 'University', 'CHE', 1, 'https://uct.ac.za', NULL, '2025-09-13 16:32:39'),
(57, 'Stellenbosch University', 'South Africa', 'University', 'CHE', 1, 'https://sun.ac.za', NULL, '2025-09-13 16:32:39'),
(58, 'University of the Witwatersrand', 'South Africa', 'University', 'CHE', 1, 'https://wits.ac.za', NULL, '2025-09-13 16:32:39'),
(59, 'Cape Peninsula University of Technology', 'South Africa', 'University of Technology', 'CHE', 1, 'https://cput.ac.za', NULL, '2025-09-13 16:32:39'),
(60, 'Goethe Institute', 'Germany', 'Language Institution', 'DIF', 1, 'https://goethe.de', NULL, '2025-09-13 16:32:39');

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_type` varchar(20) DEFAULT 'applicant',
  `activity_type` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`details`)),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`id`, `user_id`, `user_type`, `activity_type`, `description`, `details`, `ip_address`, `user_agent`, `created_at`) VALUES
(1, 9, 'applicant', 'profile_created', 'User profile created successfully', '{\"profile_completion\": 100}', NULL, NULL, '2025-09-15 12:08:35'),
(2, 9, 'applicant', 'document_uploaded', 'Certificate uploaded and processed', '{\"document_type\": \"certificate\", \"ai_verified\": true}', NULL, NULL, '2025-09-15 12:08:35'),
(3, 9, 'applicant', 'traffic_light_updated', 'Traffic light status updated to yellow', '{\"previous_status\": \"red\", \"new_status\": \"yellow\", \"score\": 62}', NULL, NULL, '2025-09-15 12:08:35'),
(4, 1, 'admin', 'system_migration', 'Database migration completed successfully', '{\"migration_timestamp\": \"2025-09-15 14:08:35\", \"version\": \"2.0.0\", \"features_added\": [\"cv_generation\", \"activity_logs\", \"enhanced_scoring\"]}', NULL, NULL, '2025-09-15 12:08:35');

-- --------------------------------------------------------

--
-- Table structure for table `applicants`
--

CREATE TABLE `applicants` (
  `id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `surname` varchar(100) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `id_number` varchar(50) DEFAULT NULL,
  `profile_picture_url` varchar(500) DEFAULT NULL,
  `video_intro_url` varchar(500) DEFAULT NULL,
  `video_transcript` text DEFAULT NULL,
  `auto_cv_url` varchar(500) DEFAULT NULL,
  `public_profile_url` varchar(100) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'pending',
  `traffic_light_status` varchar(10) DEFAULT 'red',
  `traffic_light_score` int(11) DEFAULT 0,
  `completion_percentage` int(11) DEFAULT 0,
  `is_verified` tinyint(1) DEFAULT 0,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `id_extraction_confidence` decimal(3,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `nationality` varchar(100) DEFAULT NULL,
  `manual_entry` tinyint(1) DEFAULT 0,
  `user_type` varchar(20) DEFAULT 'applicant',
  `last_login` timestamp NULL DEFAULT NULL,
  `login_attempts` int(11) DEFAULT 0,
  `locked_until` timestamp NULL DEFAULT NULL,
  `two_factor_enabled` tinyint(1) DEFAULT 0,
  `two_factor_secret` varchar(255) DEFAULT NULL,
  `email_verification_token` varchar(255) DEFAULT NULL,
  `manual_id_entry` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `applicants`
--

INSERT INTO `applicants` (`id`, `username`, `password_hash`, `first_name`, `surname`, `email`, `phone`, `country`, `id_number`, `profile_picture_url`, `video_intro_url`, `video_transcript`, `auto_cv_url`, `public_profile_url`, `status`, `traffic_light_status`, `traffic_light_score`, `completion_percentage`, `is_verified`, `email_verified_at`, `id_extraction_confidence`, `created_at`, `updated_at`, `date_of_birth`, `gender`, `nationality`, `manual_entry`, `user_type`, `last_login`, `login_attempts`, `locked_until`, `two_factor_enabled`, `two_factor_secret`) VALUES
(10, 'admin', '$2b$12$LQv3c1yqBwlFNPhR5YDaQOk6cM4e1FEhEnHdLZqNl2QwZN5ZqtCWa', 'System', 'Administrator', 'admin@jobscooter.co.za', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', 'green', 0, 0, 1, NULL, 0.00, '2025-09-15 12:08:35', '2025-09-15 12:08:35', NULL, NULL, NULL, 0, 'admin', NULL, 0, NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `applicant_privacy_settings`
--

CREATE TABLE `applicant_privacy_settings` (
  `id` int(11) NOT NULL,
  `applicant_id` int(11) NOT NULL,
  `profile_visibility` varchar(20) DEFAULT 'public',
  `show_contact_info_to_subscribers` tinyint(1) DEFAULT 1,
  `show_certificates_to_public` tinyint(1) DEFAULT 0,
  `show_full_cv_to_subscribers` tinyint(1) DEFAULT 1,
  `allow_contact_requests` tinyint(1) DEFAULT 1,
  `auto_accept_contact_from_verified` tinyint(1) DEFAULT 0,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `applicant_profiles_with_scores`
-- (See below for the actual view)
--
CREATE TABLE `applicant_profiles_with_scores` (
`id` int(11)
,`username` varchar(50)
,`password_hash` varchar(255)
,`first_name` varchar(100)
,`surname` varchar(100)
,`email` varchar(255)
,`phone` varchar(20)
,`country` varchar(50)
,`id_number` varchar(50)
,`profile_picture_url` varchar(500)
,`video_intro_url` varchar(500)
,`video_transcript` text
,`auto_cv_url` varchar(500)
,`public_profile_url` varchar(100)
,`status` varchar(20)
,`traffic_light_status` varchar(10)
,`traffic_light_score` int(11)
,`completion_percentage` int(11)
,`is_verified` tinyint(1)
,`email_verified_at` timestamp
,`id_extraction_confidence` decimal(3,2)
,`created_at` timestamp
,`updated_at` timestamp
,`date_of_birth` date
,`gender` varchar(10)
,`nationality` varchar(100)
,`manual_entry` tinyint(1)
,`user_type` varchar(20)
,`last_login` timestamp
,`login_attempts` int(11)
,`locked_until` timestamp
,`two_factor_enabled` tinyint(1)
,`two_factor_secret` varchar(255)
,`total_score` int(11)
,`identity_score` int(11)
,`certificate_score` int(11)
,`completeness_score` int(11)
,`language_score` int(11)
,`consistency_score` int(11)
,`calculated_status` varchar(10)
,`certificate_count` bigint(21)
,`language_count` bigint(21)
,`profile_url_slug` varchar(100)
,`profile_views` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `application_sessions`
--

CREATE TABLE `application_sessions` (
  `id` int(11) NOT NULL,
  `session_token` varchar(255) DEFAULT NULL,
  `extracted_data` text DEFAULT NULL,
  `step_completed` int(11) DEFAULT 0,
  `user_agent` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `legal_agreements_accepted` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`legal_agreements_accepted`)),
  `legal_accepted_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `billing_history`
--

CREATE TABLE `billing_history` (
  `id` int(11) NOT NULL,
  `subscriber_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `currency` varchar(3) DEFAULT 'USD',
  `billing_period_start` date DEFAULT NULL,
  `billing_period_end` date DEFAULT NULL,
  `payment_status` varchar(20) DEFAULT 'pending',
  `payment_method` varchar(50) DEFAULT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `invoice_url` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `paid_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `certificates`
--

CREATE TABLE `certificates` (
  `id` int(11) NOT NULL,
  `applicant_id` int(11) DEFAULT NULL,
  `original_filename` varchar(255) DEFAULT NULL,
  `file_path` varchar(500) DEFAULT NULL,
  `certificate_type` varchar(50) DEFAULT NULL,
  `document_classification` varchar(50) DEFAULT NULL,
  `extracted_data` text DEFAULT NULL,
  `institution_name` varchar(200) DEFAULT NULL,
  `field_of_study` varchar(200) DEFAULT NULL,
  `grade_level` varchar(100) DEFAULT NULL,
  `date_issued` date DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT 0,
  `is_accredited` tinyint(1) DEFAULT 0,
  `authenticity_score` int(11) DEFAULT 0,
  `validation_notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `file_size` int(11) DEFAULT 0,
  `mime_type` varchar(100) DEFAULT NULL,
  `processing_status` varchar(20) DEFAULT 'pending',
  `ai_confidence` decimal(5,4) DEFAULT 0.0000,
  `manual_review_required` tinyint(1) DEFAULT 0,
  `reviewed_by` int(11) DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `certificates`
--
DELIMITER $$
CREATE TRIGGER `certificate_traffic_light_update` AFTER INSERT ON `certificates` FOR EACH ROW BEGIN
    CALL CalculateTrafficLightScore(NEW.applicant_id);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `certificate_traffic_light_update_on_verify` AFTER UPDATE ON `certificates` FOR EACH ROW BEGIN
    IF OLD.is_verified != NEW.is_verified THEN
        CALL CalculateTrafficLightScore(NEW.applicant_id);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `contact_requests`
--

CREATE TABLE `contact_requests` (
  `id` int(11) NOT NULL,
  `applicant_id` int(11) NOT NULL,
  `subscriber_id` int(11) NOT NULL,
  `message` text DEFAULT NULL,
  `job_title` varchar(200) DEFAULT NULL,
  `job_description` text DEFAULT NULL,
  `company_details` text DEFAULT NULL,
  `status` varchar(20) DEFAULT 'pending',
  `applicant_response` text DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `responded_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cv_generations`
--

CREATE TABLE `cv_generations` (
  `id` int(11) NOT NULL,
  `applicant_id` int(11) NOT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `template` varchar(50) NOT NULL DEFAULT 'professional',
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`options`)),
  `file_size` int(11) DEFAULT 0,
  `download_count` int(11) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_downloaded` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `language_verifications`
--

CREATE TABLE `language_verifications` (
  `id` int(11) NOT NULL,
  `applicant_id` int(11) DEFAULT NULL,
  `language` varchar(50) DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT 0,
  `certificate_id` int(11) DEFAULT NULL,
  `verification_method` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `profile_views`
--

CREATE TABLE `profile_views` (
  `id` int(11) NOT NULL,
  `profile_id` int(11) DEFAULT NULL,
  `viewer_id` int(11) DEFAULT NULL,
  `viewer_type` varchar(50) DEFAULT NULL,
  `viewed_fields` text DEFAULT NULL,
  `view_timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `session_id` varchar(255) DEFAULT NULL,
  `referrer` varchar(500) DEFAULT NULL,
  `device_type` varchar(50) DEFAULT NULL,
  `browser` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `public_profiles`
--

CREATE TABLE `public_profiles` (
  `id` int(11) NOT NULL,
  `applicant_id` int(11) DEFAULT NULL,
  `profile_url_slug` varchar(100) DEFAULT NULL,
  `public_fields` text DEFAULT NULL,
  `view_count` int(11) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscribers`
--

CREATE TABLE `subscribers` (
  `id` int(11) NOT NULL,
  `company_name` varchar(200) DEFAULT NULL,
  `contact_person` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `industry` varchar(100) DEFAULT NULL,
  `company_size` varchar(50) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `subscription_tier_id` int(11) DEFAULT NULL,
  `subscription_status` varchar(20) DEFAULT 'active',
  `subscription_expires_at` timestamp NULL DEFAULT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `monthly_views_used` int(11) DEFAULT 0,
  `last_billing_date` timestamp NULL DEFAULT NULL,
  `next_billing_date` timestamp NULL DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT 0,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `user_type` varchar(20) DEFAULT 'employer',
  `last_login` timestamp NULL DEFAULT NULL,
  `login_attempts` int(11) DEFAULT 0,
  `locked_until` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `subscriber_statistics`
-- (See below for the actual view)
--
CREATE TABLE `subscriber_statistics` (
`id` int(11)
,`company_name` varchar(200)
,`contact_person` varchar(100)
,`email` varchar(255)
,`phone` varchar(20)
,`country` varchar(50)
,`industry` varchar(100)
,`company_size` varchar(50)
,`password_hash` varchar(255)
,`subscription_tier_id` int(11)
,`subscription_status` varchar(20)
,`subscription_expires_at` timestamp
,`trial_ends_at` timestamp
,`monthly_views_used` int(11)
,`last_billing_date` timestamp
,`next_billing_date` timestamp
,`payment_method` varchar(50)
,`is_verified` tinyint(1)
,`email_verified_at` timestamp
,`created_at` timestamp
,`updated_at` timestamp
,`user_type` varchar(20)
,`last_login` timestamp
,`login_attempts` int(11)
,`locked_until` timestamp
,`total_profile_views` bigint(21)
,`unique_profiles_viewed` bigint(21)
,`contact_requests_sent` bigint(21)
,`tier_name` varchar(50)
,`max_profile_views_per_month` int(11)
,`can_view_contact_info` tinyint(1)
,`can_download_cv` tinyint(1)
);

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `subscription_type` varchar(50) DEFAULT NULL,
  `features` text DEFAULT NULL,
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subscriptions`
--

INSERT INTO `subscriptions` (`id`, `user_id`, `subscription_type`, `features`, `expires_at`, `is_active`, `created_at`) VALUES
(1, 1, 'premium', '{\"profile_access\": \"full\", \"contact_info\": true, \"cv_download\": true, \"analytics\": true}', '2024-12-31 21:59:59', 1, '2025-09-12 12:37:06'),
(2, 2, 'basic', '{\"profile_access\": \"limited\", \"contact_info\": false, \"cv_download\": false, \"analytics\": false}', '2024-12-31 21:59:59', 1, '2025-09-12 12:37:06'),
(3, 3, 'viewer', '{\"profile_access\": \"public\", \"contact_info\": false, \"cv_download\": false, \"analytics\": false}', '2024-12-31 21:59:59', 1, '2025-09-12 12:37:06'),
(4, 1, 'premium', '{\"profile_access\": \"full\", \"contact_info\": true, \"cv_download\": true, \"analytics\": true}', '2024-12-31 21:59:59', 1, '2025-09-12 12:37:27'),
(5, 2, 'basic', '{\"profile_access\": \"limited\", \"contact_info\": false, \"cv_download\": false, \"analytics\": false}', '2024-12-31 21:59:59', 1, '2025-09-12 12:37:27'),
(6, 3, 'viewer', '{\"profile_access\": \"public\", \"contact_info\": false, \"cv_download\": false, \"analytics\": false}', '2024-12-31 21:59:59', 1, '2025-09-12 12:37:27');

-- --------------------------------------------------------

--
-- Table structure for table `subscription_tiers`
--

CREATE TABLE `subscription_tiers` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `display_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price_monthly` decimal(10,2) DEFAULT 0.00,
  `features` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`features`)),
  `max_profile_views_per_month` int(11) DEFAULT 0,
  `can_view_contact_info` tinyint(1) DEFAULT 0,
  `can_view_certificates` tinyint(1) DEFAULT 0,
  `can_view_full_cv` tinyint(1) DEFAULT 0,
  `can_download_cv` tinyint(1) DEFAULT 0,
  `can_contact_applicant` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subscription_tiers`
--

INSERT INTO `subscription_tiers` (`id`, `name`, `display_name`, `description`, `price_monthly`, `features`, `max_profile_views_per_month`, `can_view_contact_info`, `can_view_certificates`, `can_view_full_cv`, `can_download_cv`, `can_contact_applicant`, `is_active`, `created_at`) VALUES
(1, 'viewer', 'Free Viewer', 'Basic access to public profiles', 0.00, NULL, 10, 0, 0, 0, 0, 0, 1, '2025-09-13 16:51:24'),
(2, 'basic', 'Basic Recruiter', 'Access to contact info and basic certificates', 29.99, NULL, 100, 1, 1, 0, 0, 1, 1, '2025-09-13 16:51:24'),
(3, 'premium', 'Premium Recruiter', 'Full access to all profiles and CV downloads', 99.99, NULL, 0, 1, 1, 1, 1, 1, 1, '2025-09-13 16:51:24');

-- --------------------------------------------------------

--
-- Table structure for table `traffic_light_scores`
--

CREATE TABLE `traffic_light_scores` (
  `id` int(11) NOT NULL,
  `applicant_id` int(11) DEFAULT NULL,
  `identity_score` int(11) DEFAULT 0,
  `language_score` int(11) DEFAULT 0,
  `certificate_score` int(11) DEFAULT 0,
  `completeness_score` int(11) DEFAULT 0,
  `consistency_score` int(11) DEFAULT 0,
  `total_score` int(11) DEFAULT 0,
  `status` varchar(10) DEFAULT 'red',
  `improvement_suggestions` text DEFAULT NULL,
  `calculated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accredited_institutions`
--
ALTER TABLE `accredited_institutions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_activity_logs_user` (`user_id`,`user_type`),
  ADD KEY `idx_activity_logs_type` (`activity_type`),
  ADD KEY `idx_activity_logs_timestamp` (`created_at`);

--
-- Indexes for table `applicants`
--
ALTER TABLE `applicants`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `public_profile_url` (`public_profile_url`),
  ADD KEY `idx_applicants_email` (`email`),
  ADD KEY `idx_applicants_username` (`username`),
  ADD KEY `idx_applicants_user_type` (`user_type`),
  ADD KEY `idx_applicants_last_login` (`last_login`);

--
-- Indexes for table `applicant_privacy_settings`
--
ALTER TABLE `applicant_privacy_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `applicant_id` (`applicant_id`);

--
-- Indexes for table `application_sessions`
--
ALTER TABLE `application_sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `session_token` (`session_token`);

--
-- Indexes for table `billing_history`
--
ALTER TABLE `billing_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_billing_history_subscriber` (`subscriber_id`);

--
-- Indexes for table `certificates`
--
ALTER TABLE `certificates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_certificates_applicant` (`applicant_id`),
  ADD KEY `idx_certificates_processing_status` (`processing_status`),
  ADD KEY `idx_certificates_ai_confidence` (`ai_confidence`);

--
-- Indexes for table `contact_requests`
--
ALTER TABLE `contact_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_contact_requests_applicant` (`applicant_id`),
  ADD KEY `idx_contact_requests_subscriber` (`subscriber_id`),
  ADD KEY `idx_contact_requests_status` (`status`);

--
-- Indexes for table `cv_generations`
--
ALTER TABLE `cv_generations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cv_generations_applicant` (`applicant_id`),
  ADD KEY `idx_cv_generations_generated_by` (`generated_by`),
  ADD KEY `idx_cv_generations_active` (`is_active`);

--
-- Indexes for table `language_verifications`
--
ALTER TABLE `language_verifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_language_verifications_applicant` (`applicant_id`);

--
-- Indexes for table `profile_views`
--
ALTER TABLE `profile_views`
  ADD PRIMARY KEY (`id`),
  ADD KEY `profile_id` (`profile_id`),
  ADD KEY `idx_profile_views_timestamp` (`view_timestamp`);

--
-- Indexes for table `public_profiles`
--
ALTER TABLE `public_profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `profile_url_slug` (`profile_url_slug`),
  ADD KEY `applicant_id` (`applicant_id`),
  ADD KEY `idx_public_profiles_slug` (`profile_url_slug`);

--
-- Indexes for table `subscribers`
--
ALTER TABLE `subscribers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_subscribers_email` (`email`),
  ADD KEY `idx_subscribers_subscription` (`subscription_tier_id`,`subscription_status`),
  ADD KEY `idx_subscribers_user_type` (`user_type`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscription_tiers`
--
ALTER TABLE `subscription_tiers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `traffic_light_scores`
--
ALTER TABLE `traffic_light_scores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_traffic_light_scores_applicant` (`applicant_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accredited_institutions`
--
ALTER TABLE `accredited_institutions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `applicants`
--
ALTER TABLE `applicants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `applicant_privacy_settings`
--
ALTER TABLE `applicant_privacy_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `application_sessions`
--
ALTER TABLE `application_sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `billing_history`
--
ALTER TABLE `billing_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `certificates`
--
ALTER TABLE `certificates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `contact_requests`
--
ALTER TABLE `contact_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cv_generations`
--
ALTER TABLE `cv_generations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `language_verifications`
--
ALTER TABLE `language_verifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `profile_views`
--
ALTER TABLE `profile_views`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `public_profiles`
--
ALTER TABLE `public_profiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `subscribers`
--
ALTER TABLE `subscribers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `subscription_tiers`
--
ALTER TABLE `subscription_tiers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `traffic_light_scores`
--
ALTER TABLE `traffic_light_scores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

-- --------------------------------------------------------

--
-- Structure for view `applicant_profiles_with_scores`
--
DROP TABLE IF EXISTS `applicant_profiles_with_scores`;

CREATE ALGORITHM=UNDEFINED DEFINER=`jobscootercoz614_jobscooter`@`localhost` SQL SECURITY DEFINER VIEW `applicant_profiles_with_scores`  AS SELECT `a`.`id` AS `id`, `a`.`username` AS `username`, `a`.`password_hash` AS `password_hash`, `a`.`first_name` AS `first_name`, `a`.`surname` AS `surname`, `a`.`email` AS `email`, `a`.`phone` AS `phone`, `a`.`country` AS `country`, `a`.`id_number` AS `id_number`, `a`.`profile_picture_url` AS `profile_picture_url`, `a`.`video_intro_url` AS `video_intro_url`, `a`.`video_transcript` AS `video_transcript`, `a`.`auto_cv_url` AS `auto_cv_url`, `a`.`public_profile_url` AS `public_profile_url`, `a`.`status` AS `status`, `a`.`traffic_light_status` AS `traffic_light_status`, `a`.`traffic_light_score` AS `traffic_light_score`, `a`.`completion_percentage` AS `completion_percentage`, `a`.`is_verified` AS `is_verified`, `a`.`email_verified_at` AS `email_verified_at`, `a`.`id_extraction_confidence` AS `id_extraction_confidence`, `a`.`created_at` AS `created_at`, `a`.`updated_at` AS `updated_at`, `a`.`date_of_birth` AS `date_of_birth`, `a`.`gender` AS `gender`, `a`.`nationality` AS `nationality`, `a`.`manual_entry` AS `manual_entry`, `a`.`user_type` AS `user_type`, `a`.`last_login` AS `last_login`, `a`.`login_attempts` AS `login_attempts`, `a`.`locked_until` AS `locked_until`, `a`.`two_factor_enabled` AS `two_factor_enabled`, `a`.`two_factor_secret` AS `two_factor_secret`, `tls`.`total_score` AS `total_score`, `tls`.`identity_score` AS `identity_score`, `tls`.`certificate_score` AS `certificate_score`, `tls`.`completeness_score` AS `completeness_score`, `tls`.`language_score` AS `language_score`, `tls`.`consistency_score` AS `consistency_score`, `tls`.`status` AS `calculated_status`, count(`c`.`id`) AS `certificate_count`, count(`lv`.`id`) AS `language_count`, `pp`.`profile_url_slug` AS `profile_url_slug`, `pp`.`view_count` AS `profile_views` FROM ((((`applicants` `a` left join `traffic_light_scores` `tls` on(`a`.`id` = `tls`.`applicant_id`)) left join `certificates` `c` on(`a`.`id` = `c`.`applicant_id`)) left join `language_verifications` `lv` on(`a`.`id` = `lv`.`applicant_id` and `lv`.`is_verified` = 1)) left join `public_profiles` `pp` on(`a`.`id` = `pp`.`applicant_id`)) GROUP BY `a`.`id` ;

-- --------------------------------------------------------

--
-- Structure for view `subscriber_statistics`
--
DROP TABLE IF EXISTS `subscriber_statistics`;

CREATE ALGORITHM=UNDEFINED DEFINER=`jobscootercoz614_jobscooter`@`localhost` SQL SECURITY DEFINER VIEW `subscriber_statistics`  AS SELECT `s`.`id` AS `id`, `s`.`company_name` AS `company_name`, `s`.`contact_person` AS `contact_person`, `s`.`email` AS `email`, `s`.`phone` AS `phone`, `s`.`country` AS `country`, `s`.`industry` AS `industry`, `s`.`company_size` AS `company_size`, `s`.`password_hash` AS `password_hash`, `s`.`subscription_tier_id` AS `subscription_tier_id`, `s`.`subscription_status` AS `subscription_status`, `s`.`subscription_expires_at` AS `subscription_expires_at`, `s`.`trial_ends_at` AS `trial_ends_at`, `s`.`monthly_views_used` AS `monthly_views_used`, `s`.`last_billing_date` AS `last_billing_date`, `s`.`next_billing_date` AS `next_billing_date`, `s`.`payment_method` AS `payment_method`, `s`.`is_verified` AS `is_verified`, `s`.`email_verified_at` AS `email_verified_at`, `s`.`created_at` AS `created_at`, `s`.`updated_at` AS `updated_at`, `s`.`user_type` AS `user_type`, `s`.`last_login` AS `last_login`, `s`.`login_attempts` AS `login_attempts`, `s`.`locked_until` AS `locked_until`, count(`pv`.`id`) AS `total_profile_views`, count(distinct `pv`.`profile_id`) AS `unique_profiles_viewed`, count(`cr`.`id`) AS `contact_requests_sent`, `st`.`name` AS `tier_name`, `st`.`max_profile_views_per_month` AS `max_profile_views_per_month`, `st`.`can_view_contact_info` AS `can_view_contact_info`, `st`.`can_download_cv` AS `can_download_cv` FROM (((`subscribers` `s` left join `profile_views` `pv` on(`s`.`id` = `pv`.`viewer_id` and `pv`.`viewer_type` = 'subscriber')) left join `contact_requests` `cr` on(`s`.`id` = `cr`.`subscriber_id`)) left join `subscription_tiers` `st` on(`s`.`subscription_tier_id` = `st`.`id`)) GROUP BY `s`.`id` ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `applicant_privacy_settings`
--
ALTER TABLE `applicant_privacy_settings`
  ADD CONSTRAINT `applicant_privacy_settings_ibfk_1` FOREIGN KEY (`applicant_id`) REFERENCES `applicants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `billing_history`
--
ALTER TABLE `billing_history`
  ADD CONSTRAINT `billing_history_ibfk_1` FOREIGN KEY (`subscriber_id`) REFERENCES `subscribers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `certificates`
--
ALTER TABLE `certificates`
  ADD CONSTRAINT `certificates_ibfk_1` FOREIGN KEY (`applicant_id`) REFERENCES `applicants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `contact_requests`
--
ALTER TABLE `contact_requests`
  ADD CONSTRAINT `contact_requests_ibfk_1` FOREIGN KEY (`applicant_id`) REFERENCES `applicants` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `contact_requests_ibfk_2` FOREIGN KEY (`subscriber_id`) REFERENCES `subscribers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cv_generations`
--
ALTER TABLE `cv_generations`
  ADD CONSTRAINT `cv_generations_ibfk_1` FOREIGN KEY (`applicant_id`) REFERENCES `applicants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `language_verifications`
--
ALTER TABLE `language_verifications`
  ADD CONSTRAINT `language_verifications_ibfk_1` FOREIGN KEY (`applicant_id`) REFERENCES `applicants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `profile_views`
--
ALTER TABLE `profile_views`
  ADD CONSTRAINT `profile_views_ibfk_1` FOREIGN KEY (`profile_id`) REFERENCES `public_profiles` (`id`);

--
-- Constraints for table `public_profiles`
--
ALTER TABLE `public_profiles`
  ADD CONSTRAINT `public_profiles_ibfk_1` FOREIGN KEY (`applicant_id`) REFERENCES `applicants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `subscribers`
--
ALTER TABLE `subscribers`
  ADD CONSTRAINT `subscribers_ibfk_1` FOREIGN KEY (`subscription_tier_id`) REFERENCES `subscription_tiers` (`id`);

--
-- Constraints for table `traffic_light_scores`
--
ALTER TABLE `traffic_light_scores`
  ADD CONSTRAINT `traffic_light_scores_ibfk_1` FOREIGN KEY (`applicant_id`) REFERENCES `applicants` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

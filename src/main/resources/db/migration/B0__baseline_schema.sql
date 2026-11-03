-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: locallife_db
-- ------------------------------------------------------
-- Server version   8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aptitude_category`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aptitude_category` (
                                     `id` bigint NOT NULL AUTO_INCREMENT,
                                     `aptitude_code` varchar(255) DEFAULT NULL,
                                     `aptitude_name` varchar(255) DEFAULT NULL,
                                     PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `aptitude_test_history`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aptitude_test_history` (
                                         `confidence_score` double DEFAULT NULL,
                                         `is_completed` bit(1) NOT NULL,
                                         `is_partial_save` bit(1) NOT NULL,
                                         `last_completed_step` int DEFAULT NULL,
                                         `test_step` int NOT NULL,
                                         `created_at` datetime(6) NOT NULL,
                                         `history_id` bigint NOT NULL AUTO_INCREMENT,
                                         `member_id` bigint NOT NULL,
                                         `modified_at` datetime(6) NOT NULL,
                                         `session_id` varchar(100) DEFAULT NULL,
                                         `ai_response` text,
                                         `question_text` text NOT NULL,
                                         `user_response` text NOT NULL,
                                         `analyzed_aptitude_type` enum('ART_CREATION','COMMUNITY','HISTORY_CULTURE','NATURE','PENDING','TECH') DEFAULT NULL,
                                         PRIMARY KEY (`history_id`),
                                         KEY `FK2pukubcfxu4p7kiucmns68um4` (`member_id`),
                                         CONSTRAINT `FK2pukubcfxu4p7kiucmns68um4` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `aptitude_test_progress`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aptitude_test_progress` (
                                          `aptitude_test_step` int DEFAULT NULL,
                                          `last_partial_step` int DEFAULT NULL,
                                          `mypage_test_count` int NOT NULL,
                                          `aptitude_test_progress_id` bigint NOT NULL AUTO_INCREMENT,
                                          `created_at` datetime(6) NOT NULL,
                                          `modified_at` datetime(6) NOT NULL,
                                          `user_aptitude_id` bigint NOT NULL,
                                          `partial_session_id` varchar(100) DEFAULT NULL,
                                          PRIMARY KEY (`aptitude_test_progress_id`),
                                          UNIQUE KEY `UK1l7eru6nur9dwtb6q22y5a56d` (`user_aptitude_id`),
                                          CONSTRAINT `FKdg342g0b5o40kiyl3c5ib5v2f` FOREIGN KEY (`user_aptitude_id`) REFERENCES `user_aptitudes` (`user_aptitude_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `experience_program`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `experience_program` (
                                      `average_rating` decimal(2,1) NOT NULL,
                                      `count` int NOT NULL,
                                      `end_date` date NOT NULL,
                                      `final_price` decimal(38,2) DEFAULT NULL,
                                      `max_capacity` int NOT NULL,
                                      `min_capacity` int NOT NULL,
                                      `percent` decimal(38,2) DEFAULT NULL,
                                      `price` decimal(38,2) NOT NULL,
                                      `review_count` int NOT NULL,
                                      `start_date` date NOT NULL,
                                      `aptitude_category_id` bigint NOT NULL,
                                      `created_at` datetime(6) NOT NULL,
                                      `deleted_at` datetime(6) DEFAULT NULL,
                                      `id` bigint NOT NULL AUTO_INCREMENT,
                                      `modified_at` datetime(6) NOT NULL,
                                      `original_program_id` bigint DEFAULT NULL,
                                      `program_group_id` bigint DEFAULT NULL,
                                      `provider_id` bigint NOT NULL,
                                      `region_category_id` bigint NOT NULL,
                                      `business_name` varchar(100) NOT NULL,
                                      `title` varchar(100) NOT NULL,
                                      `curriculum_description` text NOT NULL,
                                      `description` text NOT NULL,
                                      `location` varchar(255) NOT NULL,
                                      `deleted_status` enum('DELETED','DISPLAYED','HIDDEN') NOT NULL,
                                      `is_local_specialized` enum('GENERAL','LOCAL') NOT NULL,
                                      `program_status` enum('DRAFT','PENDING','REGISTERED') NOT NULL,
                                      PRIMARY KEY (`id`),
                                      KEY `FKd36ka21878p6os28yjwf78cct` (`aptitude_category_id`),
                                      KEY `FKghgom8rsap89v0k7skinnbt7a` (`provider_id`),
                                      KEY `FKniw1rly6ldxtrutjss0s2951u` (`original_program_id`),
                                      KEY `FKg44ddhjgcuvqqi7y80jkibbco` (`program_group_id`),
                                      KEY `FKav829aq8x0sx44fhrhg4ovr2b` (`region_category_id`),
                                      CONSTRAINT `FKav829aq8x0sx44fhrhg4ovr2b` FOREIGN KEY (`region_category_id`) REFERENCES `region_category` (`id`),
                                      CONSTRAINT `FKd36ka21878p6os28yjwf78cct` FOREIGN KEY (`aptitude_category_id`) REFERENCES `aptitude_category` (`id`),
                                      CONSTRAINT `FKg44ddhjgcuvqqi7y80jkibbco` FOREIGN KEY (`program_group_id`) REFERENCES `program_group` (`id`),
                                      CONSTRAINT `FKghgom8rsap89v0k7skinnbt7a` FOREIGN KEY (`provider_id`) REFERENCES `member` (`id`),
                                      CONSTRAINT `FKniw1rly6ldxtrutjss0s2951u` FOREIGN KEY (`original_program_id`) REFERENCES `experience_program` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `file`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `file` (
                        `created_at` datetime(6) NOT NULL,
                        `id` bigint NOT NULL AUTO_INCREMENT,
                        `modified_at` datetime(6) NOT NULL,
                        `original_name` varchar(255) NOT NULL,
                        `stored_file_name` varchar(255) NOT NULL,
                        PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `file_mapping`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `file_mapping` (
                                `created_at` datetime(6) NOT NULL,
                                `file_id` bigint NOT NULL,
                                `id` bigint NOT NULL AUTO_INCREMENT,
                                `modified_at` datetime(6) NOT NULL,
                                `reference_id` bigint NOT NULL,
                                `file_category` enum('INQUIRY','LOCAL_CREATOR','MAGAZINE','PROGRAM') NOT NULL,
                                `file_purpose` enum('BANK_ACCOUNT_COPY','BUSINESS_REGISTRATION','DETAIL_IMAGE','ETC','INQUIRY_ATTACHMENT','SALES_LICENSE','THUMBNAIL') NOT NULL,
                                PRIMARY KEY (`id`),
                                KEY `FKcabt5umk31q0ter80am3u8cj2` (`file_id`),
                                CONSTRAINT `FKcabt5umk31q0ter80am3u8cj2` FOREIGN KEY (`file_id`) REFERENCES `file` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inquiry`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inquiry` (
                           `id` bigint NOT NULL AUTO_INCREMENT,
                           `created_at` datetime(6) NOT NULL,
                           `modified_at` datetime(6) NOT NULL,
                           `content` text,
                           `deleted_at` datetime(6) DEFAULT NULL,
                           `deleted_status` enum('DELETED','DISPLAYED','HIDDEN') DEFAULT NULL,
                           `status` enum('CANCELED','COMPLETED','IN_PROGRESS','WAITING') DEFAULT NULL,
                           `title` varchar(255) DEFAULT NULL,
                           `type` enum('ACCOUNT','ETC','MAGAZINE','PAYMENT','POLICY','PROGRAM','RESERVATION','REVIEW','SETTLEMENT','SYSTEM') DEFAULT NULL,
                           `assignee_id` bigint DEFAULT NULL,
                           `member_id` bigint DEFAULT NULL,
                           PRIMARY KEY (`id`),
                           KEY `FK76ugh1ie8fxbtegprque7m7dh` (`assignee_id`),
                           KEY `FKf47xlnlpohnc6gd4k511g0wra` (`member_id`),
                           CONSTRAINT `FK76ugh1ie8fxbtegprque7m7dh` FOREIGN KEY (`assignee_id`) REFERENCES `member` (`id`),
                           CONSTRAINT `FKf47xlnlpohnc6gd4k511g0wra` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inquiry_answer`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inquiry_answer` (
                                  `id` bigint NOT NULL AUTO_INCREMENT,
                                  `created_at` datetime(6) NOT NULL,
                                  `modified_at` datetime(6) NOT NULL,
                                  `content` text,
                                  `admin_id` bigint DEFAULT NULL,
                                  `inquiry_id` bigint DEFAULT NULL,
                                  PRIMARY KEY (`id`),
                                  KEY `FKqwewtlh20n7idvujrub1h7ab4` (`admin_id`),
                                  KEY `FK3irhermk3cm96u0y7oiv3ya4p` (`inquiry_id`),
                                  CONSTRAINT `FK3irhermk3cm96u0y7oiv3ya4p` FOREIGN KEY (`inquiry_id`) REFERENCES `inquiry` (`id`),
                                  CONSTRAINT `FKqwewtlh20n7idvujrub1h7ab4` FOREIGN KEY (`admin_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inquiry_template`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inquiry_template` (
                                    `id` bigint NOT NULL AUTO_INCREMENT,
                                    `category` varchar(255) DEFAULT NULL,
                                    `content` text,
                                    `title` varchar(255) DEFAULT NULL,
                                    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `local_creator`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `local_creator` (
                                 `created_at` datetime(6) NOT NULL,
                                 `id` bigint NOT NULL AUTO_INCREMENT,
                                 `member_id` bigint NOT NULL,
                                 `modified_at` datetime(6) NOT NULL,
                                 `business_address` varchar(255) NOT NULL,
                                 `business_name` varchar(255) NOT NULL,
                                 `rejected_reason` varchar(255) DEFAULT NULL,
                                 `creator_status` enum('APPROVED','PENDING','REJECTED') NOT NULL,
                                 PRIMARY KEY (`id`),
                                 UNIQUE KEY `UKjtn89573lif6op3nbt4c8q09t` (`member_id`),
                                 CONSTRAINT `FKo05riytcuc5yiper67xipqn99` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `magazine`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `magazine` (
                            `admin_id` bigint DEFAULT NULL,
                            `aptitude_category_id` bigint DEFAULT NULL,
                            `created_at` datetime(6) NOT NULL,
                            `deleted_at` datetime(6) DEFAULT NULL,
                            `id` bigint NOT NULL AUTO_INCREMENT,
                            `localcreator_id` bigint DEFAULT NULL,
                            `modified_at` datetime(6) NOT NULL,
                            `region_category_id` bigint DEFAULT NULL,
                            `registered_at` datetime(6) DEFAULT NULL,
                            `views` bigint NOT NULL,
                            `thumbnail_url` varchar(500) NOT NULL,
                            `title` varchar(255) NOT NULL,
                            `content` tinytext NOT NULL,
                            `deleted_status` enum('DELETED','DISPLAYED','HIDDEN') NOT NULL,
                            `magazine_status` enum('DRAFT','HIDDEN','PENDING_CONFIRMATION','REGISTERED','REQUEST_REVISION') NOT NULL,
                            PRIMARY KEY (`id`),
                            KEY `FK9t8wuv7xlg770eelcypve6wt4` (`admin_id`),
                            KEY `FKja8ck7sluwfa4uj61pfcpu92y` (`aptitude_category_id`),
                            KEY `FKqx3f7cvn28u0wh7m8iixmoj51` (`localcreator_id`),
                            KEY `FKn1bfmo0a1javn8g8prg184202` (`region_category_id`),
                            CONSTRAINT `FK9t8wuv7xlg770eelcypve6wt4` FOREIGN KEY (`admin_id`) REFERENCES `member` (`id`),
                            CONSTRAINT `FKja8ck7sluwfa4uj61pfcpu92y` FOREIGN KEY (`aptitude_category_id`) REFERENCES `aptitude_category` (`id`),
                            CONSTRAINT `FKn1bfmo0a1javn8g8prg184202` FOREIGN KEY (`region_category_id`) REFERENCES `region_category` (`id`),
                            CONSTRAINT `FKqx3f7cvn28u0wh7m8iixmoj51` FOREIGN KEY (`localcreator_id`) REFERENCES `local_creator` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `magazine_feedback`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `magazine_feedback` (
                                     `reflected` bit(1) NOT NULL,
                                     `created_at` datetime(6) NOT NULL,
                                     `id` bigint NOT NULL AUTO_INCREMENT,
                                     `local_creator_id` bigint NOT NULL,
                                     `magazine_id` bigint NOT NULL,
                                     `modified_at` datetime(6) NOT NULL,
                                     `content` text NOT NULL,
                                     PRIMARY KEY (`id`),
                                     KEY `FK9q7sf80em69jmo7dxk5iuk8ru` (`local_creator_id`),
                                     KEY `FKhxsbxqw8ek0ku0fhha7po3d97` (`magazine_id`),
                                     CONSTRAINT `FK9q7sf80em69jmo7dxk5iuk8ru` FOREIGN KEY (`local_creator_id`) REFERENCES `local_creator` (`id`),
                                     CONSTRAINT `FKhxsbxqw8ek0ku0fhha7po3d97` FOREIGN KEY (`magazine_id`) REFERENCES `magazine` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `magazine_preview_token`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `magazine_preview_token` (
                                          `created_at` datetime(6) NOT NULL,
                                          `expires_at` datetime(6) NOT NULL,
                                          `id` bigint NOT NULL AUTO_INCREMENT,
                                          `magazine_id` bigint NOT NULL,
                                          `modified_at` datetime(6) NOT NULL,
                                          `token` varchar(100) NOT NULL,
                                          `email` varchar(255) NOT NULL,
                                          PRIMARY KEY (`id`),
                                          UNIQUE KEY `UK18y36ae73stqyyjongysjw8yo` (`magazine_id`),
                                          UNIQUE KEY `UKoblaagnbb1tio4c8kv75l5ikm` (`token`),
                                          CONSTRAINT `FKk5cvkl0nen45rp3seh0vq3vng` FOREIGN KEY (`magazine_id`) REFERENCES `magazine` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `magazine_revisions`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `magazine_revisions` (
                                      `revision_number` int NOT NULL,
                                      `created_at` datetime(6) NOT NULL,
                                      `id` bigint NOT NULL AUTO_INCREMENT,
                                      `magazine_id` bigint NOT NULL,
                                      `member_id` bigint NOT NULL,
                                      `content` text NOT NULL,
                                      PRIMARY KEY (`id`),
                                      KEY `FKiirhuq1ufysi9mgetbsg3ejsa` (`member_id`),
                                      KEY `FKgs605trndn3xrfarepu2p5f8p` (`magazine_id`),
                                      CONSTRAINT `FKgs605trndn3xrfarepu2p5f8p` FOREIGN KEY (`magazine_id`) REFERENCES `magazine` (`id`),
                                      CONSTRAINT `FKiirhuq1ufysi9mgetbsg3ejsa` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
                          `created_at` datetime(6) NOT NULL,
                          `id` bigint NOT NULL AUTO_INCREMENT,
                          `modified_at` datetime(6) NOT NULL,
                          `birth` varchar(50) NOT NULL,
                          `phone_number` varchar(50) DEFAULT NULL,
                          `email` varchar(320) NOT NULL,
                          `nickname` varchar(255) DEFAULT NULL,
                          `password` varchar(255) NOT NULL,
                          `gender` enum('FEMALE','MALE','UNKNOWN') NOT NULL,
                          `member_role` enum('ADMIN','LOCAL_CREATOR','USER') NOT NULL,
                          `deleted_at` datetime(6) DEFAULT NULL,
                          `deleted_status` enum('DELETED','DISPLAYED','HIDDEN') NOT NULL,
                          `withdrawal_reason` varchar(300) DEFAULT NULL,
                          PRIMARY KEY (`id`),
                          UNIQUE KEY `UKmbmcqelty0fbrvxp1q58dn57t` (`email`),
                          UNIQUE KEY `UKhh9kg6jti4n1eoiertn2k6qsc` (`nickname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `onboarding_progress`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `onboarding_progress` (
                                       `is_completed` bit(1) NOT NULL,
                                       `knows_aptitude` bit(1) DEFAULT NULL,
                                       `created_at` datetime(6) NOT NULL,
                                       `member_id` bigint NOT NULL,
                                       `modified_at` datetime(6) NOT NULL,
                                       `onboarding_progress_id` bigint NOT NULL AUTO_INCREMENT,
                                       `session_id` varchar(255) DEFAULT NULL,
                                       `current_step` enum('APTITUDE_AI_TEST','APTITUDE_CHECK','APTITUDE_MANUAL','COMPLETED','MEMBER_INFO','REGION_SELECT') NOT NULL,
                                       `region_type` enum('BALANCED','NATURE','URBAN') DEFAULT NULL,
                                       PRIMARY KEY (`onboarding_progress_id`),
                                       UNIQUE KEY `UK79nqa4bwjdf2w35b4t7rt73b3` (`member_id`),
                                       CONSTRAINT `FK8m565shq458rq1db5b6gb673` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
                           `payment_cost` decimal(12,2) NOT NULL,
                           `payment_fail_count` int DEFAULT NULL,
                           `refund_fail_count` int DEFAULT NULL,
                           `total_refund_amount` decimal(38,2) DEFAULT NULL,
                           `created_at` datetime(6) NOT NULL,
                           `deleted_at` datetime(6) DEFAULT NULL,
                           `expired_at` datetime(6) DEFAULT NULL,
                           `id` bigint NOT NULL AUTO_INCREMENT,
                           `last_payment_failed_at` datetime(6) DEFAULT NULL,
                           `last_refund_failed_at` datetime(6) DEFAULT NULL,
                           `modified_at` datetime(6) NOT NULL,
                           `paid_at` datetime(6) DEFAULT NULL,
                           `refunded_at` datetime(6) DEFAULT NULL,
                           `reservation_id` bigint NOT NULL,
                           `payment_card` varchar(50) DEFAULT NULL,
                           `imp_uid` varchar(100) DEFAULT NULL,
                           `merchant_uid` varchar(100) NOT NULL,
                           `payment_card_snapshot` varchar(100) DEFAULT NULL,
                           `pg_tid` varchar(100) DEFAULT NULL,
                           `refund_reason` text,
                           `deleted_status` enum('DELETED','DISPLAYED','HIDDEN') NOT NULL,
                           `payment_method_type` enum('CARD') NOT NULL,
                           `payment_provider` enum('KG_INICIS') NOT NULL,
                           `payment_status` enum('PAYMENT_CANCELED','PAYMENT_EXPIRED','PAYMENT_FAILED','PAYMENT_PENDING','PAYMENT_SUCCESS','REFUND_COMPLETED','REFUND_FAILED','REFUND_REQUESTED') NOT NULL,
                           PRIMARY KEY (`id`),
                           UNIQUE KEY `UK3llq7oxcs9j7vlujfdf16jmu` (`reservation_id`),
                           UNIQUE KEY `UKotel297qxt86856oo84cqw47f` (`merchant_uid`),
                           CONSTRAINT `FKrewpj5f9v9xehy4ga8g221nw1` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment_history`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_history` (
                                   `payment_cost` decimal(12,2) DEFAULT NULL,
                                   `total_refund_amount` decimal(38,2) DEFAULT NULL,
                                   `created_at` datetime(6) NOT NULL,
                                   `deleted_at` datetime(6) DEFAULT NULL,
                                   `id` bigint NOT NULL AUTO_INCREMENT,
                                   `modified_at` datetime(6) NOT NULL,
                                   `payment_failed_at` datetime(6) DEFAULT NULL,
                                   `payment_id` bigint NOT NULL,
                                   `refund_failed_at` datetime(6) DEFAULT NULL,
                                   `refunded_at` datetime(6) DEFAULT NULL,
                                   `user_id` bigint NOT NULL,
                                   `imp_uid` varchar(100) DEFAULT NULL,
                                   `merchant_uid` varchar(100) DEFAULT NULL,
                                   `payment_card_snapshot` varchar(100) DEFAULT NULL,
                                   `pg_tid` varchar(100) DEFAULT NULL,
                                   `payment_failed_reason` text,
                                   `pg_fail_message` text,
                                   `refund_failed_reason` text,
                                   `refund_reason` text,
                                   `deleted_status` enum('DELETED','DISPLAYED','HIDDEN') NOT NULL,
                                   `payment_method_type` enum('CARD') DEFAULT NULL,
                                   `payment_provider` enum('KG_INICIS') DEFAULT NULL,
                                   `payment_status` enum('PAYMENT_CANCELED','PAYMENT_EXPIRED','PAYMENT_FAILED','PAYMENT_PENDING','PAYMENT_SUCCESS','REFUND_COMPLETED','REFUND_FAILED','REFUND_REQUESTED') NOT NULL,
                                   PRIMARY KEY (`id`),
                                   KEY `FKdn9pr71ha5wgrareb76lfjkpp` (`user_id`),
                                   KEY `FKrgfm32kn93gp9q6e5jcoaf5f7` (`payment_id`),
                                   CONSTRAINT `FKdn9pr71ha5wgrareb76lfjkpp` FOREIGN KEY (`user_id`) REFERENCES `member` (`id`),
                                   CONSTRAINT `FKrgfm32kn93gp9q6e5jcoaf5f7` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `program_day`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `program_day` (
                               `id` bigint NOT NULL AUTO_INCREMENT,
                               `program_id` bigint DEFAULT NULL,
                               `day_name` enum('FRIDAY','MONDAY','SATURDAY','SUNDAY','THURSDAY','TUESDAY','WEDNESDAY') NOT NULL,
                               PRIMARY KEY (`id`),
                               KEY `FKrd6fm38k1v23s0misxlw91t5g` (`program_id`),
                               CONSTRAINT `FKrd6fm38k1v23s0misxlw91t5g` FOREIGN KEY (`program_id`) REFERENCES `experience_program` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `program_group`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `program_group` (
                                 `id` bigint NOT NULL AUTO_INCREMENT,
                                 `group_title` varchar(100) NOT NULL,
                                 PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `program_schedule`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `program_schedule` (
                                    `end_time` time(6) NOT NULL,
                                    `schedule_date` date NOT NULL,
                                    `start_time` time(6) NOT NULL,
                                    `created_at` datetime(6) NOT NULL,
                                    `deleted_at` datetime(6) DEFAULT NULL,
                                    `id` bigint NOT NULL AUTO_INCREMENT,
                                    `modified_at` datetime(6) NOT NULL,
                                    `program_id` bigint NOT NULL,
                                    `deleted_status` enum('DELETED','DISPLAYED','HIDDEN') NOT NULL,
                                    `program_schedule_status` enum('ACTIVE','INACTIVE') NOT NULL,
                                    PRIMARY KEY (`id`),
                                    KEY `FKq8hg58evhf7p5pbx6pinbmdqs` (`program_id`),
                                    CONSTRAINT `FKq8hg58evhf7p5pbx6pinbmdqs` FOREIGN KEY (`program_id`) REFERENCES `experience_program` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `program_schedule_time`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `program_schedule_time` (
                                         `end_time` time(6) DEFAULT NULL,
                                         `schedule_count` int NOT NULL,
                                         `schedule_duration` int NOT NULL,
                                         `start_time` time(6) NOT NULL,
                                         `id` bigint NOT NULL AUTO_INCREMENT,
                                         `program_id` bigint DEFAULT NULL,
                                         PRIMARY KEY (`id`),
                                         KEY `FKbf5fihn14g1kaaic7vcbjuuuy` (`program_id`),
                                         CONSTRAINT `FKbf5fihn14g1kaaic7vcbjuuuy` FOREIGN KEY (`program_id`) REFERENCES `experience_program` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `region_category`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `region_category` (
                                   `id` bigint NOT NULL AUTO_INCREMENT,
                                   `region_name` varchar(255) DEFAULT NULL,
                                   PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reservation`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
                               `canceled_at` datetime(6) DEFAULT NULL,
                               `created_at` datetime(6) NOT NULL,
                               `deleted_at` datetime(6) DEFAULT NULL,
                               `expired_at` datetime(6) DEFAULT NULL,
                               `id` bigint NOT NULL AUTO_INCREMENT,
                               `modified_at` datetime(6) NOT NULL,
                               `program_schedule_id` bigint NOT NULL,
                               `rejected_at` datetime(6) DEFAULT NULL,
                               `user_id` bigint NOT NULL,
                               `cancel_reason` text,
                               `rejected_reason` text,
                               `deleted_status` enum('DELETED','DISPLAYED','HIDDEN') NOT NULL,
                               `reservation_status` enum('APPROVED','AWAITING_APPROVAL','CANCELED','COMPLETED','EXPIRED','PAYMENT_PENDING','REJECTED','REQUESTED') NOT NULL,
                               PRIMARY KEY (`id`),
                               KEY `FK5eo87r5wr8j44aiu3n2kd2o8o` (`user_id`),
                               KEY `FKofm0l2hxtfini09unxbeto8i6` (`program_schedule_id`),
                               CONSTRAINT `FK5eo87r5wr8j44aiu3n2kd2o8o` FOREIGN KEY (`user_id`) REFERENCES `member` (`id`),
                               CONSTRAINT `FKofm0l2hxtfini09unxbeto8i6` FOREIGN KEY (`program_schedule_id`) REFERENCES `program_schedule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `review`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
                          `like_count` int NOT NULL,
                          `review_rating` decimal(2,1) NOT NULL,
                          `view_count` int NOT NULL,
                          `created_at` datetime(6) NOT NULL,
                          `deleted_at` datetime(6) DEFAULT NULL,
                          `member_id` bigint NOT NULL,
                          `modified_at` datetime(6) NOT NULL,
                          `program_id` bigint NOT NULL,
                          `reservation_id` bigint NOT NULL,
                          `review_id` bigint NOT NULL AUTO_INCREMENT,
                          `review_content` text NOT NULL,
                          `deleted_status` enum('DELETED','DISPLAYED','HIDDEN') NOT NULL,
                          PRIMARY KEY (`review_id`),
                          KEY `FKk0ccx5i4ci2wd70vegug074w1` (`member_id`),
                          KEY `FKmwsd85uwmyquncmejylpju3c` (`program_id`),
                          KEY `FK7tyi0jd0eaphyr0gsvfjqww9i` (`reservation_id`),
                          CONSTRAINT `FK7tyi0jd0eaphyr0gsvfjqww9i` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`),
                          CONSTRAINT `FKk0ccx5i4ci2wd70vegug074w1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`),
                          CONSTRAINT `FKmwsd85uwmyquncmejylpju3c` FOREIGN KEY (`program_id`) REFERENCES `experience_program` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `review_like`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review_like` (
                               `created_at` datetime(6) NOT NULL,
                               `member_id` bigint NOT NULL,
                               `modified_at` datetime(6) NOT NULL,
                               `review_id` bigint NOT NULL,
                               `review_like_id` bigint NOT NULL AUTO_INCREMENT,
                               PRIMARY KEY (`review_like_id`),
                               UNIQUE KEY `UKqhbo1hs2awkmdp901kgb2ixm3` (`review_id`,`member_id`),
                               KEY `FKf19ep4u0vm5vietilw2kp9jo2` (`member_id`),
                               CONSTRAINT `FK68am9vk1s1e8n1v873meqkk0k` FOREIGN KEY (`review_id`) REFERENCES `review` (`review_id`),
                               CONSTRAINT `FKf19ep4u0vm5vietilw2kp9jo2` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `review_replies`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review_replies` (
                                  `created_at` datetime(6) NOT NULL,
                                  `deleted_at` datetime(6) DEFAULT NULL,
                                  `local_creator_id` bigint NOT NULL,
                                  `modified_at` datetime(6) NOT NULL,
                                  `reply_id` bigint NOT NULL AUTO_INCREMENT,
                                  `review_id` bigint NOT NULL,
                                  `reply_content` text NOT NULL,
                                  `deleted_status` enum('DELETED','DISPLAYED','HIDDEN') NOT NULL,
                                  PRIMARY KEY (`reply_id`),
                                  KEY `FKkmvvrptku67g67wqgsytgk1n2` (`local_creator_id`),
                                  KEY `FKcfwi8ycw532uu4yxx1vr3e02h` (`review_id`),
                                  CONSTRAINT `FKcfwi8ycw532uu4yxx1vr3e02h` FOREIGN KEY (`review_id`) REFERENCES `review` (`review_id`),
                                  CONSTRAINT `FKkmvvrptku67g67wqgsytgk1n2` FOREIGN KEY (`local_creator_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `review_tag`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review_tag` (
                              `display_order` int NOT NULL,
                              `tag_is_active` bit(1) NOT NULL,
                              `created_at` datetime(6) NOT NULL,
                              `modified_at` datetime(6) NOT NULL,
                              `review_tag_id` bigint NOT NULL AUTO_INCREMENT,
                              `review_tag_name` varchar(50) NOT NULL,
                              PRIMARY KEY (`review_tag_id`),
                              UNIQUE KEY `UKcw38e9c1fln5qis0dnqjjtf71` (`review_tag_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `review_tag_mapping`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review_tag_mapping` (
                                      `created_at` datetime(6) NOT NULL,
                                      `modified_at` datetime(6) NOT NULL,
                                      `review_id` bigint NOT NULL,
                                      `review_tag_id` bigint NOT NULL,
                                      `review_tag_mapping_id` bigint NOT NULL AUTO_INCREMENT,
                                      PRIMARY KEY (`review_tag_mapping_id`),
                                      UNIQUE KEY `UKgp7cxpv8buxm272edhgl2y4pl` (`review_id`,`review_tag_id`),
                                      KEY `FK8x3k26wbvlki4c5k7rdh7k37e` (`review_tag_id`),
                                      CONSTRAINT `FK7x44f7dxa1o83do8ijg2v55jm` FOREIGN KEY (`review_id`) REFERENCES `review` (`review_id`),
                                      CONSTRAINT `FK8x3k26wbvlki4c5k7rdh7k37e` FOREIGN KEY (`review_tag_id`) REFERENCES `review_tag` (`review_tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_aptitudes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_aptitudes` (
                                  `aptitude_test_count` int NOT NULL,
                                  `created_at` datetime(6) NOT NULL,
                                  `member_id` bigint NOT NULL,
                                  `modified_at` datetime(6) NOT NULL,
                                  `user_aptitude_id` bigint NOT NULL AUTO_INCREMENT,
                                  `aptitude_code` enum('ART_CREATION','COMMUNITY','HISTORY_CULTURE','NATURE','PENDING','TECH') NOT NULL,
                                  PRIMARY KEY (`user_aptitude_id`),
                                  UNIQUE KEY `UK_user_aptitude_member_id` (`member_id`),
                                  CONSTRAINT `FKgktptsx3av7cnxtcx8hkrp5re` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_preferred_regions`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_preferred_regions` (
                                          `is_active` bit(1) NOT NULL,
                                          `created_at` datetime(6) NOT NULL,
                                          `member_id` bigint NOT NULL,
                                          `modified_at` datetime(6) NOT NULL,
                                          `preferred_region_id` bigint NOT NULL AUTO_INCREMENT,
                                          `region_name` varchar(20) NOT NULL,
                                          PRIMARY KEY (`preferred_region_id`),
                                          UNIQUE KEY `UKrdw2tnfs04h4le8qqqltxsnd3` (`member_id`,`region_name`),
                                          CONSTRAINT `FKorgwgl69suqc5i0fqeqt675iq` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-03 11:35:27

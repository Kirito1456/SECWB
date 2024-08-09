-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: webapp
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add user',1,'add_user'),(2,'Can change user',1,'change_user'),(3,'Can delete user',1,'delete_user'),(4,'Can view user',1,'view_user'),(5,'Can add post',2,'add_post'),(6,'Can change post',2,'change_post'),(7,'Can delete post',2,'delete_post'),(8,'Can view post',2,'view_post'),(9,'Can add comment',3,'add_comment'),(10,'Can change comment',3,'change_comment'),(11,'Can delete comment',3,'delete_comment'),(12,'Can view comment',3,'view_comment'),(13,'Can add log entry',4,'add_logentry'),(14,'Can change log entry',4,'change_logentry'),(15,'Can delete log entry',4,'delete_logentry'),(16,'Can view log entry',4,'view_logentry'),(17,'Can add permission',5,'add_permission'),(18,'Can change permission',5,'change_permission'),(19,'Can delete permission',5,'delete_permission'),(20,'Can view permission',5,'view_permission'),(21,'Can add group',6,'add_group'),(22,'Can change group',6,'change_group'),(23,'Can delete group',6,'delete_group'),(24,'Can view group',6,'view_group'),(25,'Can add content type',7,'add_contenttype'),(26,'Can change content type',7,'change_contenttype'),(27,'Can delete content type',7,'delete_contenttype'),(28,'Can view content type',7,'view_contenttype'),(29,'Can add session',8,'add_session'),(30,'Can change session',8,'change_session'),(31,'Can delete session',8,'delete_session'),(32,'Can view session',8,'view_session'),(33,'Can add access attempt',9,'add_accessattempt'),(34,'Can change access attempt',9,'change_accessattempt'),(35,'Can delete access attempt',9,'delete_accessattempt'),(36,'Can view access attempt',9,'view_accessattempt'),(37,'Can add access log',10,'add_accesslog'),(38,'Can change access log',10,'change_accesslog'),(39,'Can delete access log',10,'delete_accesslog'),(40,'Can view access log',10,'view_accesslog'),(41,'Can add access failure',11,'add_accessfailurelog'),(42,'Can change access failure',11,'change_accessfailurelog'),(43,'Can delete access failure',11,'delete_accessfailurelog'),(44,'Can view access failure',11,'view_accessfailurelog');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `axes_accessattempt`
--

DROP TABLE IF EXISTS `axes_accessattempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `axes_accessattempt` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_agent` varchar(255) NOT NULL,
  `ip_address` char(39) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `http_accept` varchar(1025) NOT NULL,
  `path_info` varchar(255) NOT NULL,
  `attempt_time` datetime(6) NOT NULL,
  `get_data` longtext NOT NULL,
  `post_data` longtext NOT NULL,
  `failures_since_start` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `axes_accessattempt_username_ip_address_user_agent_8ea22282_uniq` (`username`,`ip_address`,`user_agent`),
  KEY `axes_accessattempt_ip_address_10922d9c` (`ip_address`),
  KEY `axes_accessattempt_user_agent_ad89678b` (`user_agent`),
  KEY `axes_accessattempt_username_3f2d4ca0` (`username`),
  CONSTRAINT `axes_accessattempt_chk_1` CHECK ((`failures_since_start` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `axes_accessattempt`
--

LOCK TABLES `axes_accessattempt` WRITE;
/*!40000 ALTER TABLE `axes_accessattempt` DISABLE KEYS */;
INSERT INTO `axes_accessattempt` VALUES (1,'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36','127.0.0.1',NULL,'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7','/','2024-08-08 10:51:21.137975','\n---------\n','csrfmiddlewaretoken=IOw1m0gsT3LpEuozfijawrcP6EFLgeQ3c8b3v2GK5Ysg0TbllOXRKvrFcHmHRZjd\nemail=admin@gmail.com\npassword=********************\n---------\ncsrfmiddlewaretoken=wgUoMOVz20tLUE9JvxKnxfgFHuJjAi1yZYK2vX70fR2k0T69UWLpl4pyAOlv3wXG\nemail=eli@gmail.com\npassword=********************',2),(2,'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.85 Safari/537.36 QIHU 360SEi18n','127.0.0.1',NULL,'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9','/','2024-08-07 09:43:37.595302','','csrfmiddlewaretoken=Qvenmb5ufuc1KwqXYAmqCeAQghQQbs1OJU483TgVnoqULgh6dpuMmdFgxYhoHy9J\nemail=eli@gmail.com\npassword=********************',1);
/*!40000 ALTER TABLE `axes_accessattempt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `axes_accessfailurelog`
--

DROP TABLE IF EXISTS `axes_accessfailurelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `axes_accessfailurelog` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_agent` varchar(255) NOT NULL,
  `ip_address` char(39) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `http_accept` varchar(1025) NOT NULL,
  `path_info` varchar(255) NOT NULL,
  `attempt_time` datetime(6) NOT NULL,
  `locked_out` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `axes_accessfailurelog_user_agent_ea145dda` (`user_agent`),
  KEY `axes_accessfailurelog_ip_address_2e9f5a7f` (`ip_address`),
  KEY `axes_accessfailurelog_username_a8b7e8a4` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `axes_accessfailurelog`
--

LOCK TABLES `axes_accessfailurelog` WRITE;
/*!40000 ALTER TABLE `axes_accessfailurelog` DISABLE KEYS */;
/*!40000 ALTER TABLE `axes_accessfailurelog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `axes_accesslog`
--

DROP TABLE IF EXISTS `axes_accesslog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `axes_accesslog` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_agent` varchar(255) NOT NULL,
  `ip_address` char(39) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `http_accept` varchar(1025) NOT NULL,
  `path_info` varchar(255) NOT NULL,
  `attempt_time` datetime(6) NOT NULL,
  `logout_time` datetime(6) DEFAULT NULL,
  `session_hash` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `axes_accesslog_ip_address_86b417e5` (`ip_address`),
  KEY `axes_accesslog_user_agent_0e659004` (`user_agent`),
  KEY `axes_accesslog_username_df93064b` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `axes_accesslog`
--

LOCK TABLES `axes_accesslog` WRITE;
/*!40000 ALTER TABLE `axes_accesslog` DISABLE KEYS */;
INSERT INTO `axes_accesslog` VALUES (1,'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36','127.0.0.1','admin@gmail.com','text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7','/','2024-08-06 07:01:42.116431',NULL,'d076b186f54f27c49d1125165ca98c3f3e942b4f152e539f40bad506dfd97c6e'),(2,'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.85 Safari/537.36 QIHU 360SEi18n','127.0.0.1','admin@gmail.com','text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9','/','2024-08-07 09:31:12.025088','2024-08-07 09:34:11.386239','89d528c90ba461e87e0966009cac8d05c442d9900bd8740a86e771a65fa94c45'),(3,'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.85 Safari/537.36 QIHU 360SEi18n','127.0.0.1','admin@gmail.com','text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9','/','2024-08-07 09:36:09.524900','2024-08-07 09:38:44.215064','8151c7020c6d30b52c084c7070d8c431b99932eb452af3ecb39a216d7dffe892'),(4,'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.85 Safari/537.36 QIHU 360SEi18n','127.0.0.1','admin@gmail.com','text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9','/','2024-08-07 09:42:16.418748','2024-08-07 09:42:37.793535','e7c977736ead31e47d60e7a347bdb00b7bedb44fa75e7873c5d53ce51665f43d'),(5,'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.85 Safari/537.36 QIHU 360SEi18n','127.0.0.1','admin@gmail.com','text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9','/','2024-08-07 09:48:15.831274','2024-08-07 09:48:20.039520','59a2fdd78cdbdccc7cfe33d632dadca93343cfa7c27f03e59c61db67f6b22392'),(6,'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.85 Safari/537.36 QIHU 360SEi18n','127.0.0.1','admin@gmail.com','text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9','/','2024-08-07 09:50:47.985693',NULL,'53d467fd03c6ba023cbdc5a2f609dbdf7643a08639e960502d2cb9af998c3d07'),(7,'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.85 Safari/537.36 QIHU 360SEi18n','127.0.0.1','admin@gmail.com','text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9','/','2024-08-07 09:53:09.602106',NULL,'fafcdcd73746894290b302c74ce7673e57e0d98984339aec01115d521f94e65e'),(8,'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36','127.0.0.1','eli@gmail.com','text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7','/','2024-08-08 10:47:42.508034',NULL,'08c1155fd159406d27f63fc8e2bdbd7f8f2e4044bf97578a1adff661772a193b'),(9,'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36','127.0.0.1','eli@gmail.com','text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7','/','2024-08-08 10:55:05.500985',NULL,'b16e0bcff612cf7640033e42d5155c6f4eaf7331566e2b93068763a6a28f1586'),(10,'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36','127.0.0.1','eli@gmail.com','text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7','/','2024-08-08 11:00:45.491788','2024-08-08 11:14:01.455011','6ca381f923aa369464991ab58501ad16344a1b6db21daceb7cdbf7af7a83b568'),(11,'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36','127.0.0.1','eli@gmail.com','text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7','/','2024-08-08 11:15:00.550823',NULL,'c39c8b46b6ec4d0c488d45be54182b44d1bb7f04bb81f73d98e19ceaac02c052'),(12,'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36','127.0.0.1','eli@gmail.com','text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7','/','2024-08-08 11:25:22.678300','2024-08-08 11:31:07.621049','2c40e5d49850a488650d78d8d894d81a226ebd0fd7808793618421edf43183b1'),(13,'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36','127.0.0.1','eli@gmail.com','text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7','/','2024-08-08 11:32:56.635334',NULL,'a61ab68eb860871cf1cd755485f3ce71f2b7e0542b216ec5327b5da00292d873'),(14,'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36','127.0.0.1','eli@gmail.com','text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7','/','2024-08-08 11:37:31.095324',NULL,'a54d18129f6206c4d6b255b3819f75f4db0108a21d12db6d8ca55e8c186282b9'),(15,'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36','127.0.0.1','eli@gmail.com','text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7','/','2024-08-08 11:38:52.694114',NULL,'a54d18129f6206c4d6b255b3819f75f4db0108a21d12db6d8ca55e8c186282b9'),(16,'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36','127.0.0.1','eli@gmail.com','text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7','/','2024-08-08 11:41:02.962962','2024-08-08 11:47:13.830517','c5fef9eacf5f410d3c5ac1236e4b69f371e5a8c6e41d1d63b80a0173b9435b66'),(17,'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36','127.0.0.1','eli@gmail.com','text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7','/','2024-08-08 11:53:43.983630','2024-08-08 12:05:59.359010','d8a5529868a667d5b8002b437c6cf6a7ddb403e6dddb369b26f11e36d5f2023b'),(18,'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36','127.0.0.1','eli@gmail.com','text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7','/','2024-08-08 12:12:54.490938','2024-08-08 12:28:03.522789','41f28792812c66ccefeaa176370c941c549113117abf36b73684fb113ebf82ad'),(19,'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36','127.0.0.1','eli@gmail.com','text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7','/','2024-08-08 12:50:03.635184','2024-08-08 13:34:54.623739','5e67b8cb1bafdabe733b98209c14b9a13f45566b2c70afcf31992444fa8d563d'),(20,'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36','127.0.0.1','eli@gmail.com','text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7','/','2024-08-08 13:36:17.014733',NULL,'fc2a75c1997701709bf5637765bfa9519b5128edbe725e8525e45819e694309b'),(21,'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36','127.0.0.1','admin@gmail.com','text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7','/','2024-08-08 13:59:50.474979','2024-08-08 14:07:20.421813','d74b2746a3a85906a94d20a356b4c82f646c7a699bc2a04c01ac17d193ff80bc'),(22,'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36','127.0.0.1','admin@gmail.com','text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7','/','2024-08-08 14:07:28.660416',NULL,'8f5f9aad2c16a4dc8a6a99d976858662c9413bfefc8db8532b86d52bde4ff0c5');
/*!40000 ALTER TABLE `axes_accesslog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_users_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (4,'admin','logentry'),(6,'auth','group'),(5,'auth','permission'),(9,'axes','accessattempt'),(11,'axes','accessfailurelog'),(10,'axes','accesslog'),(7,'contenttypes','contenttype'),(8,'sessions','session'),(3,'website','comment'),(2,'website','post'),(1,'website','user');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'website','0001_initial','2024-08-06 07:00:29.143812'),(2,'contenttypes','0001_initial','2024-08-06 07:00:29.237592'),(3,'admin','0001_initial','2024-08-06 07:00:29.545569'),(4,'admin','0002_logentry_remove_auto_add','2024-08-06 07:00:29.556670'),(5,'admin','0003_logentry_add_action_flag_choices','2024-08-06 07:00:29.567808'),(6,'contenttypes','0002_remove_content_type_name','2024-08-06 07:00:29.713599'),(7,'auth','0001_initial','2024-08-06 07:00:30.583163'),(8,'auth','0002_alter_permission_name_max_length','2024-08-06 07:00:30.719369'),(9,'auth','0003_alter_user_email_max_length','2024-08-06 07:00:30.733139'),(10,'auth','0004_alter_user_username_opts','2024-08-06 07:00:30.744332'),(11,'auth','0005_alter_user_last_login_null','2024-08-06 07:00:30.757100'),(12,'auth','0006_require_contenttypes_0002','2024-08-06 07:00:30.766281'),(13,'auth','0007_alter_validators_add_error_messages','2024-08-06 07:00:30.779176'),(14,'auth','0008_alter_user_username_max_length','2024-08-06 07:00:30.792715'),(15,'auth','0009_alter_user_last_name_max_length','2024-08-06 07:00:30.807352'),(16,'auth','0010_alter_group_name_max_length','2024-08-06 07:00:30.839825'),(17,'auth','0011_update_proxy_permissions','2024-08-06 07:00:30.854948'),(18,'auth','0012_alter_user_first_name_max_length','2024-08-06 07:00:30.868556'),(19,'axes','0001_initial','2024-08-06 07:00:30.971631'),(20,'axes','0002_auto_20151217_2044','2024-08-06 07:00:31.277493'),(21,'axes','0003_auto_20160322_0929','2024-08-06 07:00:31.300868'),(22,'axes','0004_auto_20181024_1538','2024-08-06 07:00:31.321951'),(23,'axes','0005_remove_accessattempt_trusted','2024-08-06 07:00:31.442255'),(24,'axes','0006_remove_accesslog_trusted','2024-08-06 07:00:31.558340'),(25,'axes','0007_alter_accessattempt_unique_together','2024-08-06 07:00:31.613280'),(26,'axes','0008_accessfailurelog','2024-08-06 07:00:31.764575'),(27,'axes','0009_add_session_hash','2024-08-06 07:00:31.818681'),(28,'sessions','0001_initial','2024-08-06 07:00:31.905452'),(29,'website','0002_user_is_staff_alter_user_profile_photo','2024-08-06 07:00:32.071956'),(30,'website','0003_profile_delete_user','2024-08-06 07:00:32.250257'),(31,'website','0004_remove_user_is_active_alter_user_email_alter_user_id_and_more','2024-08-06 07:00:33.119562'),(32,'website','0005_rename_user_customuser','2024-08-06 07:00:33.298897'),(33,'website','0006_rename_customuser_user','2024-08-06 07:00:33.476996'),(34,'website','0007_remove_user_is_staff_post_comment','2024-08-06 07:00:34.302360'),(35,'website','0008_rename_user_post_author','2024-08-06 07:00:34.511293'),(36,'website','0009_user_is_active_user_username_alter_post_likes','2024-08-06 07:00:34.718649'),(37,'website','0010_user_is_staff','2024-08-06 07:00:34.797401'),(38,'website','0011_user_is_banned','2024-08-06 07:00:34.897678'),(39,'website','0012_post_is_approved','2024-08-06 07:00:34.964504');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('7q244x41xe7fa8m3341ynij07tt7pmur','.eJxVjEEOwiAQRe_C2pABOlBcuvcMBJhBqoYmpV0Z765NutDtf-_9lwhxW2vYOi9hInEWSpx-txTzg9sO6B7bbZZ5busyJbkr8qBdXmfi5-Vw_w5q7PVbW4XaDgQIzsTRsYHMYJ3SgMpSoexV8ThQAQ-eKaF2PKKJlpTXyWTx_gCzZDcQ:1sbECU:v6wnhfQPlCYKCzBrKxX421Sug2yK7R7bM6BQeuop7Os','2024-08-06 07:51:42.126189'),('bubef7aureejou6qi1aqqyjhw3o25mqi','.eJxVjrsOwjAMRf8lKxA576YjOxt7lMYuBapGNOmE-HdawQCSp_s4vk8W4lKHsBSawxVZywTb_2pdTHeaNgNvcbpknvJU52vHtwj_uoWfMtJ4_Gb_AEMsw9q2wkirEQw4FRtHChKBdUKCERZ7TF703mjswYMn7Ix01BgVLQovO5VW6GfAhs5hzJe81DDGUsNMj4VKXZ9IkPoAzXpnoVvwrQbuTAMKdgAtAHu9AbfrS3M:1sc3pk:rQOQiUmqHvwtQYqRpxhCx6i4ywblVyZIdPK7pYIR494','2024-08-08 14:59:40.759051');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(255) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `profile_photo` varchar(100) DEFAULT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_banned` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'argon2$argon2id$v=19$m=102400,t=2,p=8$cnU3eGM4MExORDVTM2RhTDFobUh5VA$0gNm+cZQ/Qyebo2JpVTGHfth9mTQgdMKPbakGtRyYHs','2024-08-08 14:07:28.651778','admin@gmail.com','admin','09876543122','',1,1,'admin',1,0),(2,'argon2$argon2id$v=19$m=102400,t=2,p=8$NHNOam5nTVl3VnJwMm83aUFzYlFqSg$x9ThQqn4Wz55V/xIofvFa2yNgEfJYm82/sPeQj30bFg','2024-08-08 13:36:17.006061','eli@gmail.com','Eli Yow','09876453210','',0,1,'3LiY0w',0,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `website_comment`
--

DROP TABLE IF EXISTS `website_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `website_comment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `post_id` bigint NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `website_comment_post_id_e59b940c_fk_website_post_id` (`post_id`),
  KEY `website_comment_user_id_bfa88096_fk_users_id` (`user_id`),
  CONSTRAINT `website_comment_post_id_e59b940c_fk_website_post_id` FOREIGN KEY (`post_id`) REFERENCES `website_post` (`id`),
  CONSTRAINT `website_comment_user_id_bfa88096_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `website_comment`
--

LOCK TABLES `website_comment` WRITE;
/*!40000 ALTER TABLE `website_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `website_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `website_post`
--

DROP TABLE IF EXISTS `website_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `website_post` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `author_id` int NOT NULL,
  `is_approved` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `website_post_author_id_eb04e995_fk_users_id` (`author_id`),
  CONSTRAINT `website_post_author_id_eb04e995_fk_users_id` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `website_post`
--

LOCK TABLES `website_post` WRITE;
/*!40000 ALTER TABLE `website_post` DISABLE KEYS */;
/*!40000 ALTER TABLE `website_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `website_post_likes`
--

DROP TABLE IF EXISTS `website_post_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `website_post_likes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `post_id` bigint NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `website_post_likes_post_id_user_id_9c796c09_uniq` (`post_id`,`user_id`),
  KEY `website_post_likes_user_id_dce76737_fk_users_id` (`user_id`),
  CONSTRAINT `website_post_likes_post_id_30fc00fb_fk_website_post_id` FOREIGN KEY (`post_id`) REFERENCES `website_post` (`id`),
  CONSTRAINT `website_post_likes_user_id_dce76737_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `website_post_likes`
--

LOCK TABLES `website_post_likes` WRITE;
/*!40000 ALTER TABLE `website_post_likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `website_post_likes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-08 22:39:56

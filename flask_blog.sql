-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: flask_blog
-- ------------------------------------------------------
-- Server version	8.0.21

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
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contacts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(15) NOT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `msg` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
INSERT INTO `contacts` VALUES (1,'Yash Sankhla','gokulnama21@gmail.com','07976399265','2021-05-16 19:51:21','Once again 1'),(2,'Yash Sankhla','gokulnama21@gmail.com','07976399265','2021-05-16 19:54:11','Once again 2'),(3,'Yash Sankhla','gokulnama21@gmail.com','07976399265','2021-05-16 19:54:22','Once again 2'),(4,'Yash Sankhla','gokulnama21@gmail.com','07976399265','2021-05-16 19:59:05','Once again 3'),(5,'Yash Sankhla','2019pietcsyash192@poornima.org','07976399265','2021-05-16 20:02:21','Once again 3'),(6,'Yash Sankhla','2019pietcsyash192@poornima.org','07976399265','2021-05-16 20:02:46','Once again 4'),(7,'Ev','env@env.com','1616161616','2021-05-16 22:35:23','Env check'),(8,'Ev','env@env.com','1616161616','2021-05-16 22:35:39','Env check'),(9,'admin check','admin','6464','2021-05-17 16:01:34','For admin'),(10,'Yash Sankhla','gokulnama21@gmail.com','07976399265','2021-05-17 16:22:42','Check for admin 2'),(11,'Yash Sankhla','2019pietcsyash192@poornima.org','07976399265','2021-05-17 16:23:41','Admin check 5\r\n'),(12,'Let check agISV','g@g.vom','418446','2021-05-17 16:29:01','lsgslgsd'),(13,'HEy Buddy','buddy@buddy','151515151515','2021-05-22 23:49:04','This is buddy'),(14,'Yash Sankhla','gokulnama21@gmail.com','07976399265','2021-05-23 00:07:56','Hy this is flash check okhhhh'),(15,'yash','yash@2001','8118114561','2021-05-23 15:50:28','This is my essgae\r\n'),(16,'yash','yash@2001','8118114561','2021-05-23 16:10:23','This is my essgae\r\n'),(17,'yash','yash@2001','8118114561','2021-05-23 16:13:36','This is my essgae\r\n'),(18,'yash','yash@2001','8118114561','2021-05-23 16:15:16','This is my essgae\r\n'),(19,'yash','yash@2001','8118114561','2021-05-23 16:15:31','This is my essgae\r\n');
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(25) NOT NULL,
  `subtitle` varchar(50) DEFAULT NULL,
  `content` varchar(255) NOT NULL,
  `author` varchar(20) NOT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `img_file` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,'IMP POST','Subitle of first post','This is content','Admin','2021-05-17 00:06:08','posts-bg.jpg'),(2,'Architecture and ','Subitle','CenterAcra (fortress)Angkor WatAnthony RollBelton HouseBenty Grange helmetBiblioteca MarcianaBlakeney ChapelBodiam CastleBook of KellsBorobudurBramall HallBramshill HouseBrougham CastleBruce CastleBuckingham PalaceBuckton CastleBuildings and','Admin','2021-05-17 03:02:08','about-bg.jpg'),(3,'ART','Subitle of third post','After the Deluge (painting)Annunciation (Memling)Beaune AltarpieceThe Battle of Alexander at IssusThe Blind Leading the BlindBoydell Shakespeare GalleryBritomart Redeems Faire AmoretCandaules, King of Lydia, Shews his Wife by Stealth to Gyges, One of his ','Anyone','2021-05-17 03:05:24','posts-bg.jpg'),(4,'Fungi','Subitle of fourth post','Agaricus deserticolaAlbatrellus subrubescensAmanita bisporigeraAmanita muscariaAmanita ocreataAmanita phalloidesArmillaria gallicaArmillaria luteobubalinaAstraeus hygrometricusAuriscalpium vulgareImleria badiaBoletus aereusBoletus edulisExsudoporus frosti','Yash','2021-05-17 03:09:40','posts-bg.jpg'),(5,'This is leader','Tagline','ssdf','Admin','2021-05-18 15:42:07','about-bg.jpg'),(6,'The Empty  Post','Empty ','This post content is empty\r\n','Admin','2021-05-18 15:57:17','post-bg.jpg'),(7,'','','','Admin','2021-05-18 16:06:04',''),(8,'','','','Admin','2021-05-18 16:11:01',''),(9,'','','','Admin','2021-05-18 16:16:09',''),(16,'this is flash','flash','this is content for flash','Admin','2021-05-23 00:12:06','about-bg.jpg'),(14,'Add post debug','Debug tesing','This is post fo debugging','Admin','2021-05-22 00:23:21','about-bg.jpg'),(12,'MY Title','Tagline fo nre','This is content for new','Admin','2021-05-19 00:22:57','about-bg.jpg'),(15,'Check thuos','For template','This is me','Admin','2021-05-22 00:32:05','post-bg.jpg');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `uname` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'tom','tom@gmail.com','tom','tom'),(2,'joy','joy@gmail.com','joy123','joy'),(3,'kim','kim@gmail.com','kim123','kim'),(5,'hay','hay@gmail.com','hya123','hay'),(6,'yash','yash@gmail.com','pbkdf2:sha256:150000$O7Y1Xuig$a2e6a87dd4c0347fb363','yash'),(7,'adora','adora@gmail.com','pbkdf2:sha256:150000$3NS0xjo8$8150bf23dd8d278250ef','adora'),(8,'abey','abey@gmail.com','pbkdf2:sha256:150000$iZNO9n8I$61f6cb2fa80f31393d0c7b0760ad8d4d3f2f6daba8f52b4fa1a7128ae704d412','abey'),(9,'Jonny','jonny@gmail.com','pbkdf2:sha256:150000$C1QHU5xe$1d91631a94d20a99f0a391bfce1a2102bdcde559e94c1df58312b506fff4f328','jonny123');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-28 15:41:33

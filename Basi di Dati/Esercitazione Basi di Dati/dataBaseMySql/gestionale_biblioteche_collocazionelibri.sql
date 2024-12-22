-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: gestionale_biblioteche
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
-- Table structure for table `collocazionelibri`
--

DROP TABLE IF EXISTS `collocazionelibri`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collocazionelibri` (
  `ID` bigint NOT NULL AUTO_INCREMENT,
  `IDLibri` bigint DEFAULT NULL,
  `IDBiblioteca` bigint DEFAULT NULL,
  `Scaffale` varchar(2) DEFAULT NULL,
  `Posizione` varchar(3) DEFAULT NULL,
  `NumeroCopie` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDLibri` (`IDLibri`),
  KEY `IDBiblioteca` (`IDBiblioteca`),
  CONSTRAINT `collocazionelibri_ibfk_1` FOREIGN KEY (`IDLibri`) REFERENCES `libri` (`ID`),
  CONSTRAINT `collocazionelibri_ibfk_2` FOREIGN KEY (`IDBiblioteca`) REFERENCES `biblioteche` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collocazionelibri`
--

LOCK TABLES `collocazionelibri` WRITE;
/*!40000 ALTER TABLE `collocazionelibri` DISABLE KEYS */;
INSERT INTO `collocazionelibri` VALUES (1,1,1,'A1','001',3),(2,2,2,'B2','045',5),(3,3,3,'C3','078',2),(4,16,3,'5','6',1),(5,17,3,'25','213',1);
/*!40000 ALTER TABLE `collocazionelibri` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-17 16:35:41

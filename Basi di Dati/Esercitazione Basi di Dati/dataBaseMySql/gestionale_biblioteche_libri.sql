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
-- Table structure for table `libri`
--

DROP TABLE IF EXISTS `libri`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `libri` (
  `ID` bigint NOT NULL AUTO_INCREMENT,
  `ISBN` varchar(13) NOT NULL,
  `Titolo` varchar(255) NOT NULL,
  `Autore` varchar(255) DEFAULT NULL,
  `ID_Genere` bigint DEFAULT NULL,
  `Abstract` mediumtext,
  `Anno_Pubblicazione` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_Genere` (`ID_Genere`),
  FULLTEXT KEY `Abstract` (`Abstract`),
  CONSTRAINT `libri_ibfk_1` FOREIGN KEY (`ID_Genere`) REFERENCES `genere` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libri`
--

LOCK TABLES `libri` WRITE;
/*!40000 ALTER TABLE `libri` DISABLE KEYS */;
INSERT INTO `libri` VALUES (1,'9781234567897','Il Nome della Rosa','Umberto Eco',1,'Un giallo storico ambientato in un monastero benedettino.',1980),(2,'9781234567898','1984','George Orwell',4,'Una distopia futuristica sul totalitarismo.',1949),(3,'9781234567899','Il Signore degli Anelli','J.R.R. Tolkien',4,'Un classico della narrativa fantasy.',1954),(10,'9788804668239','La solitudine dei numeri primi','Paolo Giordano',1,'ciao ciao belli ',2008),(11,'9788804502474','La ragazza di Bube','Carlo Cassola',1,'ciao ciao belli ',1960),(12,'9788804517805','Il sentiero dei nidi di ragno','Italo Calvino',1,'domeniccccccc ',1947),(13,'9788804532761','La coscienza di Zeno','Italo Svevo',5,'gigi ',1923),(14,'9788804662114','Cronaca di una morte annunciata','Gabriel García Márquez',3,'miriam ',1981),(15,'9788806142936','1984','George Orwell',5,'gaetano ',1949),(16,'1256478952025','Veronica decide di morie','Paulo Coelho',5,'Dopo il tentato suicidio Veronika sarà ricoverata a Villette (clinica psichiatrica privata), dove conoscerà Mari, Zedka e Eduard, persone che la gente “normale” considera folli. Ma cos\'è in realtà la follia? Questo libro insegna che i folli sono coloro che hanno il coraggio di dimostrare alle gente il vero Io.',1987),(17,'1256573625425','Il Cammino di santiago','Paulo Coelho',7,'Il Cammino di Santiago racconta il viaggio del narratore Paulo lungo il sentiero dei pellegrini che conduce a Santiago di Compostela, in Spagna. a repentaglio la sua determinazione e la sua fede, schiva insidiosi pericoli e minacciose tentazioni, per ritrovare la spada che gli permetterà di diventare un Maestro Ram.',1987);
/*!40000 ALTER TABLE `libri` ENABLE KEYS */;
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

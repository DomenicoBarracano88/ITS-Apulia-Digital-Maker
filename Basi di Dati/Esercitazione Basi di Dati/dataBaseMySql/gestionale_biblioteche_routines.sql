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
-- Temporary view structure for view `dettaglilibri`
--

DROP TABLE IF EXISTS `dettaglilibri`;
/*!50001 DROP VIEW IF EXISTS `dettaglilibri`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `dettaglilibri` AS SELECT 
 1 AS `Id`,
 1 AS `Titolo`,
 1 AS `Autore`,
 1 AS `ISBN`,
 1 AS `Genere`,
 1 AS `Trama`,
 1 AS `Biblioteca`,
 1 AS `scaffale`,
 1 AS `posizione`,
 1 AS `NumeroCopie`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `dettaglilibri`
--

/*!50001 DROP VIEW IF EXISTS `dettaglilibri`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `dettaglilibri` AS select `l`.`ID` AS `Id`,`l`.`Titolo` AS `Titolo`,`l`.`Autore` AS `Autore`,`l`.`ISBN` AS `ISBN`,`g`.`DescrizioneGenere` AS `Genere`,`l`.`Abstract` AS `Trama`,concat(`b`.`Denominazione`,' ',`b`.`Via`,' ',`b`.`Civico`,' ',`b`.`Comune`) AS `Biblioteca`,`cl`.`Scaffale` AS `scaffale`,`cl`.`Posizione` AS `posizione`,`cl`.`NumeroCopie` AS `NumeroCopie` from (((`collocazionelibri` `cl` join `libri` `l` on((`cl`.`IDLibri` = `l`.`ID`))) join `biblioteche` `b` on((`b`.`ID` = `cl`.`IDBiblioteca`))) join `genere` `g` on((`g`.`ID` = `l`.`ID_Genere`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping routines for database 'gestionale_biblioteche'
--
/*!50003 DROP PROCEDURE IF EXISTS `InserisciLibro` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InserisciLibro`(
    IN p_ISBN VARCHAR(13),
    IN p_Titolo VARCHAR(255),
    IN p_Autore VARCHAR(255),
    IN p_DescrizioneGenere VARCHAR(150),
    IN p_Abstract MEDIUMTEXT,
    IN p_Anno_Pubblicazione INT,
    IN p_IDBiblioteca BIGINT,
    IN p_Scaffale VARCHAR(2),
    IN p_Posizione VARCHAR(3),
    IN p_NumeroCopie INT
)
BEGIN
    DECLARE v_ID_Genere BIGINT;
    DECLARE v_ID_Libro BIGINT;
    
    -- Controlla se il genere esiste, altrimenti aggiungilo
    SELECT ID INTO v_ID_Genere
    FROM Genere
    WHERE DescrizioneGenere = p_DescrizioneGenere;
    
    IF v_ID_Genere IS NULL THEN
        INSERT INTO Genere (DescrizioneGenere) VALUES (p_DescrizioneGenere);
        SET v_ID_Genere = LAST_INSERT_ID();
    END IF;

    -- Controlla se il libro esiste già
    SELECT ID INTO v_ID_Libro
    FROM Libri
    WHERE ISBN = p_ISBN;
    
    IF v_ID_Libro IS NULL THEN
        -- Inserisci il nuovo libro
        INSERT INTO Libri (ISBN, Titolo, Autore, ID_Genere, Abstract, Anno_Pubblicazione)
        VALUES (p_ISBN, p_Titolo, p_Autore, v_ID_Genere, p_Abstract, p_Anno_Pubblicazione);
        SET v_ID_Libro = LAST_INSERT_ID();
        
        -- Inserisci la collocazione del libro
        INSERT INTO CollocazioneLibri (IDLibri, IDBiblioteca, Scaffale, Posizione, NumeroCopie)
        VALUES (v_ID_Libro, p_IDBiblioteca, p_Scaffale, p_Posizione, p_NumeroCopie);
    ELSE
        -- Incrementa il numero di copie se il libro esiste già
        UPDATE CollocazioneLibri
        SET NumeroCopie = NumeroCopie + p_NumeroCopie
        WHERE IDLibri = v_ID_Libro AND IDBiblioteca = p_IDBiblioteca;
        
        -- Se non esiste una collocazione per questo libro e biblioteca, aggiungila
        IF ROW_COUNT() = 0 THEN
            INSERT INTO CollocazioneLibri (IDLibri, IDBiblioteca, Scaffale, Posizione, NumeroCopie)
            VALUES (v_ID_Libro, p_IDBiblioteca, p_Scaffale, p_Posizione, p_NumeroCopie);
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Ricerca_Genere` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Ricerca_Genere`(genere varchar(150))
BEGIN
select * from dettagliLibri where genere = dettaglilibri.Genere;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Ricerca_ID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Ricerca_ID`(idLibri bigint)
BEGIN
select * from dettagliLibri where idLibri = dettaglilibri.Id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Ricerca_ISBN` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Ricerca_ISBN`(ISBN VARCHAR(13))
BEGIN
SELECT  * from dettagliLibri where ISBN = dettaglilibri.ISBN;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ricerca_per_titolo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ricerca_per_titolo`(titolo varchar(255))
BEGIN
select * from dettagliLibri where titolo = dettaglilibri.titolo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Ricerca_Trama` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Ricerca_Trama`(parole mediumtext)
BEGIN
select * from dettagliLibri DL where MATCH(DL.trama) AGAINST (parole);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-17 16:35:42

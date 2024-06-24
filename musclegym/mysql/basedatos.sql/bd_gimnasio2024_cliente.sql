-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: bd_gimnasio2024
-- ------------------------------------------------------
-- Server version	8.0.30

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
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `ID_Cliente` varchar(20) NOT NULL,
  `p_Nombre` varchar(20) NOT NULL,
  `s_Nombre` varchar(20) DEFAULT NULL,
  `p_Apellido` varchar(20) NOT NULL,
  `s_Apellido` varchar(20) DEFAULT NULL,
  `Fecha_Nacimiento` date NOT NULL,
  `Genero` varchar(10) NOT NULL,
  `Telefono` int NOT NULL,
  `Email` varchar(30) NOT NULL,
  `Dirección` varchar(30) NOT NULL,
  `Estado` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID_Cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES ('1111','Maria','paula','Talero','Gracia','2002-05-09','Femenino',6081241,'mptg@gmail.com','calle falsa 148',1),('1122','Brayan','white','Oconner','Toreto','1986-05-13','Masculino',6081242,'bwot@gmail.com','calle real 149',1),('1133','Juan','Esteban','Soche','Lopez','1985-04-01','Masculino',6081243,'jesl@gmail.com','calle real 150',0),('1234','Juan','Alberto','Palacios','Gutierrez','1999-10-16','Masculino',6041234,'japg@gmail.com','calle falsa 123',1),('2345','Ricardo','Jorge','Sarmiento','Angulo','2001-06-30','Masculino',6081239,'rjsa@gmail.com','calle falsa 146',1),('3456','Karen',NULL,'Sanchez','Gomez','1995-12-24','Femenino',6071237,'ksg@gmail.com','calle media 789',1),('5678','Ana','Maria','Ruiz','Camacho','2006-11-21','Femenino',6051235,'amrc@gmail.com','calle real 123',1),('6789','Camila','Andrea','Gutierrez','Lopez','1987-05-12','Femenino',6081240,'cagl@gmail.com','calle falsa 147',1),('7890','Andres','Felipe','Perez','Ruiz','2000-09-06','Masculino',6081238,'afpr@gmail.com','calle falsa 145',0),('9012','Miguel','Angel','Suarez','peña','2002-01-30','Masculino',6061236,'masp@gmail.com','calle media 456',0);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-23 22:33:01

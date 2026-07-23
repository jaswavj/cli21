-- MySQL dump 10.13  Distrib 8.4.7, for Win64 (x86_64)
--
-- Host: localhost    Database: periyanayaki
-- ------------------------------------------------------
-- Server version	8.4.7

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
-- Table structure for table `attender`
--

DROP TABLE IF EXISTS `attender`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attender` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `is_active` int DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attender`
--

LOCK TABLES `attender` WRITE;
/*!40000 ALTER TABLE `attender` DISABLE KEYS */;
/*!40000 ALTER TABLE `attender` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_details`
--

DROP TABLE IF EXISTS `company_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company_details` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `shop_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `address` text,
  `gstin` varchar(255) DEFAULT NULL,
  `print_type` int NOT NULL DEFAULT '0',
  `printer_name` varchar(255) DEFAULT NULL,
  `bank_details` varchar(255) DEFAULT NULL,
  `barcode_printer` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_details`
--

LOCK TABLES `company_details` WRITE;
/*!40000 ALTER TABLE `company_details` DISABLE KEYS */;
INSERT INTO `company_details` VALUES (2,'PERIYANAYAKI LOGISTICS','No.18, Officers Colony 4th Main Road,\r\nAdambakkam,Chennai-600088\r\n9994182275 / 9884483426\r\nE-mail : periyanayakilogistics@gmail.com','33GYVPS4944G1ZN',2,'','Bank Name  : INDIAN BANK\r\nAccount no  : 8041288275\r\nIFSC             : IDIB000G079\r\nBranch         : G N Chetty Road','AP4909');
/*!40000 ALTER TABLE `company_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configure_bank_details`
--

DROP TABLE IF EXISTS `configure_bank_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `configure_bank_details` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_blocked` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configure_bank_details`
--

LOCK TABLES `configure_bank_details` WRITE;
/*!40000 ALTER TABLE `configure_bank_details` DISABLE KEYS */;
INSERT INTO `configure_bank_details` VALUES (1,'SBI BANK',0),(2,'CANARA BANK',0),(3,'AXIS BANK',0),(4,'IOB BANK',0);
/*!40000 ALTER TABLE `configure_bank_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configure_payment_type`
--

DROP TABLE IF EXISTS `configure_payment_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `configure_payment_type` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_blocked` int unsigned NOT NULL DEFAULT '0',
  `type_id` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configure_payment_type`
--

LOCK TABLES `configure_payment_type` WRITE;
/*!40000 ALTER TABLE `configure_payment_type` DISABLE KEYS */;
INSERT INTO `configure_payment_type` VALUES (1,'Cash',0,1),(2,'BANK',0,2);
/*!40000 ALTER TABLE `configure_payment_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_days`
--

DROP TABLE IF EXISTS `credit_days`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credit_days` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `credit_days` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_days`
--

LOCK TABLES `credit_days` WRITE;
/*!40000 ALTER TABLE `credit_days` DISABLE KEYS */;
INSERT INTO `credit_days` VALUES (1,10);
/*!40000 ALTER TABLE `credit_days` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_account`
--

DROP TABLE IF EXISTS `customer_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_account` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `advance` decimal(10,2) NOT NULL DEFAULT '0.00',
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_id` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_account`
--

LOCK TABLES `customer_account` WRITE;
/*!40000 ALTER TABLE `customer_account` DISABLE KEYS */;
INSERT INTO `customer_account` VALUES (1,4,0.00,0.00),(2,5,0.00,0.00),(3,6,0.00,0.00),(4,7,0.00,0.00),(5,8,0.00,0.00),(6,9,0.00,0.00),(7,10,0.00,0.00),(8,11,0.00,0.00),(9,12,0.00,0.00),(10,13,0.00,0.00),(11,14,0.00,0.00),(12,15,0.00,0.00),(13,16,0.00,0.00),(14,17,0.00,0.00);
/*!40000 ALTER TABLE `customer_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `is_eligible_for_commission` tinyint DEFAULT '1',
  `is_active` int DEFAULT '1',
  `gstin` varchar(255) DEFAULT NULL,
  `is_gst` int DEFAULT '0',
  `salesman` int DEFAULT NULL,
  `area` int DEFAULT NULL,
  `credit_limit` double(10,2) NOT NULL DEFAULT '0.00',
  `local` int DEFAULT '1',
  `exchange_point` double(10,3) DEFAULT '0.000',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'JASWA VIJAY','9597451419','SFASDFSADDFSD \r\nasgsdg \r\nSFSDDSDDGSDG','2026-06-10','21:47:48',0,1,'2112232wfsfffsd',1,NULL,NULL,0.00,1,0.000),(2,'jeb','9898989898','','2026-06-10','22:20:38',0,1,'',0,NULL,NULL,0.00,1,0.000),(3,'cc','','','2026-06-13','11:13:27',0,1,'',0,NULL,NULL,0.00,1,0.000),(4,'M/s.Tablets India Ltd.,','','Jhaver Center, No-72,Marshal Street,  \r\nChennai-600008          ','2026-06-13','13:38:44',0,1,'33AAACT7987L1ZP',1,NULL,NULL,0.00,1,0.000),(5,'M/s.Subbulakshmi Enterprises, ','','384B, Thamarai Street, Poompozhil Nagar, Avadi,Chennai - 600062','2026-06-15','12:18:46',0,1,'33ACIFS3563J1ZW',1,NULL,NULL,0.00,1,0.000),(6,'M/s.Crown Worldwide Private Ltd.,','','119/1B1K, Moopanar Street, \r\nPerumattunallur, Pandur Village, \r\nChengalpattu District, Tamilnadu-603202','2026-06-15','12:39:48',0,1,'33AAACC6484D1ZX',1,NULL,NULL,0.00,1,0.000),(7,'M/s. BES Global Logistics Pvt Ltd.,','','JK Towers No-28, 3rd Floor,\r\n\'\"B\" Wing Bazullah Road,\r\n T.Nagar,Chennai-600017','2026-06-15','13:17:56',0,1,'33AAJCB8783B1ZN',1,NULL,NULL,0.00,1,0.000),(8,'M/s.Star Worldwide Group Private Ltd.,','','Lokesh Nagar, Old No. 1/10, New No.1/10A1, Tiruverkadu,Periyakoladi Road,Chennai Thiruvallur-600077','2026-06-15','13:46:19',0,1,'33AABCS5979A1ZG',1,NULL,NULL,0.00,1,0.000),(9,'M/s.Time Medical International Ventures (I) Pvt Ltd.,','','Level-8 Prestige Palladium Bayan,\r\nNo-129-140, Thousand Lights, Greams Road,   \r\nChennai-600006','2026-06-24','19:09:37',0,1,'33AAHCT1130G1ZU',1,NULL,NULL,0.00,1,0.000),(10,'M/s.Fischer Medical Ventures Ltd.,','','AMTZ Campus, Pragati Maidan,\r\nVM Steel Project S.O, \r\nVisakhapatnam','2026-06-24','19:11:27',0,1,'37AAACF0641D1Z7',1,NULL,NULL,0.00,1,0.000),(11,'M/s.ALLIANZ BIOSCIENCES PRIVATE LIMITED.,				','','55/1 2 & 3 WHIRLPOOL ROAD, \r\nTHIRUVANDAR KOIL VILLAGE, MANNADIPET COMMUNE,\r\nPONDICHERRY-605102.','2026-06-24','19:12:57',0,1,'37AAACF0641D1Z7',1,NULL,NULL,0.00,1,0.000),(12,'M/s.Sheng Long Bio-Tech (India) Pvt Ltd.,','','Chennai-601202','2026-06-24','19:13:56',0,1,'33AAVCS2912F1ZB',1,NULL,NULL,0.00,1,0.000),(13,'M/s.Freyer International Logistics Pvt Ltd.,','','New No-45, Old No-20 TAGA Tower 1st Floor,             \r\nSait Colony 2nd Street, Egmore, \r\nChennai-600008','2026-06-24','19:15:21',0,1,'33AAQCA4076M1Z8',1,NULL,NULL,0.00,1,0.000),(14,'KV Movers','','77/1 Prakasam Salai\r\nChennai 600108','2026-06-29','20:08:43',0,1,'33AAKFK2907Q2ZX',1,NULL,NULL,0.00,1,0.000),(15,'Prakash','','','2026-07-02','11:11:29',0,1,'',0,NULL,NULL,0.00,1,0.000),(16,'SRIRAM','','Chennai','2026-07-02','12:00:07',0,1,'',0,NULL,NULL,0.00,1,0.000),(17,'UKL INSTRUMENTS PVT LTD','','232, 7th Street, Ashtalakshmi Nagar,  Alapakkam, Chennai -600 116','2026-07-18','14:23:24',0,1,'33AAACU8077E1ZC',1,NULL,NULL,0.00,1,0.000);
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers_exchange_point`
--

DROP TABLE IF EXISTS `customers_exchange_point`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers_exchange_point` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `bill_id` int NOT NULL,
  `old_point` double(10,3) DEFAULT '0.000',
  `exchange_point` double(10,3) DEFAULT '0.000',
  `total_point` double(10,3) DEFAULT '0.000',
  `uid` int DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers_exchange_point`
--

LOCK TABLES `customers_exchange_point` WRITE;
/*!40000 ALTER TABLE `customers_exchange_point` DISABLE KEYS */;
/*!40000 ALTER TABLE `customers_exchange_point` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expense_entry`
--

DROP TABLE IF EXISTS `expense_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expense_entry` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `exp_type` int NOT NULL,
  `content` varchar(255) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `description` text,
  `exc_date_time` datetime DEFAULT NULL,
  `entry_date_time` datetime DEFAULT NULL,
  `is_active` int DEFAULT '1',
  `uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`exp_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expense_entry`
--

LOCK TABLES `expense_entry` WRITE;
/*!40000 ALTER TABLE `expense_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `expense_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expense_type`
--

DROP TABLE IF EXISTS `expense_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expense_type` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `is_active` int DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expense_type`
--

LOCK TABLES `expense_type` WRITE;
/*!40000 ALTER TABLE `expense_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `expense_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gstin`
--

DROP TABLE IF EXISTS `gstin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gstin` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `gstin` varchar(255) NOT NULL,
  `shop_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gstin`
--

LOCK TABLES `gstin` WRITE;
/*!40000 ALTER TABLE `gstin` DISABLE KEYS */;
/*!40000 ALTER TABLE `gstin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `heading`
--

DROP TABLE IF EXISTS `heading`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `heading` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `head1` varchar(255) DEFAULT NULL,
  `head2` varchar(255) DEFAULT NULL,
  `head3` varchar(255) DEFAULT NULL,
  `active` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `heading`
--

LOCK TABLES `heading` WRITE;
/*!40000 ALTER TABLE `heading` DISABLE KEYS */;
INSERT INTO `heading` VALUES (1,'Category','Brand','Product',200);
/*!40000 ALTER TABLE `heading` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_tables`
--

DROP TABLE IF EXISTS `order_tables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_tables` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_occupied` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_tables`
--

LOCK TABLES `order_tables` WRITE;
/*!40000 ALTER TABLE `order_tables` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_tables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pro_bill_exchange`
--

DROP TABLE IF EXISTS `pro_bill_exchange`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pro_bill_exchange` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `old_prod_id` int NOT NULL,
  `new_prod_id` int NOT NULL,
  `uid` int NOT NULL,
  `date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pro_bill_exchange`
--

LOCK TABLES `pro_bill_exchange` WRITE;
/*!40000 ALTER TABLE `pro_bill_exchange` DISABLE KEYS */;
/*!40000 ALTER TABLE `pro_bill_exchange` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_batch`
--

DROP TABLE IF EXISTS `prod_batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_batch` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `product_id` int NOT NULL,
  `cost` double(10,3) DEFAULT '0.000',
  `mrp` double(10,3) DEFAULT '0.000',
  `commission` double(10,3) DEFAULT '0.000',
  `stock` decimal(10,2) NOT NULL,
  `disc_type` int DEFAULT '0' COMMENT '1=rs 2=%',
  `discount` double(10,3) DEFAULT '0.000',
  `date` date DEFAULT NULL,
  `time` time DEFAULT '00:00:00',
  `added_stock` decimal(10,2) NOT NULL,
  `uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `prod` (`product_id`),
  KEY `disc` (`disc_type`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_batch`
--

LOCK TABLES `prod_batch` WRITE;
/*!40000 ALTER TABLE `prod_batch` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_batch_updated`
--

DROP TABLE IF EXISTS `prod_batch_updated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_batch_updated` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `product_id` int NOT NULL,
  `cost` double(10,3) NOT NULL DEFAULT '0.000',
  `mrp` double(10,3) NOT NULL DEFAULT '0.000',
  `stock` decimal(10,2) NOT NULL,
  `disc_type` int DEFAULT '0' COMMENT '1=rs 2=%',
  `discount` double(10,3) DEFAULT '0.000',
  `date` date DEFAULT NULL,
  `time` time DEFAULT '00:00:00',
  `added_stock` decimal(10,2) NOT NULL,
  `uid` int NOT NULL DEFAULT '0',
  `updatedDate` date DEFAULT NULL,
  `updatedTime` time DEFAULT '00:00:00',
  `updatedUid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `prod` (`product_id`),
  KEY `disc` (`disc_type`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_batch_updated`
--

LOCK TABLES `prod_batch_updated` WRITE;
/*!40000 ALTER TABLE `prod_batch_updated` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_batch_updated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_batch_zero_stock_bill`
--

DROP TABLE IF EXISTS `prod_batch_zero_stock_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_batch_zero_stock_bill` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `batch_id` varchar(255) NOT NULL,
  `product_id` int NOT NULL,
  `qty` decimal(10,2) NOT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT '00:00:00',
  `uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `batch` (`batch_id`),
  KEY `prod` (`product_id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_batch_zero_stock_bill`
--

LOCK TABLES `prod_batch_zero_stock_bill` WRITE;
/*!40000 ALTER TABLE `prod_batch_zero_stock_bill` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_batch_zero_stock_bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_bill`
--

DROP TABLE IF EXISTS `prod_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_bill` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `bill_display` varchar(255) NOT NULL,
  `is_tax_bill` tinyint(1) DEFAULT '1',
  `is_receipt` int DEFAULT '1',
  `total` double(10,3) DEFAULT '0.000',
  `prodDisc` double(10,3) DEFAULT '0.000',
  `extraDisc` double(10,3) DEFAULT '0.000',
  `payable` double(10,3) DEFAULT '0.000',
  `paid` double(10,3) DEFAULT '0.000',
  `balance` double(10,3) DEFAULT '0.000',
  `currentBalance` double(10,3) DEFAULT '0.000',
  `is_balance` int DEFAULT '0',
  `paymentMode` int NOT NULL COMMENT 'prod_bill_payment_mode',
  `paymentType` int DEFAULT '0' COMMENT 'prod_bill_payment_type',
  `uid` int NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL DEFAULT '00:00:00',
  `is_cancelled` int DEFAULT '0',
  `bill_type` int DEFAULT '1' COMMENT '1=prod bill',
  `cusName` varchar(255) DEFAULT '""',
  `cusPhn` varchar(255) DEFAULT '-',
  `customerId` int DEFAULT NULL,
  `price_category` int NOT NULL,
  `lr_no` varchar(255) DEFAULT NULL,
  `lr_date` date DEFAULT NULL,
  `lr_name` varchar(255) DEFAULT NULL,
  `attender_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `mode` (`paymentMode`),
  KEY `type` (`paymentType`),
  KEY `idx_is_tax_bill` (`is_tax_bill`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_bill`
--

LOCK TABLES `prod_bill` WRITE;
/*!40000 ALTER TABLE `prod_bill` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_bill_cancel`
--

DROP TABLE IF EXISTS `prod_bill_cancel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_bill_cancel` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `reason` text,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `uid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `billId` (`bill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_bill_cancel`
--

LOCK TABLES `prod_bill_cancel` WRITE;
/*!40000 ALTER TABLE `prod_bill_cancel` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_bill_cancel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_bill_datechange`
--

DROP TABLE IF EXISTS `prod_bill_datechange`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_bill_datechange` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `billId` int NOT NULL,
  `oldDate` date DEFAULT NULL,
  `changeDate` date DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `billId` (`billId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_bill_datechange`
--

LOCK TABLES `prod_bill_datechange` WRITE;
/*!40000 ALTER TABLE `prod_bill_datechange` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_bill_datechange` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_bill_details`
--

DROP TABLE IF EXISTS `prod_bill_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_bill_details` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `prod_id` int NOT NULL,
  `qty` decimal(10,2) NOT NULL,
  `price` double(10,3) DEFAULT '0.000',
  `disc` double(10,3) DEFAULT '0.000',
  `total` double(10,3) DEFAULT '0.000',
  `cost` double(10,3) DEFAULT '0.000',
  `commission` double(10,3) DEFAULT '0.000',
  `gst` int NOT NULL DEFAULT '0',
  `is_cancelled` int DEFAULT '0',
  `cancel_date` datetime DEFAULT NULL,
  `is_exchanged` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `bill` (`bill_id`),
  KEY `prod` (`prod_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_bill_details`
--

LOCK TABLES `prod_bill_details` WRITE;
/*!40000 ALTER TABLE `prod_bill_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_bill_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_bill_due`
--

DROP TABLE IF EXISTS `prod_bill_due`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_bill_due` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `amount` double(10,3) NOT NULL DEFAULT '0.000',
  `cash_paid` double(10,3) NOT NULL DEFAULT '0.000',
  `bank_paid` double(10,3) NOT NULL DEFAULT '0.000',
  `balance` double(10,3) NOT NULL DEFAULT '0.000',
  `pay_mode` tinyint NOT NULL DEFAULT '1',
  `pay_type` tinyint NOT NULL DEFAULT '0',
  `uid` int NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_bill_due`
--

LOCK TABLES `prod_bill_due` WRITE;
/*!40000 ALTER TABLE `prod_bill_due` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_bill_due` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_bill_due_collection`
--

DROP TABLE IF EXISTS `prod_bill_due_collection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_bill_due_collection` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `balance` double(10,2) DEFAULT NULL,
  `paid` double(10,2) DEFAULT NULL,
  `finalBalance` double(10,2) DEFAULT NULL,
  `mode` int DEFAULT NULL,
  `bankOption` int DEFAULT NULL,
  `uid` int NOT NULL,
  `collectDate` varchar(255) DEFAULT NULL,
  `collectTime` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `billId` (`bill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_bill_due_collection`
--

LOCK TABLES `prod_bill_due_collection` WRITE;
/*!40000 ALTER TABLE `prod_bill_due_collection` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_bill_due_collection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_bill_payment`
--

DROP TABLE IF EXISTS `prod_bill_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_bill_payment` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `cash` double(10,2) DEFAULT '0.00',
  `bank` double(10,2) DEFAULT '0.00',
  `paymentType` int DEFAULT '0' COMMENT 'prod_bill_payment_type',
  PRIMARY KEY (`id`),
  KEY `billid` (`bill_id`),
  KEY `paymentType` (`paymentType`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_bill_payment`
--

LOCK TABLES `prod_bill_payment` WRITE;
/*!40000 ALTER TABLE `prod_bill_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_bill_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_bill_payment_mode`
--

DROP TABLE IF EXISTS `prod_bill_payment_mode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_bill_payment_mode` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `mode` varchar(255) NOT NULL,
  `is_active` int DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_bill_payment_mode`
--

LOCK TABLES `prod_bill_payment_mode` WRITE;
/*!40000 ALTER TABLE `prod_bill_payment_mode` DISABLE KEYS */;
INSERT INTO `prod_bill_payment_mode` VALUES (1,'cash',1),(2,'bank',1),(3,'mixed',1);
/*!40000 ALTER TABLE `prod_bill_payment_mode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_bill_payment_type`
--

DROP TABLE IF EXISTS `prod_bill_payment_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_bill_payment_type` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `is_active` int DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_bill_payment_type`
--

LOCK TABLES `prod_bill_payment_type` WRITE;
/*!40000 ALTER TABLE `prod_bill_payment_type` DISABLE KEYS */;
INSERT INTO `prod_bill_payment_type` VALUES (0,'CASH',1),(1,'UPI',1),(2,'DEBIT CARD',1),(3,'CREDIT CARD',1),(4,'NET BANKING',1),(5,'WALLET',1),(6,'CHEQUE',1);
/*!40000 ALTER TABLE `prod_bill_payment_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_bill_payment_type_change`
--

DROP TABLE IF EXISTS `prod_bill_payment_type_change`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_bill_payment_type_change` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `old_cash_amount` double(10,3) DEFAULT NULL,
  `cash_amount` double(10,3) DEFAULT NULL,
  `old_bank_amount` double(10,3) DEFAULT NULL,
  `bank_amount` double(10,3) DEFAULT NULL,
  `bank_mode` int DEFAULT NULL,
  `uid` int DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_bill_payment_type_change`
--

LOCK TABLES `prod_bill_payment_type_change` WRITE;
/*!40000 ALTER TABLE `prod_bill_payment_type_change` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_bill_payment_type_change` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_brands`
--

DROP TABLE IF EXISTS `prod_brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_brands` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `is_active` int DEFAULT '1',
  PRIMARY KEY (`id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_brands`
--

LOCK TABLES `prod_brands` WRITE;
/*!40000 ALTER TABLE `prod_brands` DISABLE KEYS */;
INSERT INTO `prod_brands` VALUES (1,'own','2026-05-14','13:02:30',1);
/*!40000 ALTER TABLE `prod_brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_category`
--

DROP TABLE IF EXISTS `prod_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_category` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `is_active` int DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_category`
--

LOCK TABLES `prod_category` WRITE;
/*!40000 ALTER TABLE `prod_category` DISABLE KEYS */;
INSERT INTO `prod_category` VALUES (1,'Dress','2026-05-14','13:02:23',1),(2,'Wire','2026-05-23','13:40:32',1);
/*!40000 ALTER TABLE `prod_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_cheque_allocation`
--

DROP TABLE IF EXISTS `prod_cheque_allocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_cheque_allocation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cheque_id` int NOT NULL,
  `bill_id` int NOT NULL,
  `allocated_amount` double NOT NULL,
  `allocated_date` date DEFAULT NULL,
  `allocated_time` time DEFAULT NULL,
  `due_date` date NOT NULL,
  `credit_days` int DEFAULT '10',
  `status` enum('ALLOCATED','CLEARED','REVERSED','BOUNCED') DEFAULT 'ALLOCATED',
  `cleared_date` date DEFAULT NULL,
  `cleared_time` time DEFAULT NULL,
  `reversed_date` date DEFAULT NULL,
  `reversed_time` time DEFAULT NULL,
  `reversed_by` int DEFAULT NULL,
  `is_reversed` tinyint DEFAULT '0',
  `uid` int NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  KEY `idx_cheque` (`cheque_id`),
  KEY `idx_bill` (`bill_id`),
  KEY `idx_status` (`status`),
  KEY `idx_due_date` (`due_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_cheque_allocation`
--

LOCK TABLES `prod_cheque_allocation` WRITE;
/*!40000 ALTER TABLE `prod_cheque_allocation` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_cheque_allocation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_cheque_events`
--

DROP TABLE IF EXISTS `prod_cheque_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_cheque_events` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cheque_id` int NOT NULL,
  `event_type` enum('BOUNCE','EXPIRY','MANUAL_CLEAR') NOT NULL,
  `event_date` date DEFAULT NULL,
  `event_time` time DEFAULT NULL,
  `reason` text,
  `uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cheque` (`cheque_id`),
  KEY `idx_event_type` (`event_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_cheque_events`
--

LOCK TABLES `prod_cheque_events` WRITE;
/*!40000 ALTER TABLE `prod_cheque_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_cheque_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_cheque_stock`
--

DROP TABLE IF EXISTS `prod_cheque_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_cheque_stock` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `cheque_number` varchar(50) NOT NULL,
  `bank_name` text,
  `status` enum('AVAILABLE','PARTIAL','FULLY_USED','CLEARED','BOUNCED','EXPIRED') DEFAULT 'AVAILABLE',
  `entry_date` date DEFAULT NULL,
  `entry_time` time DEFAULT NULL,
  `uid` int NOT NULL,
  `notes` text,
  `is_active` tinyint DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_customer` (`customer_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_cheque_stock`
--

LOCK TABLES `prod_cheque_stock` WRITE;
/*!40000 ALTER TABLE `prod_cheque_stock` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_cheque_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_lifecycle`
--

DROP TABLE IF EXISTS `prod_lifecycle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_lifecycle` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL DEFAULT '0',
  `batch_id` int NOT NULL,
  `product_id` int NOT NULL,
  `stock_in` decimal(10,2) NOT NULL DEFAULT '0.00',
  `stock_out` decimal(10,2) NOT NULL DEFAULT '0.00',
  `stock_now` decimal(10,2) NOT NULL,
  `is_zero_stock_bill` int DEFAULT '0',
  `notes` text,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `uid` int NOT NULL,
  `stock_type` int DEFAULT '1' COMMENT '1=stock 2=noStock',
  `stockAdjType` int DEFAULT '0' COMMENT '1=add 2=remove',
  PRIMARY KEY (`id`),
  KEY `batch` (`batch_id`),
  KEY `prod` (`product_id`),
  KEY `uid` (`uid`),
  KEY `stock` (`stockAdjType`),
  KEY `billId` (`bill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_lifecycle`
--

LOCK TABLES `prod_lifecycle` WRITE;
/*!40000 ALTER TABLE `prod_lifecycle` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_lifecycle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_order`
--

DROP TABLE IF EXISTS `prod_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_order` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `order_no` varchar(255) NOT NULL,
  `table_id` int NOT NULL,
  `is_delivered` int DEFAULT '0',
  `is_billed` int DEFAULT '0',
  `is_cancelled` int DEFAULT '0',
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `uid` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_order`
--

LOCK TABLES `prod_order` WRITE;
/*!40000 ALTER TABLE `prod_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_order_details`
--

DROP TABLE IF EXISTS `prod_order_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_order_details` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `prod_id` int NOT NULL,
  `qty` int NOT NULL,
  `price` double(10,3) DEFAULT '0.000',
  `total` double(10,3) DEFAULT '0.000',
  `is_delivered` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_order_details`
--

LOCK TABLES `prod_order_details` WRITE;
/*!40000 ALTER TABLE `prod_order_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_order_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_product`
--

DROP TABLE IF EXISTS `prod_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_product` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT '0',
  `category_id` int NOT NULL,
  `brand_id` int NOT NULL,
  `unit_id` int DEFAULT '1',
  `hsn` int DEFAULT NULL,
  `uid` int NOT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `is_active` int DEFAULT '1',
  `gst` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cat` (`category_id`),
  KEY `brand` (`brand_id`),
  KEY `uid` (`uid`),
  KEY `unit` (`unit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_product`
--

LOCK TABLES `prod_product` WRITE;
/*!40000 ALTER TABLE `prod_product` DISABLE KEYS */;
INSERT INTO `prod_product` VALUES (1,'Denim','102',1,1,1,NULL,1,'2026-06-10','21:46:59',1,12);
/*!40000 ALTER TABLE `prod_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_product_components`
--

DROP TABLE IF EXISTS `prod_product_components`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_product_components` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL COMMENT 'Main product ID',
  `component_product_id` int NOT NULL COMMENT 'Component product ID',
  `quantity` decimal(10,2) DEFAULT '1.00' COMMENT 'Quantity needed',
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `prod` (`product_id`),
  KEY `compo` (`component_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_product_components`
--

LOCK TABLES `prod_product_components` WRITE;
/*!40000 ALTER TABLE `prod_product_components` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_product_components` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_purchase`
--

DROP TABLE IF EXISTS `prod_purchase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_purchase` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `prno` varchar(25) NOT NULL DEFAULT '',
  `invno` varchar(255) DEFAULT '',
  `invdate` date DEFAULT NULL,
  `total` double(10,2) NOT NULL DEFAULT '0.00',
  `paid` double(10,2) NOT NULL DEFAULT '0.00',
  `balance` double(10,2) DEFAULT '0.00',
  `discount` double(10,2) DEFAULT '0.00',
  `net` double NOT NULL DEFAULT '0',
  `ent_date` date NOT NULL DEFAULT '0001-01-01',
  `ent_time` time NOT NULL DEFAULT '00:00:00',
  `ent_uid` int unsigned NOT NULL DEFAULT '0',
  `ispending` tinyint unsigned DEFAULT '0',
  `pay_type` int unsigned NOT NULL DEFAULT '0',
  `bank_id` int unsigned NOT NULL DEFAULT '0',
  `deal_id` int unsigned DEFAULT '0',
  `remark` varchar(100) NOT NULL DEFAULT '0',
  `is_cancelled` tinyint(1) NOT NULL DEFAULT '0',
  `cancel_date` date DEFAULT '0001-01-01',
  `cancel_time` time DEFAULT '00:00:00',
  `cancel_uid` varchar(10) DEFAULT '0',
  `is_po` tinyint DEFAULT '0',
  `po_status` tinyint DEFAULT '1',
  `pr_id` int DEFAULT NULL,
  `grn_id` int DEFAULT '0',
  `expected_date` date DEFAULT NULL,
  `po_notes` text,
  `offer` text,
  `offer_date` date DEFAULT NULL,
  `lr_no` varchar(255) DEFAULT NULL,
  `lr_date` date DEFAULT NULL,
  `lr_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `prno` (`prno`),
  KEY `dealer` (`deal_id`),
  KEY `grnid` (`grn_id`),
  KEY `status` (`po_status`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_purchase`
--

LOCK TABLES `prod_purchase` WRITE;
/*!40000 ALTER TABLE `prod_purchase` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_purchase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_purchase_counter`
--

DROP TABLE IF EXISTS `prod_purchase_counter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_purchase_counter` (
  `id` int NOT NULL,
  `last_pr_no` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_purchase_counter`
--

LOCK TABLES `prod_purchase_counter` WRITE;
/*!40000 ALTER TABLE `prod_purchase_counter` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_purchase_counter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_purchase_details`
--

DROP TABLE IF EXISTS `prod_purchase_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_purchase_details` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `prid` int unsigned DEFAULT '0',
  `prods_id` int DEFAULT '0',
  `pack` int DEFAULT '0',
  `qtypack` decimal(10,2) DEFAULT '0.00',
  `quantity` decimal(10,2) unsigned DEFAULT '0.00',
  `free` int unsigned DEFAULT '0',
  `rate` double(10,3) DEFAULT '0.000',
  `mrp` double(10,3) DEFAULT '0.000',
  `totalamt` double(10,3) DEFAULT '0.000',
  `tax` double(10,2) NOT NULL DEFAULT '0.00',
  `tax_amt` double(10,3) DEFAULT '0.000',
  `mrp_vat_amt` double(10,2) DEFAULT '0.00',
  `disc_per` double(10,2) DEFAULT '0.00',
  `disc` double(10,3) DEFAULT '0.000',
  `netamt` double(10,3) DEFAULT '0.000',
  `isinvoicereceived` int unsigned NOT NULL DEFAULT '0',
  `hsn_code` varchar(20) NOT NULL DEFAULT '0',
  `sgst_per` double(10,2) NOT NULL DEFAULT '0.00',
  `cgst_per` double(10,2) NOT NULL DEFAULT '0.00',
  `igst_per` double(10,2) NOT NULL DEFAULT '0.00',
  `sgst_amt` double(10,2) NOT NULL DEFAULT '0.00',
  `cgst_amt` double(10,2) NOT NULL DEFAULT '0.00',
  `igst_amt` double(10,2) NOT NULL DEFAULT '0.00',
  `unitrate` double(10,3) DEFAULT '0.000',
  `unitmrp` double(10,3) DEFAULT '0.000',
  `ordered_qty` int DEFAULT '0',
  `received_qty` int DEFAULT '0',
  `pending_qty` int DEFAULT '0',
  `is_fully_received` tinyint DEFAULT '0',
  `is_cancelled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 = this item was cancelled',
  PRIMARY KEY (`id`),
  KEY `prid` (`prid`),
  KEY `prod` (`prods_id`),
  KEY `fullyreceive` (`is_fully_received`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_purchase_details`
--

LOCK TABLES `prod_purchase_details` WRITE;
/*!40000 ALTER TABLE `prod_purchase_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_purchase_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_purchase_edit_log`
--

DROP TABLE IF EXISTS `prod_purchase_edit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_purchase_edit_log` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `purchase_id` int NOT NULL,
  `purchase_detail_id` int NOT NULL,
  `product_id` int NOT NULL,
  `edit_type` enum('price_edit','cancel') NOT NULL,
  `old_rate` double DEFAULT NULL,
  `new_rate` double DEFAULT NULL,
  `old_mrp` double DEFAULT NULL,
  `new_mrp` double DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `reason` text,
  `uid` int NOT NULL,
  `date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_id` (`purchase_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_purchase_edit_log`
--

LOCK TABLES `prod_purchase_edit_log` WRITE;
/*!40000 ALTER TABLE `prod_purchase_edit_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_purchase_edit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_purchase_entry_details_link`
--

DROP TABLE IF EXISTS `prod_purchase_entry_details_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_purchase_entry_details_link` (
  `id` int NOT NULL AUTO_INCREMENT,
  `link_id` int NOT NULL,
  `po_detail_id` bigint unsigned NOT NULL,
  `pe_detail_id` bigint unsigned NOT NULL,
  `quantity_received` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_purchase_entry_details_link`
--

LOCK TABLES `prod_purchase_entry_details_link` WRITE;
/*!40000 ALTER TABLE `prod_purchase_entry_details_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_purchase_entry_details_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_purchase_entry_link`
--

DROP TABLE IF EXISTS `prod_purchase_entry_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_purchase_entry_link` (
  `id` int NOT NULL AUTO_INCREMENT,
  `po_id` bigint unsigned NOT NULL,
  `pe_id` bigint unsigned NOT NULL,
  `receipt_no` varchar(50) DEFAULT NULL,
  `receipt_date` date DEFAULT NULL,
  `received_by` int DEFAULT NULL,
  `notes` text,
  `created_date` date NOT NULL,
  `created_time` time NOT NULL,
  `uid` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_purchase_entry_link`
--

LOCK TABLES `prod_purchase_entry_link` WRITE;
/*!40000 ALTER TABLE `prod_purchase_entry_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_purchase_entry_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_purchase_order_counter`
--

DROP TABLE IF EXISTS `prod_purchase_order_counter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_purchase_order_counter` (
  `id` int NOT NULL DEFAULT '1',
  `last_po_no` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_purchase_order_counter`
--

LOCK TABLES `prod_purchase_order_counter` WRITE;
/*!40000 ALTER TABLE `prod_purchase_order_counter` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_purchase_order_counter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_purchase_request`
--

DROP TABLE IF EXISTS `prod_purchase_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_purchase_request` (
  `id` int NOT NULL AUTO_INCREMENT,
  `req_no` varchar(50) NOT NULL COMMENT 'REQ1, REQ2, REQ3...',
  `req_date` date NOT NULL,
  `req_time` time NOT NULL,
  `deal_id` int DEFAULT NULL COMMENT 'Supplier ID - can be null for TBD supplier',
  `total` decimal(15,2) DEFAULT '0.00' COMMENT 'Total request amount',
  `pr_status` tinyint DEFAULT '1' COMMENT '1=Draft, 2=Submitted, 3=Approved, 4=Rejected, 5=Converted to PO',
  `notes` text COMMENT 'Request notes/justification',
  `requested_by` int NOT NULL COMMENT 'User ID who created the request',
  `approver_id` int DEFAULT NULL COMMENT 'User ID who approved/rejected - for future multi-level approval',
  `approved_date` date DEFAULT NULL COMMENT 'Approval date',
  `approved_time` time DEFAULT NULL COMMENT 'Approval time',
  `approval_notes` text COMMENT 'Approval/rejection notes',
  `po_id` int DEFAULT NULL COMMENT 'Link to PO if converted',
  `is_cancelled` tinyint DEFAULT '0' COMMENT '0=Active, 1=Cancelled',
  `ent_date` date NOT NULL,
  `ent_time` time NOT NULL,
  `ent_uid` int NOT NULL COMMENT 'Entry user ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `req_no` (`req_no`),
  KEY `deal` (`deal_id`),
  KEY `status` (`pr_status`),
  KEY `po` (`po_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Purchase Request Header';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_purchase_request`
--

LOCK TABLES `prod_purchase_request` WRITE;
/*!40000 ALTER TABLE `prod_purchase_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_purchase_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_purchase_request_counter`
--

DROP TABLE IF EXISTS `prod_purchase_request_counter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_purchase_request_counter` (
  `id` int NOT NULL DEFAULT '1',
  `last_req_no` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_purchase_request_counter`
--

LOCK TABLES `prod_purchase_request_counter` WRITE;
/*!40000 ALTER TABLE `prod_purchase_request_counter` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_purchase_request_counter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_purchase_request_details`
--

DROP TABLE IF EXISTS `prod_purchase_request_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_purchase_request_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pr_id` int NOT NULL COMMENT 'Foreign key to prod_purchase_request',
  `prods_id` int NOT NULL COMMENT 'Product ID',
  `pack` int DEFAULT '1' COMMENT 'Number of packs',
  `qtypack` int DEFAULT '1' COMMENT 'Quantity per pack',
  `quantity` int NOT NULL COMMENT 'Total quantity requested',
  `free` int DEFAULT '0' COMMENT 'Free quantity expected',
  `rate` decimal(15,2) DEFAULT '0.00' COMMENT 'Expected cost per unit',
  `mrp` decimal(15,2) DEFAULT '0.00' COMMENT 'Expected MRP',
  `total` decimal(15,2) DEFAULT '0.00' COMMENT 'Line total',
  `tax` decimal(5,2) DEFAULT '0.00' COMMENT 'Tax percentage',
  `tax_amt` decimal(15,2) DEFAULT '0.00' COMMENT 'Tax amount',
  `disc_per` decimal(5,2) DEFAULT '0.00' COMMENT 'Discount percentage',
  `disc_amt` decimal(15,2) DEFAULT '0.00' COMMENT 'Discount amount',
  `net` decimal(15,2) DEFAULT '0.00' COMMENT 'Net amount',
  `notes` text COMMENT 'Item notes',
  PRIMARY KEY (`id`),
  KEY `idx_pr_id` (`pr_id`),
  KEY `idx_prods_id` (`prods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Purchase Request Line Items';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_purchase_request_details`
--

LOCK TABLES `prod_purchase_request_details` WRITE;
/*!40000 ALTER TABLE `prod_purchase_request_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_purchase_request_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_purchase_return`
--

DROP TABLE IF EXISTS `prod_purchase_return`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_purchase_return` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `return_no` varchar(50) DEFAULT NULL,
  `purchase_id` int NOT NULL,
  `supplier_id` int DEFAULT NULL,
  `total` double DEFAULT '0',
  `notes` text,
  `uid` int NOT NULL,
  `date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_id` (`purchase_id`),
  KEY `supplier_id` (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_purchase_return`
--

LOCK TABLES `prod_purchase_return` WRITE;
/*!40000 ALTER TABLE `prod_purchase_return` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_purchase_return` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_purchase_return_details`
--

DROP TABLE IF EXISTS `prod_purchase_return_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_purchase_return_details` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `return_id` int NOT NULL,
  `purchase_detail_id` int NOT NULL,
  `product_id` int NOT NULL,
  `qty` double DEFAULT '0',
  `rate` double DEFAULT '0',
  `total` double DEFAULT '0',
  `uid` int NOT NULL,
  `date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `return_id` (`return_id`),
  KEY `purchase_detail_id` (`purchase_detail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_purchase_return_details`
--

LOCK TABLES `prod_purchase_return_details` WRITE;
/*!40000 ALTER TABLE `prod_purchase_return_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_purchase_return_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_purchase_supplier_payment`
--

DROP TABLE IF EXISTS `prod_purchase_supplier_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_purchase_supplier_payment` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `prid` int NOT NULL,
  `deal_id` int NOT NULL,
  `total` double(10,2) DEFAULT NULL,
  `paid` double(10,2) DEFAULT NULL,
  `balance` double(10,2) DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `prid` (`prid`),
  KEY `deal` (`deal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_purchase_supplier_payment`
--

LOCK TABLES `prod_purchase_supplier_payment` WRITE;
/*!40000 ALTER TABLE `prod_purchase_supplier_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_purchase_supplier_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_purchase_supplier_payment_details`
--

DROP TABLE IF EXISTS `prod_purchase_supplier_payment_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_purchase_supplier_payment_details` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `supPayId` int NOT NULL,
  `payable` double(10,2) DEFAULT NULL,
  `paid` double(10,2) DEFAULT NULL,
  `balance` double(10,2) DEFAULT NULL,
  `pay_type` int DEFAULT NULL,
  `pay_mode` int DEFAULT '0',
  `uid` int DEFAULT NULL,
  `notes` text,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payId` (`supPayId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_purchase_supplier_payment_details`
--

LOCK TABLES `prod_purchase_supplier_payment_details` WRITE;
/*!40000 ALTER TABLE `prod_purchase_supplier_payment_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_purchase_supplier_payment_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_quotation`
--

DROP TABLE IF EXISTS `prod_quotation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_quotation` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `bill_display` varchar(255) NOT NULL,
  `total` double(10,3) DEFAULT '0.000',
  `prodDisc` double(10,3) DEFAULT '0.000',
  `extraDisc` double(10,3) DEFAULT '0.000',
  `payable` double(10,3) DEFAULT '0.000',
  `is_billed` int DEFAULT '0',
  `is_cancelled` int DEFAULT '0',
  `cusName` varchar(255) DEFAULT NULL,
  `cusPhn` varchar(255) DEFAULT NULL,
  `customerId` int DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `uid` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_quotation`
--

LOCK TABLES `prod_quotation` WRITE;
/*!40000 ALTER TABLE `prod_quotation` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_quotation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_quotation_details`
--

DROP TABLE IF EXISTS `prod_quotation_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_quotation_details` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `quot_id` int NOT NULL,
  `prod_id` int NOT NULL,
  `qty` decimal(10,2) NOT NULL,
  `price` double(10,3) NOT NULL,
  `disc` double(10,3) DEFAULT NULL,
  `total` double(10,3) DEFAULT NULL,
  `gst` int DEFAULT NULL,
  `is_cancelled` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_quotation_details`
--

LOCK TABLES `prod_quotation_details` WRITE;
/*!40000 ALTER TABLE `prod_quotation_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_quotation_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_stock_adjustment`
--

DROP TABLE IF EXISTS `prod_stock_adjustment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_stock_adjustment` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `batch_id` int NOT NULL,
  `stockType` int NOT NULL COMMENT '1=add 2=minus',
  `stock` decimal(10,2) NOT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `notes` text,
  `uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `prod` (`product_id`),
  KEY `batch` (`batch_id`),
  KEY `stock` (`stockType`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_stock_adjustment`
--

LOCK TABLES `prod_stock_adjustment` WRITE;
/*!40000 ALTER TABLE `prod_stock_adjustment` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_stock_adjustment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_stock_totals`
--

DROP TABLE IF EXISTS `prod_stock_totals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_stock_totals` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `prods_id` int unsigned NOT NULL DEFAULT '0',
  `stock` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `rack` char(1) NOT NULL DEFAULT '',
  `shelf` int NOT NULL DEFAULT '0',
  `userlog` text,
  `extra1` tinyint unsigned DEFAULT '0',
  `extra2` tinyint unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `store_id_index` (`prods_id`),
  KEY `stock` (`stock`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_stock_totals`
--

LOCK TABLES `prod_stock_totals` WRITE;
/*!40000 ALTER TABLE `prod_stock_totals` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_stock_totals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_supplier`
--

DROP TABLE IF EXISTS `prod_supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_supplier` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `is_active` int DEFAULT '1',
  `gstin` varchar(255) DEFAULT NULL,
  `is_gst` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_supplier`
--

LOCK TABLES `prod_supplier` WRITE;
/*!40000 ALTER TABLE `prod_supplier` DISABLE KEYS */;
INSERT INTO `prod_supplier` VALUES (1,'On call Ramesh','9841876076','Chennai','2026-05-14','13:03:13',1,NULL,0),(2,'Shree Bhairavar Transport','9363040666','Chennai.','2026-06-11','16:23:03',1,NULL,0),(3,'Shree Jayam Transport','8807224599','Chennai.','2026-06-13','11:11:55',1,NULL,0),(4,'Rajalakshmi Transport','9962163483','Chennai.','2026-06-13','11:16:30',1,NULL,0),(5,'Raju Transport','9841098222','Chennai.','2026-06-13','13:37:41',1,NULL,0),(6,'SR Transport','9841496208','Madavarm','2026-06-15','12:09:09',1,NULL,0),(7,'Periyapalayathamman Transport','9500070474','Poonamalle','2026-06-15','12:36:12',1,NULL,0),(8,'SREE MANJUNATHA TRANSPORT','9840561132','Chennai','2026-06-15','13:15:14',1,NULL,0),(9,'Mathi transport','9884129002','Madavarm','2026-06-15','13:41:25',1,NULL,0),(10,'Sri Murugan Lorry Service','7200060103','Chennai','2026-06-24','19:18:39',1,NULL,0),(11,'Sri Murugan Roadlines','9444505152','Chennai','2026-06-24','19:19:03',1,NULL,0),(12,'Annai Meenakshi Transport','9841627049','Chennai','2026-06-24','19:19:31',1,NULL,0),(13,'Annai Mahalakshmi Transport','9840969642','Chennai','2026-06-24','19:20:10',1,NULL,0),(14,'Sri Mahalakshmi Lorry Suppliers','9043631110','Chennai','2026-06-24','19:20:45',1,NULL,0),(15,'Popular Goods Transport','7200004605','Chennai','2026-06-24','19:21:23',1,NULL,0),(16,'National Mini Transport','9791105988','Chennai','2026-06-24','19:22:17',1,NULL,0),(17,'Hercules Transport','9884319093','Chennai','2026-06-24','19:22:57',1,NULL,0),(18,'Mohan Roadways','9840085870','Chennai','2026-06-24','19:23:19',1,NULL,0),(19,'Chandran Road Carrier','9176018416','Chennai','2026-06-24','19:24:18',1,NULL,0),(20,'Friends Roadlines','9383882006','Chennai','2026-06-24','19:27:12',1,NULL,0),(21,'GVS Transport','9940237190','Chennai','2026-06-24','19:31:43',1,NULL,0),(22,'Ayyanar Transport','7010662027','Pondy','2026-06-24','20:08:47',1,NULL,0),(23,'Madavaram 20 feet','','Chennai','2026-06-25','19:18:01',1,NULL,0),(24,'Sai Dhinesh Roadways','9543975757','Chennai','2026-06-25','21:16:06',1,NULL,0),(25,'Ranjani Transport','9677194515','Chennai','2026-06-25','21:17:15',1,NULL,0),(26,'RR Roadways','9940417944','Chennai','2026-06-26','19:19:34',1,NULL,0),(27,'Santhi Narayan Road Transport','9940116614','Chennai','2026-06-26','19:40:13',1,NULL,0),(28,'Maruthy Transport','7868021671','Pondy','2026-06-26','20:08:07',1,NULL,0),(29,'New Super Roadways','9626434301','Chennai','2026-06-29','19:57:41',1,NULL,0),(30,'Annai Velankanni Roadways','9786211799','Chennai','2026-06-29','20:00:30',1,NULL,0),(31,'SSK Transport-Pondy','7010662027','Pondy','2026-06-29','20:02:33',1,NULL,0),(32,'Jeelani Roadways','','Chennai','2026-07-02','12:06:30',1,NULL,0),(33,'Santhakumar','','Pondy','2026-07-04','21:50:32',1,NULL,0),(34,'Vetri Vinayaga Transport','9841487615','Chennai','2026-07-18','18:58:38',1,NULL,0);
/*!40000 ALTER TABLE `prod_supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_supplier_cheque_allocation`
--

DROP TABLE IF EXISTS `prod_supplier_cheque_allocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_supplier_cheque_allocation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cheque_id` int NOT NULL,
  `purchase_id` int NOT NULL,
  `allocated_amount` decimal(10,2) NOT NULL,
  `allocated_date` date NOT NULL,
  `allocated_time` time NOT NULL,
  `allocated_uid` int NOT NULL,
  `due_date` date DEFAULT NULL,
  `credit_days` int DEFAULT '10',
  `status` varchar(20) NOT NULL DEFAULT 'ALLOCATED',
  `cleared_date` date DEFAULT NULL,
  `cleared_time` time DEFAULT NULL,
  `cleared_uid` int DEFAULT NULL,
  `is_reversed` tinyint(1) DEFAULT '0',
  `reversed_date` date DEFAULT NULL,
  `reversed_time` time DEFAULT NULL,
  `reversed_uid` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_cheque` (`cheque_id`),
  KEY `idx_purchase` (`purchase_id`),
  KEY `idx_status` (`status`),
  KEY `idx_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_supplier_cheque_allocation`
--

LOCK TABLES `prod_supplier_cheque_allocation` WRITE;
/*!40000 ALTER TABLE `prod_supplier_cheque_allocation` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_supplier_cheque_allocation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_supplier_cheque_events`
--

DROP TABLE IF EXISTS `prod_supplier_cheque_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_supplier_cheque_events` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cheque_id` int NOT NULL,
  `event_type` varchar(20) NOT NULL,
  `event_date` date NOT NULL,
  `event_time` time NOT NULL,
  `event_uid` int NOT NULL,
  `reason` text,
  PRIMARY KEY (`id`),
  KEY `idx_cheque` (`cheque_id`),
  KEY `idx_event_type` (`event_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_supplier_cheque_events`
--

LOCK TABLES `prod_supplier_cheque_events` WRITE;
/*!40000 ALTER TABLE `prod_supplier_cheque_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_supplier_cheque_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_supplier_cheque_stock`
--

DROP TABLE IF EXISTS `prod_supplier_cheque_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_supplier_cheque_stock` (
  `id` int NOT NULL AUTO_INCREMENT,
  `supplier_id` int NOT NULL,
  `cheque_number` varchar(255) NOT NULL,
  `bank_name` text,
  `entry_date` date NOT NULL,
  `entry_time` time NOT NULL,
  `entry_uid` int NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'AVAILABLE',
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_supplier` (`supplier_id`),
  KEY `idx_status` (`status`),
  KEY `idx_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_supplier_cheque_stock`
--

LOCK TABLES `prod_supplier_cheque_stock` WRITE;
/*!40000 ALTER TABLE `prod_supplier_cheque_stock` DISABLE KEYS */;
/*!40000 ALTER TABLE `prod_supplier_cheque_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_units`
--

DROP TABLE IF EXISTS `prod_units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_units` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `convertion_unit` varchar(255) DEFAULT NULL,
  `convertion_calculation` decimal(10,2) DEFAULT NULL,
  `is_active` int DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_units`
--

LOCK TABLES `prod_units` WRITE;
/*!40000 ALTER TABLE `prod_units` DISABLE KEYS */;
INSERT INTO `prod_units` VALUES (1,'NOS',NULL,NULL,1),(2,'Gram',NULL,NULL,1),(3,'KG',NULL,NULL,1),(4,'Meter',NULL,NULL,1),(5,'length','Feet',20.00,1);
/*!40000 ALTER TABLE `prod_units` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_area`
--

DROP TABLE IF EXISTS `sales_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_area` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_active` int DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_area`
--

LOCK TABLES `sales_area` WRITE;
/*!40000 ALTER TABLE `sales_area` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_man`
--

DROP TABLE IF EXISTS `sales_man`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_man` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_active` int DEFAULT '1',
  `created_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_man`
--

LOCK TABLES `sales_man` WRITE;
/*!40000 ALTER TABLE `sales_man` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_man` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `special_permission`
--

DROP TABLE IF EXISTS `special_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `special_permission` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `content` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `special_permission`
--

LOCK TABLES `special_permission` WRITE;
/*!40000 ALTER TABLE `special_permission` DISABLE KEYS */;
INSERT INTO `special_permission` VALUES (1,'allow to Zero stock billing ');
/*!40000 ALTER TABLE `special_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transport_bill`
--

DROP TABLE IF EXISTS `transport_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transport_bill` (
  `id` int NOT NULL AUTO_INCREMENT,
  `invoice_no` varchar(20) NOT NULL,
  `bill_date` date NOT NULL,
  `customer_id` int NOT NULL,
  `po_no` varchar(100) DEFAULT NULL,
  `sac_code` varchar(50) DEFAULT NULL,
  `grand_total` double NOT NULL DEFAULT '0',
  `paid_amount` double NOT NULL DEFAULT '0',
  `balance` double NOT NULL DEFAULT '0',
  `payment_mode` varchar(50) NOT NULL DEFAULT 'Credit',
  `payment_type` tinyint DEFAULT '1' COMMENT '''1=Cash 2=Bank 3=Mixed''',
  `credit_days` varchar(255) DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `is_cancelled` tinyint(1) NOT NULL DEFAULT '0',
  `cancel_uid` int DEFAULT NULL,
  `cancel_date_time` datetime DEFAULT NULL,
  `entry_user` int NOT NULL,
  `entry_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_tb_customer` (`customer_id`),
  KEY `idx_tb_date` (`bill_date`),
  KEY `idx_tb_invoice` (`invoice_no`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transport_bill`
--

LOCK TABLES `transport_bill` WRITE;
/*!40000 ALTER TABLE `transport_bill` DISABLE KEYS */;
INSERT INTO `transport_bill` VALUES (1,'123-2026/27','2026-06-23',6,'2604-00373','996791',6000,0,6000,'Cash',1,'30 Days',NULL,0,NULL,NULL,25,'2026-06-23 19:28:50'),(2,'124-2026/27','2026-06-25',12,NULL,'996791',3500,0,3500,'Cash',1,'Immediate',NULL,0,NULL,NULL,25,'2026-06-25 19:23:09'),(3,'125-2026/27','2026-06-30',14,NULL,'996791',9000,0,9000,'Bank/UPI',2,'15 Days Only.',NULL,0,NULL,NULL,25,'2026-07-02 11:06:42'),(4,'126-2026/27','2026-06-30',6,'2606-02687','996791',6000,0,6000,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-07-02 12:16:46'),(5,'127-2026/27','2026-07-02',9,NULL,'996791',98000,0,98000,'Bank/UPI',2,'Immediate',NULL,1,25,'2026-07-02 12:27:10',25,'2026-07-02 12:26:06'),(6,'128-2026/27','2026-07-02',9,NULL,'996791',98000,0,98000,'Cash',1,'Immediate',NULL,0,NULL,NULL,25,'2026-07-02 12:29:44'),(7,'129-2026/27','2026-07-03',13,NULL,'996791',85000,0,85000,'Bank/UPI',2,'30  Days Only',NULL,0,NULL,NULL,25,'2026-07-03 15:44:50'),(8,'130-2026/27','2026-07-03',7,NULL,'996791',80000,0,80000,'Bank/UPI',2,'15 Days Only.',NULL,0,NULL,NULL,25,'2026-07-03 15:48:03'),(9,'131-2026/27','2026-07-05',5,NULL,'996791',37850,0,37850,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-05 14:17:27'),(10,'132-2026/27','2026-07-05',5,NULL,'996791',31100,0,31100,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-05 14:17:52'),(11,'133-2026/27','2026-07-05',5,NULL,'996791',12820,0,12820,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-05 14:18:34'),(12,'134-2026/27','2026-07-05',5,NULL,'996791',25100,0,25100,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-05 14:18:59'),(13,'135-2026/27','2026-07-05',5,NULL,'996791',35100,0,35100,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-05 14:19:20'),(14,'136-2026/27','2026-07-05',5,NULL,'996791',16208,0,16208,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-05 14:19:50'),(15,'137-2026/27','2026-07-05',5,NULL,'996791',20809,0,20809,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-05 14:20:13'),(16,'138-2026/27','2026-07-05',5,NULL,'996791',6100,0,6100,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-05 14:21:13'),(17,'139-2026/27','2026-07-05',5,NULL,'996791',14358,0,14358,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-05 14:21:41'),(18,'140-2026/27','2026-07-05',5,NULL,'996791',1000,0,1000,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-05 14:24:27'),(19,'141-2026/27','2026-07-05',5,NULL,'996791',1000,0,1000,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-05 14:24:44'),(20,'142-2026/27','2026-07-10',12,NULL,'996791',8000,0,8000,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-07-10 19:04:52'),(21,'143-2026/27','2026-07-10',4,NULL,'996791',258198,0,258198,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-07-10 19:41:29'),(22,'144-2026/27','2026-07-10',4,NULL,'996791',17550,0,17550,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-07-10 19:56:45'),(23,'145-2026/27','2026-07-10',4,NULL,'996791',12550,0,12550,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-07-10 20:09:19'),(24,'146-2026/27','2026-07-12',4,'TN DEPO','996791',94915,0,94915,'Bank/UPI',2,'30  Days',NULL,0,NULL,NULL,25,'2026-07-12 19:08:36'),(25,'147-2026/27','2026-07-16',4,'FG STORES','996791',16600,0,16600,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-07-16 12:15:16'),(26,'148-2026/27','2026-07-18',17,NULL,'996791',21600,0,21600,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-07-18 19:05:03'),(27,'149-2026/27','2026-07-18',17,NULL,'996791',34100,0,34100,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-07-18 19:07:43');
/*!40000 ALTER TABLE `transport_bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transport_bill_balance`
--

DROP TABLE IF EXISTS `transport_bill_balance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transport_bill_balance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `balance_amount` double NOT NULL DEFAULT '0',
  `due_date` date NOT NULL,
  `collected_amount` double NOT NULL DEFAULT '0',
  `collected_date` date DEFAULT NULL,
  `collected_mode` varchar(50) DEFAULT NULL,
  `is_collected` tinyint(1) NOT NULL DEFAULT '0',
  `notes` text,
  `entry_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_tbb_bill` (`bill_id`),
  KEY `idx_tbb_due` (`due_date`),
  KEY `idx_tbb_collected` (`is_collected`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transport_bill_balance`
--

LOCK TABLES `transport_bill_balance` WRITE;
/*!40000 ALTER TABLE `transport_bill_balance` DISABLE KEYS */;
/*!40000 ALTER TABLE `transport_bill_balance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transport_bill_details`
--

DROP TABLE IF EXISTS `transport_bill_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transport_bill_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `bill_lr_id` int NOT NULL,
  `logistics_id` int NOT NULL,
  `lr_no` varchar(100) DEFAULT NULL,
  `lr_date` date DEFAULT NULL,
  `particular` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `qty` varchar(50) DEFAULT NULL,
  `rate_wt` varchar(100) DEFAULT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `sort_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_tbd_bill` (`bill_id`),
  KEY `idx_tbd_bill_lr` (`bill_lr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=274 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transport_bill_details`
--

LOCK TABLES `transport_bill_details` WRITE;
/*!40000 ALTER TABLE `transport_bill_details` DISABLE KEYS */;
INSERT INTO `transport_bill_details` VALUES (22,1,1,1,'         -',NULL,'Used Household Goods','As per ','F T L',6000,1),(23,1,1,1,NULL,NULL,'','','',0,2),(24,1,1,1,NULL,NULL,'Chennai local ','','',0,3),(25,1,1,1,NULL,NULL,'','','',0,4),(26,1,1,1,NULL,NULL,'20 feet closed Container','','',0,5),(27,1,1,1,NULL,NULL,'','','',0,6),(28,1,1,1,NULL,NULL,'A/c.JOSHUA CANNON','','',0,7),(29,2,2,19,'            -','2026-06-25','Aqua Products','05','F T L',3500,1),(30,2,2,19,NULL,NULL,'','','',0,2),(31,2,2,19,NULL,NULL,'Tondiarpet to Gummidipoondi','','',0,3),(32,2,2,19,NULL,NULL,'','','',0,4),(33,2,2,19,NULL,NULL,'Container No. TN03AE5173','','',0,5),(34,3,3,52,'          -','2026-07-29','Used Household Goods','09','F T L',9000,1),(35,3,3,52,NULL,NULL,'','','',0,2),(36,3,3,52,NULL,NULL,'Chennai to Bangalore','','',0,3),(37,3,3,52,NULL,NULL,'','','',0,4),(38,3,3,52,NULL,NULL,'Container No. TN73AH7796','','',0,5),(39,3,3,52,NULL,NULL,'','','',0,6),(40,3,3,52,NULL,NULL,'A/c.Mr.Devaraj Pannerselvam','','',0,7),(41,4,4,57,'           -','2026-06-30','Used Household Goods','Asper List','F T L',6000,1),(42,4,4,57,NULL,NULL,'','','',0,2),(43,4,4,57,NULL,NULL,'Chennai local Transportation','','',0,3),(44,4,4,57,NULL,NULL,'','','',0,4),(45,4,4,57,NULL,NULL,'20 feet Closed Container','','',0,5),(46,4,4,57,NULL,NULL,'','','',0,6),(47,4,4,57,NULL,NULL,'A/c. Divya Sharma','','',0,7),(48,5,5,47,'         0270','2026-06-26','MRI SYSTEM','09','F T L',90000,1),(49,5,5,47,NULL,NULL,'','','',0,2),(50,5,5,47,NULL,NULL,'Two days Halting charges at Chennai','','',8000,3),(51,5,5,47,NULL,NULL,'','','',0,4),(52,5,5,47,NULL,NULL,'Vizag to Chennai','','',0,5),(53,5,5,47,NULL,NULL,'','','',0,6),(54,5,5,47,NULL,NULL,'40 Feet Open Trailer','','',0,7),(55,5,5,47,NULL,NULL,'','','',0,8),(56,5,5,47,NULL,NULL,'Vehicle No. : AP39TQ3369','','',0,9),(57,6,6,47,'       0270','2026-06-26','MRI SYSTEM','09','F T L',90000,1),(58,6,6,47,NULL,NULL,'','','',0,2),(59,6,6,47,NULL,NULL,'Two Days Halting Charges at Chennai','','',8000,3),(60,6,6,47,NULL,NULL,'','','',0,4),(61,6,6,47,NULL,NULL,'Vizag to Chennai','','',0,5),(62,6,6,47,NULL,NULL,'','','',0,6),(63,6,6,47,NULL,NULL,'40 Feet Open Trailer','','',0,7),(64,6,6,47,NULL,NULL,'','','',0,8),(65,6,6,47,NULL,NULL,'Vehicle No. AP39TQ3369','','',0,9),(66,7,7,56,'326','2026-06-30','MRI COMPONENTS','03','F T L',85000,1),(67,7,7,56,NULL,NULL,'','','',0,2),(68,7,7,56,NULL,NULL,'Chennai to Vizag','','',0,3),(69,7,7,56,NULL,NULL,'','','',0,4),(70,7,7,56,NULL,NULL,'40 Feet Open Trailer','','',0,5),(71,7,7,56,NULL,NULL,'','','',0,6),(72,7,7,56,NULL,NULL,'Vehicle No. : AP39WC8499','','',0,7),(73,8,8,58,'327','2026-07-01','MRI BODY COVER','04','F T L',80000,1),(74,8,8,58,NULL,NULL,'','','',0,2),(75,8,8,58,NULL,NULL,'Chennai to Vizag','','',0,3),(76,8,8,58,NULL,NULL,'','','',0,4),(77,8,8,58,NULL,NULL,'40 Feet Open Trailer','','',0,5),(78,8,8,58,NULL,NULL,'','','',0,6),(79,8,8,58,NULL,NULL,'Vehicle No. : KA01AQ5679','','',0,7),(80,9,9,38,NULL,NULL,'FREIGHT CHARGES RECEIVED','','',37850,1),(81,10,10,39,NULL,NULL,'FREIGHT CHARGES RECEIVED','','',31100,1),(82,11,11,40,NULL,NULL,'FREIGHT CHARGES RECEIVED','','',12820,1),(83,12,12,43,NULL,NULL,'FREIGHT CHARGES RECEIVED','','',25100,1),(84,13,13,44,NULL,NULL,'FREIGHT CHARGES RECEIVED','','',35100,1),(85,14,14,46,NULL,NULL,'FREIGHT CHARGES RECEIVED','','',16208,1),(86,15,15,45,NULL,NULL,'FREIGHT CHARGES RECEIVED','','',20809,1),(87,16,16,49,NULL,NULL,'FREIGHT CHARGES RECEIVED','','',6100,1),(88,17,17,50,NULL,NULL,'FREIGHT CHARGES RECEIVED','','',14358,1),(89,18,18,64,NULL,NULL,'RETURN CHARGES','','',1000,1),(90,19,19,65,NULL,NULL,'RETURN CHARGES','','',1000,1),(91,20,20,69,'-','2026-07-09','Aqua Products','15','F T L',8000,1),(92,20,20,69,NULL,NULL,'','','',0,2),(93,20,20,69,NULL,NULL,'Tondiarpet to Gummidipoondi','','',0,3),(94,20,20,69,NULL,NULL,'','','',0,4),(95,20,20,69,NULL,NULL,'17 Feet closed container','','',0,5),(96,20,20,69,NULL,NULL,'','','',0,6),(97,20,20,69,NULL,NULL,'Container No. : TN18AB2214','','',0,7),(98,21,21,16,'0255','2026-06-10','H L MEDICINES & AQUA PRODUCTS','1011','F T L',77400,1),(99,21,21,16,NULL,NULL,'','','',0,2),(100,21,21,16,NULL,NULL,'L R charges','','',50,3),(101,21,21,16,NULL,NULL,'','','',0,4),(102,21,21,16,NULL,NULL,'Unloading charges at Kolkata','','',4550,5),(103,21,21,16,NULL,NULL,'(Unloading slip enclosed)','','',0,6),(104,21,21,16,NULL,NULL,'','','',0,7),(105,21,21,16,NULL,NULL,'Chennai to Kolkata','','',0,8),(106,21,21,16,NULL,NULL,'','','',0,9),(107,21,21,16,NULL,NULL,'20 feet container No. : TN18BH3638','','',0,10),(108,21,21,16,NULL,NULL,'Note: Loading charges Rs.2450 paid by us.','','',0,11),(109,21,22,25,'0256','2026-06-11','H L MEDICINES','1022','F T L',79500,1),(110,21,22,25,NULL,NULL,'','','',0,2),(111,21,22,25,NULL,NULL,'L R charges','','',50,3),(112,21,22,25,NULL,NULL,'','','',0,4),(113,21,22,25,NULL,NULL,'Unloading charges at Kolkata','','',4600,5),(114,21,22,25,NULL,NULL,'(Unloading slip enclosed)','','',0,6),(115,21,22,25,NULL,NULL,'','','',0,7),(116,21,22,25,NULL,NULL,'Chennai to Kolkata','','',0,8),(117,21,22,25,NULL,NULL,'','','',0,9),(118,21,22,25,NULL,NULL,'24 Feet Container No. : TN12BS0813','','',0,10),(119,21,22,25,NULL,NULL,'Note: Loading charges Rs.3025 paid by us.','','',0,11),(120,21,23,35,'0263','2026-06-16','H L MEDICINES','610','F T L',26400,1),(121,21,23,35,NULL,NULL,'','','',0,2),(122,21,23,35,NULL,NULL,'L R charges','','',50,3),(123,21,23,35,NULL,NULL,'','','',0,4),(124,21,23,35,NULL,NULL,'Unloading charges at Vijayawada','','',610,5),(125,21,23,35,NULL,NULL,'(Unloading slip enclosed)','','',0,6),(126,21,23,35,NULL,NULL,'','','',0,7),(127,21,23,35,NULL,NULL,'Chennai to Vijayawada','','',0,8),(128,21,23,35,NULL,NULL,'','','',0,9),(129,21,23,35,NULL,NULL,'20 feet container No. : TN12U1036','','',0,10),(130,21,23,35,NULL,NULL,'Note: Loading charges Rs.1950 paid by us.','','',0,11),(131,21,24,37,'0264','2026-06-17','H L MEDICINES','633','F T L',16600,1),(132,21,24,37,NULL,NULL,'','','',0,2),(133,21,24,37,NULL,NULL,'L R Charges','','',50,3),(134,21,24,37,NULL,NULL,'','','',0,4),(135,21,24,37,NULL,NULL,'Unloading charges at Bangalore','','',4431,5),(136,21,24,37,NULL,NULL,'(Written in our LR copy backside)','','',0,6),(137,21,24,37,NULL,NULL,'','','',0,7),(138,21,24,37,NULL,NULL,'Chennai to Bangalore','','',0,8),(139,21,24,37,NULL,NULL,'','','',0,9),(140,21,24,37,NULL,NULL,'17 Feet Container No. : KA03AJ7757','','',0,10),(141,21,24,37,NULL,NULL,'Note: Loading charges Rs.1640 paid by us.','','',0,11),(142,21,25,48,'0271','2026-06-27','H L MEDICINES','341','F T L',15300,1),(143,21,25,48,NULL,NULL,'','','',0,2),(144,21,25,48,NULL,NULL,'L R Charges','','',50,3),(145,21,25,48,NULL,NULL,'','','',0,4),(146,21,25,48,NULL,NULL,'Unloading charges at Bangalore','','',2397,5),(147,21,25,48,NULL,NULL,'(Written in our LR copy backside)','','',0,6),(148,21,25,48,NULL,NULL,'','','',0,7),(149,21,25,48,NULL,NULL,'Chennai to Bangalore','','',0,8),(150,21,25,48,NULL,NULL,'','','',0,9),(151,21,25,48,NULL,NULL,'14 Feet Container No. : KA02AL0907','','',0,10),(152,21,25,48,NULL,NULL,'Note: Loading charges Rs.820 paid by us.','','',0,11),(153,21,26,51,'0272','2026-06-29','H L MEDICINES & AQUA PRODUCTS','507','F T L',25600,1),(154,21,26,51,NULL,NULL,'','','',0,2),(155,21,26,51,NULL,NULL,'L R Charges','','',50,3),(156,21,26,51,NULL,NULL,'','','',0,4),(157,21,26,51,NULL,NULL,'Unloading charges at Vijayawada','','',510,5),(158,21,26,51,NULL,NULL,'(Unloading slip enclosed)','','',0,6),(159,21,26,51,NULL,NULL,'','','',0,7),(160,21,26,51,NULL,NULL,'Chennai to Vijayawada','','',0,8),(161,21,26,51,NULL,NULL,'','','',0,9),(162,21,26,51,NULL,NULL,'20 Feet container No. : TN18BH3623','','',0,10),(163,21,26,51,NULL,NULL,'Note: Loading charges Rs.1620 paid by us.','','',0,11),(164,22,27,20,'0269','2026-06-25','MEDICINES','939','F T L',13000,1),(165,22,27,20,NULL,NULL,'','','',0,2),(166,22,27,20,NULL,NULL,'L R Charges','','',50,3),(167,22,27,20,NULL,NULL,'','','',0,4),(168,22,27,20,NULL,NULL,'Tondiarpet to Ennore','','',0,5),(169,22,27,20,NULL,NULL,'','','',0,6),(170,22,27,20,NULL,NULL,'20 Feet Container 2 Vehicles used','','',0,7),(171,22,27,20,NULL,NULL,'Container No. : TN12AU1549','','',0,8),(172,22,27,20,NULL,NULL,'Container No. : TN12AU1570','','',0,9),(173,22,28,36,'-','2026-06-17','AQUA PRODUCTS','152','F T L',4500,1),(174,22,28,36,NULL,NULL,'','','',0,2),(175,22,28,36,NULL,NULL,'Tondiarpet to Triway CFS','','',0,3),(176,22,28,36,NULL,NULL,'','','',0,4),(177,22,28,36,NULL,NULL,'17 Feet container No. : TN10J3677','','',0,5),(178,23,29,11,'-','2026-06-08','MEDICINES','03','F T L',2500,1),(179,23,29,11,NULL,NULL,'','','',0,2),(180,23,29,11,NULL,NULL,'Thirurani CFS Madavaram to Tondiarpet','','',0,3),(181,23,29,11,NULL,NULL,'','','',0,4),(182,23,29,11,NULL,NULL,'Vehicle No. : TN02BX7239','','',0,5),(183,23,30,30,'0262','2026-06-13','H L MEDICINES','20','F T L',6000,1),(184,23,30,30,NULL,NULL,'','','',0,2),(185,23,30,30,NULL,NULL,'L R Charges','','',50,3),(186,23,30,30,NULL,NULL,'','','',0,4),(187,23,30,30,NULL,NULL,'Chennai Airport to Pondy','','',0,5),(188,23,30,30,NULL,NULL,'','','',0,6),(189,23,30,30,NULL,NULL,'Dost Container No. : TN51AU8620','','',0,7),(190,23,31,70,'-','2026-07-10','OFFICE ITEMS','02','F T L',4000,1),(191,23,31,70,NULL,NULL,'','','',0,2),(192,23,31,70,NULL,NULL,'Ennore(EECT) TO Adyar','','',0,3),(193,23,31,70,NULL,NULL,'','','',0,4),(194,23,31,70,NULL,NULL,'Bada Dost Container No. TN13AH1735','','',0,5),(195,24,32,14,'0254','2026-06-09','H L MEDICINES','300','F T L',12750,1),(196,24,32,14,NULL,NULL,'','','',0,2),(197,24,32,14,NULL,NULL,'L R Charges','','',50,3),(198,24,32,14,NULL,NULL,'','','',0,4),(199,24,32,14,NULL,NULL,'Unloading charges at Bangalore','','',3000,5),(200,24,32,14,NULL,NULL,'(Written in our LR copy)','','',0,6),(201,24,32,14,NULL,NULL,'','','',0,7),(202,24,32,14,NULL,NULL,'Chennai to Bangalore','','',0,8),(203,24,32,14,NULL,NULL,'','','',0,9),(204,24,32,14,NULL,NULL,'Container No. : TN73BY5098','','',0,10),(205,24,33,42,'0268','2026-06-20','H L MEDICINES','161','F T L',26300,1),(206,24,33,42,NULL,NULL,'','','',0,2),(207,24,33,42,NULL,NULL,'L R Charges','','',50,3),(208,24,33,42,NULL,NULL,'','','',0,4),(209,24,33,42,NULL,NULL,'Unloading charges at Kalaburagi','','',2415,5),(210,24,33,42,NULL,NULL,'(Written in our LR copy)','','',0,6),(211,24,33,42,NULL,NULL,'','','',0,7),(212,24,33,42,NULL,NULL,'Chennai to Kalaburagi','','',0,8),(213,24,33,42,NULL,NULL,'','','',0,9),(214,24,33,42,NULL,NULL,'Vehicle No. : MH13DQ6840','','',0,10),(215,24,34,53,'0273','2026-06-30','AQUA PRODUCTS','34','F T L',11000,1),(216,24,34,53,NULL,NULL,'','','',0,2),(217,24,34,53,NULL,NULL,'L R Charges','','',50,3),(218,24,34,53,NULL,NULL,'','','',0,4),(219,24,34,53,NULL,NULL,'Unloading charges at Nagapatinam','','',200,5),(220,24,34,53,NULL,NULL,'(Written in our LR copy)','','',0,6),(221,24,34,53,NULL,NULL,'','','',0,7),(222,24,34,53,NULL,NULL,'Chennai to Nagapatinam','','',0,8),(223,24,34,53,NULL,NULL,'','','',0,9),(224,24,34,53,NULL,NULL,'Vehicle No. : TN49CR2089','','',0,10),(225,24,35,54,'0274','2026-06-30','AQUA PRODUCTS','379','F T L',21250,1),(226,24,35,54,NULL,NULL,'','','',0,2),(227,24,35,54,NULL,NULL,'L R Charges','','',50,3),(228,24,35,54,NULL,NULL,'','','',0,4),(229,24,35,54,NULL,NULL,'Chennai to Repalle','','',0,5),(230,24,35,54,NULL,NULL,'','','',0,6),(231,24,35,54,NULL,NULL,'Vehicle No. : AP39UW7643','','',0,7),(232,24,36,55,'0275','2026-06-30','AQUA PRODUCTS','162','F T L',17750,1),(233,24,36,55,NULL,NULL,'','','',0,2),(234,24,36,55,NULL,NULL,'L R Charges','','',50,3),(235,24,36,55,NULL,NULL,'','','',0,4),(236,24,36,55,NULL,NULL,'Chennai to Koduru','','',0,5),(237,24,36,55,NULL,NULL,'','','',0,6),(238,24,36,55,NULL,NULL,'Vehicle No. : AP39UX9391','','',0,7),(239,24,36,55,NULL,NULL,'(Note: Loading charges Rs.792 paid by us.)','','',0,8),(240,24,36,55,NULL,NULL,'','','',0,9),(241,24,36,55,NULL,NULL,'TOTAL LR\'s = 06 No\'s Only.','','',0,10),(242,25,37,41,'0267','2026-06-19','MEDICINES','534','F T L',10500,1),(243,25,37,41,NULL,NULL,'','','',0,2),(244,25,37,41,NULL,NULL,'L R Charges','','',50,3),(245,25,37,41,NULL,NULL,'','','',0,4),(246,25,37,41,NULL,NULL,'Tondiarpet to Oragadam','','',0,5),(247,25,37,41,NULL,NULL,'','','',0,6),(248,25,37,41,NULL,NULL,'20 Feet container No. : TN12AM2845','','',0,7),(249,25,37,41,NULL,NULL,'Note: Loading charges Rs.500 paid by us.','','',0,8),(250,25,38,62,'328','2026-07-03','MEDICINES','90','F T L',6000,1),(251,25,38,62,NULL,NULL,'','','',0,2),(252,25,38,62,NULL,NULL,'L R Charges','','',50,3),(253,25,38,62,NULL,NULL,'','','',0,4),(254,25,38,62,NULL,NULL,'Tondiarpet to Oragadam','','',0,5),(255,25,38,62,NULL,NULL,'','','',0,6),(256,25,38,62,NULL,NULL,'Dost Container No. : TN02CH2469','','',0,7),(257,25,38,62,NULL,NULL,'','','',0,8),(258,25,38,62,NULL,NULL,'TOTAL LR\'s = 02 No\'s ONLY.','','',0,9),(259,26,39,73,'354','2026-07-15','FRP TANK & TOP MOUNT FRONT FACING FILTER','143','F T L',21500,1),(260,26,39,73,NULL,NULL,'','','',0,2),(261,26,39,73,NULL,NULL,'L R Charges','','',100,3),(262,26,39,73,NULL,NULL,'','','',0,4),(263,26,39,73,NULL,NULL,'Chennai to Coimbatore','','',0,5),(264,26,39,73,NULL,NULL,'','','',0,6),(265,26,39,73,NULL,NULL,'20 Feet Container No. : TN38DP3913','','',0,7),(266,27,40,76,'355','2026-07-16','ROMH','02','F T L',34000,1),(267,27,40,76,NULL,NULL,'(02 WOODEN BOXES)','','',0,2),(268,27,40,76,NULL,NULL,'','','',0,3),(269,27,40,76,NULL,NULL,'L R Charges','','',100,4),(270,27,40,76,NULL,NULL,'','','',0,5),(271,27,40,76,NULL,NULL,'Chennai to Goa','','',0,6),(272,27,40,76,NULL,NULL,'','','',0,7),(273,27,40,76,NULL,NULL,'20 Feet Open Truck No.KA28AB7992','','',0,8);
/*!40000 ALTER TABLE `transport_bill_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transport_bill_lr`
--

DROP TABLE IF EXISTS `transport_bill_lr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transport_bill_lr` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `logistics_id` int NOT NULL,
  `lr_total` double NOT NULL DEFAULT '0',
  `notes` text,
  PRIMARY KEY (`id`),
  KEY `idx_tblr_bill` (`bill_id`),
  KEY `idx_tblr_lr` (`logistics_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transport_bill_lr`
--

LOCK TABLES `transport_bill_lr` WRITE;
/*!40000 ALTER TABLE `transport_bill_lr` DISABLE KEYS */;
INSERT INTO `transport_bill_lr` VALUES (1,1,1,6000,NULL),(2,2,19,3500,NULL),(3,3,52,9000,NULL),(4,4,57,6000,NULL),(5,5,47,98000,NULL),(6,6,47,98000,NULL),(7,7,56,85000,NULL),(8,8,58,80000,NULL),(9,9,38,37850,NULL),(10,10,39,31100,NULL),(11,11,40,12820,NULL),(12,12,43,25100,NULL),(13,13,44,35100,NULL),(14,14,46,16208,NULL),(15,15,45,20809,NULL),(16,16,49,6100,NULL),(17,17,50,14358,NULL),(18,18,64,1000,NULL),(19,19,65,1000,NULL),(20,20,69,8000,NULL),(21,21,16,82000,NULL),(22,21,25,84150,NULL),(23,21,35,27060,NULL),(24,21,37,21081,NULL),(25,21,48,17747,NULL),(26,21,51,26160,'TOTAL LR\'s = 06 No\'s ONLY.'),(27,22,20,13050,NULL),(28,22,36,4500,NULL),(29,23,11,2500,NULL),(30,23,30,6050,NULL),(31,23,70,4000,NULL),(32,24,14,15800,'(Note: loading charges Rs.800/- paid by us.)'),(33,24,42,28765,'(Note: loading charges Rs.322/- paid by us.)'),(34,24,53,11250,NULL),(35,24,54,21300,'(Note: Loading charges Rs.1760 paid by us.)'),(36,24,55,17800,NULL),(37,25,41,10550,NULL),(38,25,62,6050,NULL),(39,26,73,21600,NULL),(40,27,76,34100,NULL);
/*!40000 ALTER TABLE `transport_bill_lr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transport_bill_order`
--

DROP TABLE IF EXISTS `transport_bill_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transport_bill_order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `supplier_id` int NOT NULL,
  `vehicle_no` varchar(50) DEFAULT NULL,
  `driver_phone` varchar(20) DEFAULT NULL,
  `lr_date` date NOT NULL,
  `lr_no` text,
  `customer_id` int NOT NULL,
  `destination` varchar(255) NOT NULL,
  `dpf` double NOT NULL DEFAULT '0',
  `dpf_freight` double NOT NULL DEFAULT '0',
  `dpf_lr_charge` double NOT NULL DEFAULT '0',
  `dpf_load` double NOT NULL DEFAULT '0',
  `dpf_ul` double NOT NULL DEFAULT '0',
  `dpf_halting` double NOT NULL DEFAULT '0',
  `lh` double NOT NULL DEFAULT '0',
  `lh_paid` double NOT NULL DEFAULT '0',
  `lh_balance` double NOT NULL DEFAULT '0',
  `load_amt` double NOT NULL DEFAULT '0',
  `ul` double NOT NULL DEFAULT '0',
  `lc` double NOT NULL DEFAULT '0',
  `hoting` double NOT NULL DEFAULT '0',
  `is_billed` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `entry_user` int NOT NULL,
  `cancel_uid` int DEFAULT NULL,
  `cancel_date_time` datetime DEFAULT NULL,
  `entry_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_supplier_id` (`supplier_id`),
  KEY `idx_customer_id` (`customer_id`),
  KEY `idx_lr_date` (`lr_date`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transport_bill_order`
--

LOCK TABLES `transport_bill_order` WRITE;
/*!40000 ALTER TABLE `transport_bill_order` DISABLE KEYS */;
INSERT INTO `transport_bill_order` VALUES (1,7,'TN22CR9851','','2026-06-18','111',6,'Chennai Local Services',6000,6000,0,0,0,0,5500,5000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-06-23 19:25:29'),(2,6,'','','2026-06-01','244',5,'Vellore',21850,16500,100,0,5250,0,14000,12500,1500,100,5250,0,0,0,1,25,NULL,NULL,'2026-06-24 19:33:42'),(3,7,'','','2026-06-01','12',6,'Chennai Local Services',5500,5500,0,0,0,0,5000,5000,0,0,0,0,0,0,1,25,NULL,NULL,'2026-06-24 19:35:55'),(4,6,'','','2026-06-03','245\r\n246\r\n247',5,'Vellore',21400,16500,300,0,4600,0,14000,13000,1000,100,4600,0,0,0,1,25,NULL,NULL,'2026-06-24 19:43:57'),(5,8,'','','2026-06-03','253',7,'Vizag',78000,78000,0,0,0,0,68000,50000,18000,200,0,0,0,0,1,25,NULL,NULL,'2026-06-24 19:45:51'),(6,7,'','','2026-06-03','13',6,'Chennai Local Services',6000,6000,0,0,0,0,5500,5500,0,0,0,0,0,0,1,25,NULL,NULL,'2026-06-24 19:46:23'),(7,16,'','','2026-06-04','248',5,'Hyderabad',36600,35000,100,0,1500,0,32000,30000,2000,100,1500,0,0,0,1,25,NULL,NULL,'2026-06-24 19:47:35'),(8,14,'','','2026-06-04','249',5,'Kodad',48415,45000,100,0,2315,1000,40000,36000,4000,100,2315,0,1000,0,1,25,NULL,NULL,'2026-06-24 19:49:43'),(9,9,'','','2026-06-05','259',8,'Cochin (Up and Down)',30000,30000,0,0,0,0,26000,26000,0,0,0,0,0,0,1,25,NULL,NULL,'2026-06-24 19:51:34'),(10,7,'','','2026-06-06','14',6,'Chennai Local Services',6000,6000,0,0,0,0,5500,5500,0,0,0,0,0,0,1,25,NULL,NULL,'2026-06-24 19:52:36'),(11,1,'','','2026-06-08','15',4,'Madavaram to Tondiarpet',2500,2500,0,0,0,0,1800,1800,0,0,0,0,0,1,1,25,NULL,NULL,'2026-06-24 19:55:09'),(12,6,'','','2026-06-08','276277',5,'Kanchipuram/Vellore',11230,9500,200,0,1530,0,8500,7500,1000,100,1530,0,0,0,1,25,NULL,NULL,'2026-06-24 19:56:40'),(13,6,'','','2026-06-09','278\r\n279',5,'Vellore',10120,8500,200,1420,0,0,7500,6500,1000,100,1420,0,0,0,1,25,NULL,NULL,'2026-06-24 19:58:33'),(14,11,'','','2026-06-09','254',4,'Bangalore',15800,12000,50,750,3000,0,10000,9000,1000,800,3000,0,0,1,1,25,NULL,NULL,'2026-06-24 20:00:49'),(15,1,'','','2026-06-09','96',6,'Bangalore',16500,16500,0,0,0,0,14500,12000,2500,0,0,0,0,0,1,25,NULL,NULL,'2026-06-24 20:01:56'),(16,2,'','','2026-06-10','255',4,'Kolkata',82000,75000,50,2400,4550,0,67000,62000,5000,2450,5000,0,0,1,1,25,NULL,NULL,'2026-06-24 20:06:00'),(17,6,'','','2026-06-10','280',5,'Kanchipuram',11408,9000,100,0,2308,0,8000,7000,1000,100,2308,0,0,0,1,25,NULL,NULL,'2026-06-24 20:07:05'),(18,31,'','','2026-06-10','281',5,'Pondy',12272,11000,100,0,1172,0,9500,8500,1000,100,1172,0,0,0,1,25,NULL,NULL,'2026-06-24 20:09:48'),(19,1,'TN03AE5173','+919962908899','2026-06-25','25',12,'Gummidipoondi',3500,3500,0,0,0,0,2800,2800,0,350,0,0,0,1,1,25,NULL,NULL,'2026-06-25 19:17:41'),(20,23,'TN12AU1549 / TN12AU1570','9360958170','2026-06-25','269',4,'Tondiarpet to Ennore',13050,13000,50,0,0,0,12000,12000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-06-25 19:19:26'),(21,4,'','','2026-06-11','282\r\n283',5,'Trichy/Karur',28493,26000,200,0,2293,0,24000,22500,1500,100,2293,0,0,0,1,25,NULL,NULL,'2026-06-25 21:02:31'),(22,18,'','','2026-06-11','284\r\n285\r\n286',5,'Trichy/Dindugal',29266,27000,300,0,1966,0,24200,22200,2000,100,1966,0,0,0,1,25,NULL,NULL,'2026-06-25 21:04:33'),(23,6,'','','2026-06-11','266',5,'Vellore to Chennai',8100,8000,100,0,0,0,8500,7500,1000,100,0,0,0,0,1,25,NULL,NULL,'2026-06-25 21:05:54'),(24,1,'','','2026-06-11','265',5,'Kanchipuram to Chennai',7100,7000,100,0,0,0,7000,7000,0,100,0,0,0,0,1,25,NULL,NULL,'2026-06-25 21:06:47'),(25,21,'','','2026-06-11','256',4,'Kolkata',84150,76500,50,3000,4600,0,67000,60000,7000,3025,4800,0,0,1,1,25,NULL,NULL,'2026-06-25 21:10:07'),(26,1,'','','2026-06-11','257\r\n258',9,'Malur  to Raipur',40000,40000,0,0,0,0,36000,36000,0,0,0,0,0,0,1,25,NULL,NULL,'2026-06-25 21:14:46'),(27,24,'','','2026-06-12','260\r\n261',5,'Hubli/Bangalore',42200,42000,200,0,0,0,38000,36000,2000,100,0,0,0,0,1,25,NULL,NULL,'2026-06-25 21:19:13'),(28,6,'','','2026-06-12','287',5,'Kanchipuram',13750,10500,100,0,3150,0,9100,8100,1000,100,3150,0,0,0,1,25,NULL,NULL,'2026-06-25 21:20:59'),(29,1,'','','2026-06-12','288',5,'Vellore',12155,9500,100,0,2555,0,8500,7500,1000,100,2555,0,0,0,1,25,NULL,NULL,'2026-06-25 21:22:34'),(30,26,'','','2026-06-13','262',4,'Pondy',6050,6000,50,0,0,0,5000,5000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-06-26 19:20:23'),(31,1,'','','2026-06-15','19',6,'Chennai Local Services',12000,12000,0,0,0,0,11000,11000,0,0,0,0,0,0,1,25,NULL,NULL,'2026-06-26 19:21:33'),(32,10,'','','2026-06-15','289\r\n290',5,'Vilupuram',14910,11500,200,0,3210,0,10000,9000,1000,100,3210,0,0,0,1,25,NULL,NULL,'2026-06-26 19:22:49'),(33,3,'','','2026-06-15','291\r\n292',5,'Ranipet/Vellore',11170,9500,200,0,1470,0,8500,8000,500,100,1490,0,0,0,1,25,NULL,NULL,'2026-06-26 19:24:06'),(34,10,'','','2026-06-15','293',5,'Pondy',13064,11000,100,0,1964,0,9500,8500,1000,100,1964,0,0,0,1,25,NULL,NULL,'2026-06-26 19:25:09'),(35,25,'','','2026-06-16','263',4,'Vijayawada',27060,24500,50,1900,610,0,23500,22000,1500,1950,610,0,0,1,1,25,NULL,NULL,'2026-06-26 19:32:06'),(36,1,'','','2026-06-17','20',4,'Tondiarpet to Triway',4500,4500,0,0,0,0,4000,4000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-06-26 19:32:57'),(37,1,'','','2026-06-17','264',4,'Bangalore',21081,15000,50,1600,4431,0,14000,13000,1000,1640,4431,0,0,1,1,25,NULL,NULL,'2026-06-26 19:34:24'),(38,27,'','','2026-06-18','294',5,'Khammam',37850,37000,100,750,0,0,34000,32000,2000,100,750,0,0,1,1,25,NULL,NULL,'2026-06-26 19:41:36'),(39,4,'','','2026-06-18','295',5,'Coimbatore',31100,31000,100,0,0,0,28000,25000,3000,100,0,0,0,1,1,25,NULL,NULL,'2026-06-26 19:44:11'),(40,20,'','','2026-06-19','296297',5,'Ranipet/Vellore',12820,10000,200,0,2620,0,9000,8000,1000,100,2620,0,0,1,1,25,NULL,NULL,'2026-06-26 19:48:59'),(41,7,'','','2026-06-19','267',4,'Oragadam',10550,10000,50,500,0,0,9000,9000,0,500,0,0,0,1,1,25,NULL,NULL,'2026-06-26 19:49:44'),(42,19,'','','2026-06-20','268',4,'Gulbarga',28765,26000,50,300,2415,0,23000,22000,1000,322,2000,0,0,1,1,25,NULL,NULL,'2026-06-26 19:51:18'),(43,4,'','','2026-06-22','298',5,'Coimbatore',25100,25000,100,0,0,0,22000,20000,2000,100,0,0,0,1,1,25,NULL,NULL,'2026-06-26 19:53:10'),(44,5,'','','2026-06-22','299',5,'Cochin',35100,35000,100,0,0,0,32000,30000,2000,100,0,0,0,1,1,25,NULL,NULL,'2026-06-26 19:54:10'),(45,28,'TN19AR8356','8667548642','2026-06-26','301,302,303',5,'Pondy/Karaikal',20809,18500,300,0,1309,700,17000,0,0,100,1309,0,700,1,1,25,NULL,NULL,'2026-06-26 20:09:30'),(46,10,'TN10AF1199','9940325749','2026-06-26','300',5,'Cuddalore',16208,14000,100,0,2108,0,12000,0,0,100,2108,0,0,1,1,25,NULL,NULL,'2026-06-26 20:10:30'),(47,8,'AP39TQ3369','9793153666','2026-06-26','0270',9,'Vizag to Chennai',98000,90000,0,0,0,8000,80000,0,80000,0,0,0,8000,1,1,25,NULL,NULL,'2026-06-26 20:15:15'),(48,29,'KA02AL0907','7548801613','2026-06-27','271',4,'Bangalore',17747,14500,50,800,2397,0,11500,10800,700,820,2397,0,0,1,1,25,NULL,NULL,'2026-06-29 19:59:34'),(49,30,'','','2026-06-27','330',5,'Pondy to Chennai',6100,6000,100,0,0,0,5500,5000,500,100,0,0,0,1,1,25,NULL,NULL,'2026-06-29 20:01:19'),(50,31,'TN16L2482','8883191289','2026-06-29','304305306',5,'Vilupuram/Pondy',14358,12000,300,0,2058,0,10500,9500,1000,100,2058,0,0,1,1,25,NULL,NULL,'2026-06-29 20:04:46'),(51,2,'TN18BH3623','8110084875','2026-06-29','272',4,'Vijayawada',26160,24000,50,1600,510,0,23000,21000,2000,1720,510,0,0,1,1,25,NULL,NULL,'2026-06-29 20:06:04'),(52,29,'TN73AH7796','6379603001','2026-06-29','10',14,'Bangalore',9000,9000,0,0,0,0,8000,7000,1000,0,0,0,0,1,1,25,NULL,NULL,'2026-06-29 20:09:24'),(53,14,'','','2026-06-30','273',4,'Nagapatinam',11250,11000,50,0,200,0,9500,8500,1000,0,200,0,0,1,1,25,NULL,NULL,'2026-07-02 12:06:08'),(54,32,'','','2026-06-30','274',4,'Repalle',21300,19500,50,1750,0,0,16000,15000,1000,1760,0,0,0,1,1,25,NULL,NULL,'2026-07-02 12:07:24'),(55,32,'','','2026-06-30','275',4,'Koduru',17800,17000,50,750,0,0,14000,13000,1000,792,0,0,0,1,1,25,NULL,NULL,'2026-07-02 12:08:11'),(56,8,'','','2026-06-30','326',13,'Vizag',85000,85000,0,0,0,0,72000,62000,10000,0,0,0,0,1,1,25,NULL,NULL,'2026-07-02 12:09:00'),(57,7,'','','2026-06-30','11',6,'Chennai Local',6000,6000,0,0,0,0,5500,5500,0,0,0,0,0,1,1,25,NULL,NULL,'2026-07-02 12:09:34'),(58,8,'','','2026-07-01','327',7,'Vizag',80000,80000,0,0,0,0,70000,62000,8000,0,0,0,0,1,1,25,NULL,NULL,'2026-07-03 15:42:06'),(59,6,'','','2026-07-01','307\r\n308',5,'Vellore',11050,9500,200,0,1350,0,8500,7500,1000,100,1350,0,0,0,1,25,NULL,NULL,'2026-07-04 21:48:52'),(60,6,'','','2026-07-02','309\r\n310',5,'Kanchipuram',14328,11000,200,0,3128,0,9750,8750,1000,100,3128,0,0,0,1,25,NULL,NULL,'2026-07-04 21:49:57'),(61,33,'','','2026-07-02','311\r\n312',5,'Pondy/Cuddalore',11300,10000,200,0,1100,0,8500,7500,1000,100,1100,0,0,0,1,25,NULL,NULL,'2026-07-04 21:51:37'),(62,1,'','','2026-07-03','328',4,'Oragadam',6050,6000,50,0,0,0,5000,5000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-07-04 21:52:34'),(63,21,'','','2026-07-04','329',4,'Vijayawada',26470,24500,50,1450,470,0,23000,21500,1500,1460,470,0,0,0,1,25,NULL,NULL,'2026-07-04 21:53:24'),(64,16,'','','2026-06-23','001',5,'Return charges',1000,1000,0,0,0,0,2000,1000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-07-05 14:00:34'),(65,10,'','','2026-06-29','002',5,'Return charges',1000,1000,0,0,0,0,1000,1000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-07-05 14:01:09'),(66,10,'','','2026-07-06','314\r\n315',5,'Vilupuram/Pondy',18144,15000,200,0,2944,0,13700,12700,1000,100,2944,0,0,0,1,25,NULL,NULL,'2026-07-10 18:58:53'),(67,6,'','','2026-07-06','315\r\n316\r\n317\r\n318',5,'Kanchipuram/Vellore',18143,15000,400,0,2743,0,13100,12100,1000,100,2743,0,0,0,1,25,NULL,NULL,'2026-07-10 18:59:51'),(68,28,'','','2026-07-07','319\r\n320',5,'Pondy/Cuddalore',12540,11000,200,0,1340,0,9000,8000,1000,100,1340,0,0,0,1,25,NULL,NULL,'2026-07-10 19:00:47'),(69,1,'','','2026-07-09','250',12,'Gummidipoondi',8000,8000,0,0,0,0,5500,5500,0,1250,0,0,0,1,1,25,NULL,NULL,'2026-07-10 19:01:41'),(70,1,'','','2026-07-10','5',4,'Ennore to Adyar',4000,4000,0,0,0,0,3500,0,0,0,0,0,0,1,1,25,NULL,NULL,'2026-07-10 19:10:39'),(71,1,'','','2026-07-14','351',4,'Bangalore',16560,13500,50,500,2510,0,11500,10500,1000,500,2510,0,0,0,1,25,NULL,NULL,'2026-07-18 14:18:56'),(72,19,'','','2026-07-15','352',4,'Kalaburagi',42550,32000,50,1500,9000,0,28000,26500,1500,1550,8000,0,0,0,1,25,NULL,NULL,'2026-07-18 14:20:19'),(73,9,'','','2026-07-15','353',17,'Coimbatore',21600,21500,100,0,0,0,19000,17000,2000,0,0,0,0,1,1,25,NULL,NULL,'2026-07-18 18:54:24'),(74,17,'','','2026-07-15','321',5,'Mayiladuturai',17650,16000,100,0,1550,0,15000,14000,1000,100,1550,0,0,0,1,25,NULL,NULL,'2026-07-18 18:55:26'),(75,2,'','','2026-07-16','354',4,'Vijayawada',27580,24000,50,2780,750,0,22000,20000,2000,2780,750,0,0,0,1,25,NULL,NULL,'2026-07-18 18:56:38'),(76,19,'','','2026-07-16','355',17,'Goa',34100,34000,100,0,0,0,30000,28000,2000,0,0,0,0,1,1,25,NULL,NULL,'2026-07-18 18:57:43'),(77,34,'','','2026-07-16','358',5,'Vellore to Chennai',8100,8000,100,0,0,0,7500,6000,1500,100,0,0,0,0,1,25,NULL,NULL,'2026-07-18 18:59:22'),(78,20,'','','2026-07-16','13478',5,'Vellore',9300,8000,0,0,1300,0,7000,6500,500,100,1300,0,0,0,1,25,NULL,NULL,'2026-07-18 19:00:25'),(79,1,'','','2026-07-17','356',4,'TONDIARPET TO ENNORE',10050,10000,50,0,0,0,8500,8500,0,0,0,0,0,0,1,25,NULL,NULL,'2026-07-18 19:01:23'),(80,24,'','','2026-07-17','357',4,'Bangalore',22266,16000,50,1750,4466,0,16000,15000,1000,1760,4466,0,0,0,1,25,NULL,NULL,'2026-07-18 19:02:20');
/*!40000 ALTER TABLE `transport_bill_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transport_bill_payment`
--

DROP TABLE IF EXISTS `transport_bill_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transport_bill_payment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `payment_type` tinyint NOT NULL DEFAULT '1' COMMENT '1=Cash 2=Bank 3=Mixed',
  `payment_mode` tinyint NOT NULL DEFAULT '0' COMMENT '0=None 1=UPI 2=Cheque 3=CreditCard 4=DebitCard 5=NEFT 6=IMPS',
  `paid_amount` double NOT NULL DEFAULT '0',
  `tax_amount` double NOT NULL DEFAULT '0',
  `notes` varchar(255) DEFAULT NULL,
  `entry_user` int DEFAULT NULL,
  `entry_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `entry_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_tbp_bill` (`bill_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transport_bill_payment`
--

LOCK TABLES `transport_bill_payment` WRITE;
/*!40000 ALTER TABLE `transport_bill_payment` DISABLE KEYS */;
INSERT INTO `transport_bill_payment` VALUES (1,1,1,0,0,0,NULL,25,'2026-06-23 19:28:50','2026-06-23 19:28:50'),(2,2,1,0,0,0,NULL,25,'2026-06-25 19:23:09','2026-06-25 19:23:09'),(3,3,2,1,0,0,NULL,25,'2026-07-02 11:06:42','2026-07-02 11:06:42'),(4,4,2,1,0,0,NULL,25,'2026-07-02 12:16:46','2026-07-02 12:16:46'),(5,5,2,1,0,0,NULL,25,'2026-07-02 12:26:06','2026-07-02 12:26:06'),(6,6,1,0,0,0,NULL,25,'2026-07-02 12:29:44','2026-07-02 12:29:44'),(7,7,2,1,0,0,NULL,25,'2026-07-03 15:44:50','2026-07-03 15:44:50'),(8,8,2,1,0,0,NULL,25,'2026-07-03 15:48:03','2026-07-03 15:48:03'),(9,9,2,1,0,0,NULL,25,'2026-07-05 14:17:27','2026-07-05 14:17:27'),(10,10,2,1,0,0,NULL,25,'2026-07-05 14:17:52','2026-07-05 14:17:52'),(11,11,2,1,0,0,NULL,25,'2026-07-05 14:18:34','2026-07-05 14:18:34'),(12,12,2,1,0,0,NULL,25,'2026-07-05 14:18:59','2026-07-05 14:18:59'),(13,13,2,1,0,0,NULL,25,'2026-07-05 14:19:20','2026-07-05 14:19:20'),(14,14,2,1,0,0,NULL,25,'2026-07-05 14:19:50','2026-07-05 14:19:50'),(15,15,2,1,0,0,NULL,25,'2026-07-05 14:20:14','2026-07-05 14:20:14'),(16,16,2,1,0,0,NULL,25,'2026-07-05 14:21:13','2026-07-05 14:21:13'),(17,17,2,1,0,0,NULL,25,'2026-07-05 14:21:41','2026-07-05 14:21:41'),(18,18,2,1,0,0,NULL,25,'2026-07-05 14:24:28','2026-07-05 14:24:28'),(19,19,2,1,0,0,NULL,25,'2026-07-05 14:24:44','2026-07-05 14:24:44'),(20,20,2,1,0,0,NULL,25,'2026-07-10 19:04:52','2026-07-10 19:04:52'),(21,21,2,1,0,0,NULL,25,'2026-07-10 19:41:29','2026-07-10 19:41:29'),(22,22,2,1,0,0,NULL,25,'2026-07-10 19:56:45','2026-07-10 19:56:45'),(23,23,2,1,0,0,NULL,25,'2026-07-10 20:09:19','2026-07-10 20:09:19'),(24,24,2,1,0,0,NULL,25,'2026-07-12 19:08:36','2026-07-12 19:08:36'),(25,25,2,1,0,0,NULL,25,'2026-07-16 12:15:16','2026-07-16 12:15:16'),(26,26,2,1,0,0,NULL,25,'2026-07-18 19:05:03','2026-07-18 19:05:03'),(27,27,2,1,0,0,NULL,25,'2026-07-18 19:07:43','2026-07-18 19:07:43');
/*!40000 ALTER TABLE `transport_bill_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transport_lr_copy`
--

DROP TABLE IF EXISTS `transport_lr_copy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transport_lr_copy` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lr_no` varchar(20) NOT NULL,
  `customer_id` int DEFAULT '0',
  `customer_name` varchar(255) DEFAULT NULL,
  `phone_number` varchar(30) DEFAULT NULL,
  `lr_date` date DEFAULT NULL,
  `truck_no` varchar(100) DEFAULT NULL,
  `from_location` varchar(255) DEFAULT NULL,
  `to_location` varchar(255) DEFAULT NULL,
  `consignee_name` varchar(255) DEFAULT NULL,
  `no_of_articles` varchar(100) DEFAULT NULL,
  `description_text` varchar(255) DEFAULT NULL,
  `weight_mt` varchar(100) DEFAULT NULL,
  `mode_payment1` varchar(255) DEFAULT NULL,
  `freight_amount` varchar(100) DEFAULT NULL,
  `to_pay_amount` varchar(100) DEFAULT NULL,
  `paid_amount` varchar(100) DEFAULT NULL,
  `amount_in_words` varchar(500) DEFAULT NULL,
  `dc_no` varchar(100) DEFAULT NULL,
  `inv_date` date DEFAULT NULL,
  `inv_no` varchar(100) DEFAULT NULL,
  `inv_date2` date DEFAULT NULL,
  `declared_value_rs` varchar(100) DEFAULT NULL,
  `pnl_seal_no` varchar(100) DEFAULT NULL,
  `material_received_date` date DEFAULT NULL,
  `pnl_no` varchar(100) DEFAULT NULL,
  `driver_name` varchar(255) DEFAULT NULL,
  `vehicle_type` varchar(100) DEFAULT NULL,
  `deliver_in` varchar(50) DEFAULT NULL,
  `entry_user` int NOT NULL,
  `entry_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `entry_date` date DEFAULT NULL,
  `is_cancelled` tinyint(1) NOT NULL DEFAULT '0',
  `cancel_uid` int DEFAULT NULL,
  `cancel_date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_lr_copy_lr_no` (`lr_no`),
  KEY `idx_lr_copy_entry_date` (`entry_date`),
  KEY `idx_lr_copy_customer_id` (`customer_id`),
  KEY `idx_lr_copy_cancelled` (`is_cancelled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transport_lr_copy`
--

LOCK TABLES `transport_lr_copy` WRITE;
/*!40000 ALTER TABLE `transport_lr_copy` DISABLE KEYS */;
/*!40000 ALTER TABLE `transport_lr_copy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transport_supplier_payment`
--

DROP TABLE IF EXISTS `transport_supplier_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transport_supplier_payment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lr_id` int NOT NULL,
  `payment_type` tinyint NOT NULL DEFAULT '1' COMMENT '1=Cash 2=Bank',
  `payment_mode` tinyint NOT NULL DEFAULT '0' COMMENT '0=None 1=UPI 2=Cheque 3=CreditCard 4=DebitCard 5=NEFT 6=IMPS',
  `paid_amount` double NOT NULL DEFAULT '0',
  `notes` varchar(255) DEFAULT NULL,
  `entry_user` int DEFAULT NULL,
  `entry_date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_tsp_lr` (`lr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transport_supplier_payment`
--

LOCK TABLES `transport_supplier_payment` WRITE;
/*!40000 ALTER TABLE `transport_supplier_payment` DISABLE KEYS */;
INSERT INTO `transport_supplier_payment` VALUES (1,1,2,1,5000,NULL,25,'2026-06-23 19:25:29'),(2,2,2,1,12500,NULL,25,'2026-06-24 19:33:42'),(3,3,2,1,5000,NULL,25,'2026-06-24 19:35:55'),(4,4,2,1,13000,NULL,25,'2026-06-24 19:43:57'),(5,5,2,1,50000,NULL,25,'2026-06-24 19:45:51'),(6,6,2,1,5500,NULL,25,'2026-06-24 19:46:23'),(7,7,2,1,30000,NULL,25,'2026-06-24 19:47:35'),(8,8,2,1,36000,NULL,25,'2026-06-24 19:49:43'),(9,9,1,0,26000,NULL,25,'2026-06-24 19:51:34'),(10,10,2,1,5500,NULL,25,'2026-06-24 19:52:36'),(11,11,2,1,1800,NULL,25,'2026-06-24 19:55:09'),(12,12,2,1,7500,NULL,25,'2026-06-24 19:56:40'),(13,13,2,1,6500,NULL,25,'2026-06-24 19:58:33'),(14,14,2,1,9000,NULL,25,'2026-06-24 20:00:49'),(15,15,2,1,12000,NULL,25,'2026-06-24 20:01:56'),(16,16,2,1,62000,NULL,25,'2026-06-24 20:06:00'),(17,17,2,1,7000,NULL,25,'2026-06-24 20:07:05'),(18,18,2,1,8500,NULL,25,'2026-06-24 20:09:48'),(19,19,2,1,2800,NULL,25,'2026-06-25 19:17:41'),(20,20,2,1,12000,NULL,25,'2026-06-25 19:19:26'),(21,21,2,1,22500,NULL,25,'2026-06-25 21:02:31'),(22,22,2,1,22200,NULL,25,'2026-06-25 21:04:33'),(23,23,2,1,7500,NULL,25,'2026-06-25 21:05:54'),(24,24,2,1,7000,NULL,25,'2026-06-25 21:06:47'),(25,25,2,1,60000,NULL,25,'2026-06-25 21:10:07'),(26,26,2,1,36000,NULL,25,'2026-06-25 21:14:46'),(27,27,2,1,36000,NULL,25,'2026-06-25 21:19:13'),(28,28,2,1,8100,NULL,25,'2026-06-25 21:20:59'),(29,29,1,0,7500,NULL,25,'2026-06-25 21:22:34'),(30,30,1,0,5000,NULL,25,'2026-06-26 19:20:23'),(31,31,1,0,11000,NULL,25,'2026-06-26 19:21:33'),(32,32,1,0,9000,NULL,25,'2026-06-26 19:22:49'),(33,33,2,1,8000,NULL,25,'2026-06-26 19:24:06'),(34,34,2,1,8500,NULL,25,'2026-06-26 19:25:09'),(35,35,2,1,22000,NULL,25,'2026-06-26 19:32:06'),(36,36,2,1,4000,NULL,25,'2026-06-26 19:32:57'),(37,37,2,1,13000,NULL,25,'2026-06-26 19:34:24'),(38,38,2,1,32000,NULL,25,'2026-06-26 19:41:36'),(39,39,2,1,25000,NULL,25,'2026-06-26 19:44:11'),(40,40,2,1,8000,NULL,25,'2026-06-26 19:48:59'),(41,41,2,1,9000,NULL,25,'2026-06-26 19:49:44'),(42,42,2,1,22000,NULL,25,'2026-06-26 19:51:18'),(43,43,2,1,20000,NULL,25,'2026-06-26 19:53:10'),(44,44,2,1,30000,NULL,25,'2026-06-26 19:54:10'),(45,48,2,1,10800,NULL,25,'2026-06-29 19:59:34'),(46,49,2,1,5000,NULL,25,'2026-06-29 20:01:19'),(47,50,2,1,9500,NULL,25,'2026-06-29 20:04:46'),(48,51,2,1,21000,NULL,25,'2026-06-29 20:06:04'),(49,52,2,1,7000,NULL,25,'2026-06-29 20:09:24'),(50,53,2,1,8500,NULL,25,'2026-07-02 12:06:08'),(51,54,2,1,15000,NULL,25,'2026-07-02 12:07:24'),(52,55,2,1,13000,NULL,25,'2026-07-02 12:08:11'),(53,56,2,1,62000,NULL,25,'2026-07-02 12:09:00'),(54,57,2,1,5500,NULL,25,'2026-07-02 12:09:34'),(55,58,2,1,62000,NULL,25,'2026-07-03 15:42:06'),(56,59,2,1,7500,NULL,25,'2026-07-04 21:48:52'),(57,60,2,1,8750,NULL,25,'2026-07-04 21:49:57'),(58,61,2,1,7500,NULL,25,'2026-07-04 21:51:37'),(59,62,2,1,5000,NULL,25,'2026-07-04 21:52:34'),(60,63,2,1,21500,NULL,25,'2026-07-04 21:53:24'),(61,64,2,1,1000,NULL,25,'2026-07-05 14:00:34'),(62,65,2,1,1000,NULL,25,'2026-07-05 14:01:09'),(63,66,2,1,12700,NULL,25,'2026-07-10 18:58:53'),(64,67,2,1,12100,NULL,25,'2026-07-10 18:59:51'),(65,68,2,1,8000,NULL,25,'2026-07-10 19:00:47'),(66,69,2,1,5500,NULL,25,'2026-07-10 19:01:41'),(67,71,2,1,10500,NULL,25,'2026-07-18 14:18:56'),(68,72,2,1,26500,NULL,25,'2026-07-18 14:20:19'),(69,73,2,1,17000,NULL,25,'2026-07-18 18:54:24'),(70,74,2,1,14000,NULL,25,'2026-07-18 18:55:26'),(71,75,2,1,20000,NULL,25,'2026-07-18 18:56:38'),(72,76,2,1,28000,NULL,25,'2026-07-18 18:57:43'),(73,77,2,1,6000,NULL,25,'2026-07-18 18:59:22'),(74,78,2,1,6500,NULL,25,'2026-07-18 19:00:25'),(75,79,2,1,8500,NULL,25,'2026-07-18 19:01:23'),(76,80,2,1,15000,NULL,25,'2026-07-18 19:02:20');
/*!40000 ALTER TABLE `transport_supplier_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_modules`
--

DROP TABLE IF EXISTS `user_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_modules` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `module_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_modules`
--

LOCK TABLES `user_modules` WRITE;
/*!40000 ALTER TABLE `user_modules` DISABLE KEYS */;
INSERT INTO `user_modules` VALUES (1,'LR Order'),(2,'LR Order List'),(3,'Transportation Bill'),(4,'Balance Collection'),(5,'Supplier collection'),(6,'Collection Report'),(7,'Supplier collection Report'),(8,'Profit Report'),(9,'Master'),(10,'Admin'),(12,'LR Copy');
/*!40000 ALTER TABLE `user_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_permission`
--

DROP TABLE IF EXISTS `user_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_permission` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `module_id` int NOT NULL,
  `uid` int NOT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mod` (`module_id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_permission`
--

LOCK TABLES `user_permission` WRITE;
/*!40000 ALTER TABLE `user_permission` DISABLE KEYS */;
INSERT INTO `user_permission` VALUES (133,1,25,'2026-07-11','15:46:17'),(134,2,25,'2026-07-11','15:46:17'),(135,3,25,'2026-07-11','15:46:17'),(136,4,25,'2026-07-11','15:46:17'),(137,5,25,'2026-07-11','15:46:17'),(138,6,25,'2026-07-11','15:46:17'),(139,7,25,'2026-07-11','15:46:17'),(140,8,25,'2026-07-11','15:46:17'),(141,9,25,'2026-07-11','15:46:17'),(142,10,25,'2026-07-11','15:46:17'),(143,12,25,'2026-07-11','15:46:17'),(144,1,1,'2026-07-11','15:46:49'),(145,2,1,'2026-07-11','15:46:49'),(146,3,1,'2026-07-11','15:46:49'),(147,4,1,'2026-07-11','15:46:49'),(148,5,1,'2026-07-11','15:46:49'),(149,6,1,'2026-07-11','15:46:49'),(150,7,1,'2026-07-11','15:46:49'),(151,8,1,'2026-07-11','15:46:49'),(152,9,1,'2026-07-11','15:46:49'),(153,10,1,'2026-07-11','15:46:49'),(154,12,1,'2026-07-11','15:46:49');
/*!40000 ALTER TABLE `user_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_special_permission`
--

DROP TABLE IF EXISTS `user_special_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_special_permission` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `content_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_special_permission`
--

LOCK TABLES `user_special_permission` WRITE;
/*!40000 ALTER TABLE `user_special_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_special_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `is_active` int DEFAULT '1',
  `fullName` varchar(255) DEFAULT NULL,
  `disc_per` int DEFAULT '100',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','aecbf9a63cec1e93327dfc212f31acdb31c4f5d10bedccf8fbb8b042a6f0f39155797bdd04517905ae5d98b69fdc452cdb61b018e10939740ec96f36e133d639',1,'admin',50),(25,'mahesh','3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2',1,'Mahesh',100);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-23 14:02:38

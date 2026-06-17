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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_account`
--

LOCK TABLES `customer_account` WRITE;
/*!40000 ALTER TABLE `customer_account` DISABLE KEYS */;
INSERT INTO `customer_account` VALUES (1,4,0.00,0.00),(2,5,0.00,0.00),(3,6,0.00,0.00),(4,7,0.00,0.00),(5,8,0.00,0.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'JASWA VIJAY','9597451419','SFASDFSADDFSD \r\nasgsdg \r\nSFSDDSDDGSDG','2026-06-10','21:47:48',0,1,'2112232wfsfffsd',1,NULL,NULL,0.00,1,0.000),(2,'jeb','9898989898','','2026-06-10','22:20:38',0,1,'',0,NULL,NULL,0.00,1,0.000),(3,'cc','','','2026-06-13','11:13:27',0,1,'',0,NULL,NULL,0.00,1,0.000),(4,'TABLET','9856985698','SDSDSD\r\nfDGDFGD','2026-06-13','13:38:44',0,1,'789655452222222',1,NULL,NULL,0.00,1,0.000),(5,'M/s.Subbulakshmi Enterprises, ','','384B, Thamarai Street, Poompozhil Nagar, Avadi,Chennai - 600062','2026-06-15','12:18:46',0,1,'33ACIFS3563J1ZW',1,NULL,NULL,0.00,1,0.000),(6,'M/s.Crown Worldwide Private Ltd.,','','119/1B1K, Moopanar Street, \r\nPerumattunallur, Pandur Village, \r\nChengalpattu District, Tamilnadu-603202','2026-06-15','12:39:48',0,1,'33AAACC6484D1ZX',1,NULL,NULL,0.00,1,0.000),(7,'M/s. BES Global Logistics Pvt Ltd.,','','JK Towers No-28, 3rd Floor,\r\n\'\"B\" Wing Bazullah Road,\r\n T.Nagar,Chennai-600017','2026-06-15','13:17:56',0,1,'33AAJCB8783B1ZN',1,NULL,NULL,0.00,1,0.000),(8,'M/s.Star Worldwide Group Private Ltd.,','','Lokesh Nagar, Old No. 1/10, New No.1/10A1, Tiruverkadu,Periyakoladi Road,Chennai Thiruvallur-600077','2026-06-15','13:46:19',0,1,'33AABCS5979A1ZG',1,NULL,NULL,0.00,1,0.000);
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_supplier`
--

LOCK TABLES `prod_supplier` WRITE;
/*!40000 ALTER TABLE `prod_supplier` DISABLE KEYS */;
INSERT INTO `prod_supplier` VALUES (1,'Supp','','','2026-05-14','13:03:13',1,NULL,0),(2,'aaaaa','','','2026-06-11','16:23:03',1,NULL,0),(3,'annai','','','2026-06-13','11:11:55',1,NULL,0),(4,'TFG','','','2026-06-13','11:16:30',1,NULL,0),(5,'TABLET','9898989898','DCSDF\r\nSDGDG','2026-06-13','13:37:41',1,'atp63773HNDCJSD',1),(6,'SR Transport','9841496208','Madavarm','2026-06-15','12:09:09',1,NULL,0),(7,'Periyapalayathamman Transport','9500070474','Poonamalle','2026-06-15','12:36:12',1,NULL,0),(8,'SREE MANJUNATHA TRANSPORT','9840561132','Chennai','2026-06-15','13:15:14',1,NULL,0),(9,'Mathi transport','9884129002','Madavarm','2026-06-15','13:41:25',1,NULL,0);
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
  `credit_days` int DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transport_bill`
--

LOCK TABLES `transport_bill` WRITE;
/*!40000 ALTER TABLE `transport_bill` DISABLE KEYS */;
INSERT INTO `transport_bill` VALUES (2,'26-1','2026-06-13',2,'TNHG','158563',10000,8000,2000,'Bank/IMPS',2,NULL,NULL,0,NULL,NULL,1,'2026-06-13 12:11:34'),(3,'26-2','2026-06-13',4,'TN DEPO','99999',15000,15000,0,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,1,'2026-06-13 13:44:01'),(4,'26-3','2026-06-13',1,NULL,NULL,15000,0,15000,'Cash',1,30,'2026-07-13',1,1,'2026-06-13 14:32:45',1,'2026-06-13 14:31:09'),(5,'26-4','2026-06-15',5,NULL,NULL,21850,0,21850,'Cash',1,NULL,NULL,1,25,'2026-06-15 13:53:49',25,'2026-06-15 12:24:02'),(6,'26-5','2026-06-15',6,NULL,NULL,6000,0,6000,'Cash',1,NULL,NULL,0,NULL,NULL,25,'2026-06-15 12:43:00'),(7,'26-6','2026-06-15',5,NULL,'996791',21400,0,21400,'Cash',1,NULL,NULL,1,25,'2026-06-15 13:53:58',25,'2026-06-15 12:53:11'),(8,'26-7','2026-06-15',7,NULL,NULL,78000,0,78000,'Cash',1,NULL,NULL,1,25,'2026-06-15 13:24:36',25,'2026-06-15 13:23:36'),(9,'26-8','2026-06-15',7,NULL,'996791',78000,78000,0,'Bank/NEFT',2,NULL,NULL,0,NULL,NULL,25,'2026-06-15 13:27:31'),(10,'26-9','2026-06-15',8,NULL,'996791',30000,0,30000,'Bank/UPI',2,30,'2026-07-15',0,NULL,NULL,25,'2026-06-15 13:50:42'),(11,'26-10','2026-06-15',5,NULL,NULL,43250,20000,23250,'Cash',1,NULL,NULL,0,NULL,NULL,25,'2026-06-15 13:58:32');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transport_bill_balance`
--

LOCK TABLES `transport_bill_balance` WRITE;
/*!40000 ALTER TABLE `transport_bill_balance` DISABLE KEYS */;
INSERT INTO `transport_bill_balance` VALUES (1,4,15000,'2026-07-13',0,NULL,NULL,0,NULL,'2026-06-13 14:31:09'),(2,10,30000,'2026-07-15',0,NULL,NULL,0,NULL,'2026-06-15 13:50:42');
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
  `particular` varchar(255) NOT NULL,
  `qty` varchar(50) DEFAULT NULL,
  `rate_wt` varchar(100) DEFAULT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `sort_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_tbd_bill` (`bill_id`),
  KEY `idx_tbd_bill_lr` (`bill_lr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transport_bill_details`
--

LOCK TABLES `transport_bill_details` WRITE;
/*!40000 ALTER TABLE `transport_bill_details` DISABLE KEYS */;
INSERT INTO `transport_bill_details` VALUES (16,3,2,2,'SDSD','','',9000,1),(17,3,2,2,'SDFF','','',1000,2),(18,3,2,2,'FDDF','','',0,3),(19,3,2,2,'DFFDD','','',0,4),(20,3,3,3,'DFDDF','1','FD',5000,1),(21,3,3,3,'DDF','','',0,2),(22,3,3,3,'DFDFDF','','',0,3),(23,2,1,1,'ASF','251','AWT',1000,1),(24,2,1,1,'LF','1','O',5000,2),(25,2,1,1,'GG','1','O',4000,3),(26,2,1,1,'EWEEW','1','O',0,4),(27,2,1,1,'EWEW','1','O',0,5),(28,4,4,4,'ddffd','','',15000,1),(29,5,5,6,'BHARATH BATTERY DISTRIBUTORS','424','14000 KG',16500,1),(30,5,5,6,'L R Charges','','',100,2),(31,5,5,6,'Unloading charges','','',5250,3),(32,6,6,7,'Used house hold goods','23','F T L',6000,1),(33,6,6,7,'Chennai local services','','',0,2),(34,6,6,7,'20 Feet closed container','','',0,3),(35,6,6,7,'Container No. TN22CR9865','','',0,4),(36,6,6,7,'A/c. Mr.Mahesh','','',0,5),(37,7,7,8,'BHARATH BATTERY DISTRIBUTORS','262','14000 KG',16500,1),(38,7,7,8,'BHARATH BATTERY DISTRIBUTORS','257','1500 KG',0,2),(39,7,7,8,'BHARATH BATTERY DISTRIBUTORS','982','2574 KG',0,3),(40,7,7,8,'L R Charges','','',300,4),(41,7,7,8,'Unloading Charges','','',4600,5),(42,7,7,8,'Chennai to Vellore','','',0,6),(43,7,7,8,'Taurus No. : TN22CR9851','','',0,7),(44,8,8,9,'MRI MACHINE','07','F T L',78000,1),(45,8,8,9,'Chennai to Vizag','','',0,2),(46,8,8,9,'40 feet open trailer','','',0,3),(47,8,8,9,'Trialer No. AP25E-9874','','',0,4),(48,9,9,9,'MRI MACHINE','07','F T L',78000,1),(49,9,9,9,'CHENNAI TO VIZAG','','',0,2),(50,9,9,9,'40 FEET OPEN TRAILER','','',0,3),(51,9,9,9,'Trailer No. AP26W-8514','','',0,4),(52,10,10,10,'Used house hold goods','05','f t l',30000,1),(53,10,10,10,'chennai to cochin (up and down)','','',0,2),(54,10,10,10,'container no. TN22AV6037','','',0,3),(55,10,10,10,'AC.ANITHA','','',0,4),(56,11,11,6,'BHARATHA BATTERY','258','14000 KG',16000,1),(57,11,11,6,'L R CHARGES','','',100,2),(58,11,11,6,'UNLOADING CHARGES','','',5750,3),(59,11,11,6,'CHENNAI TO VELLORE','','',0,4),(60,11,12,8,'BHARATH BATTERY ','252','15000 KG',18000,1),(61,11,12,8,'L RCHARGES','','',100,2),(62,11,12,8,'UNLOADING CHSRGES','','',3300,3),(63,11,12,8,'CHENNAI TO VELLORE','','',0,4),(64,11,12,8,'VEHICLE NO. TN22CR9851','','',0,5);
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transport_bill_lr`
--

LOCK TABLES `transport_bill_lr` WRITE;
/*!40000 ALTER TABLE `transport_bill_lr` DISABLE KEYS */;
INSERT INTO `transport_bill_lr` VALUES (1,2,1,10000,'GFGFGFGF\nfjfjfj'),(2,3,2,10000,'DFDFDFDFDFFDFFD'),(3,3,3,5000,'DSDSD'),(4,4,4,15000,NULL),(5,5,6,21850,'Invoice No\'s : 261033105844-8554-2554-25547-2558-25448-2548\n\nChennai to Vellore\n\nTaurus vehicle No. TN23AW-3689'),(6,6,7,6000,NULL),(7,7,8,21400,NULL),(8,8,9,78000,NULL),(9,9,9,78000,NULL),(10,10,10,30000,NULL),(11,11,6,21850,NULL),(12,11,8,21400,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transport_bill_order`
--

LOCK TABLES `transport_bill_order` WRITE;
/*!40000 ALTER TABLE `transport_bill_order` DISABLE KEYS */;
INSERT INTO `transport_bill_order` VALUES (1,3,NULL,NULL,'2026-06-12','111',2,'Madurai',10000,0,0,0,0,0,1000,0,1000,2000,2000,2000,500,1,1,1,NULL,NULL,'2026-06-13 12:03:45'),(2,3,NULL,NULL,'2026-06-13','222',4,'MADURAI',10000,0,0,0,0,0,5000,0,5000,500,2000,1500,0,1,1,1,NULL,NULL,'2026-06-13 13:39:19'),(3,3,NULL,NULL,'2026-06-13','221',4,'Trichy',5000,0,0,0,0,0,2000,0,2000,1000,0,0,0,1,1,1,NULL,NULL,'2026-06-13 13:42:39'),(4,5,NULL,NULL,'2026-06-13','235',1,'COIM',15000,0,0,0,0,0,5600,0,5600,0,0,0,0,0,1,1,NULL,NULL,'2026-06-13 14:26:46'),(5,3,'TN74AY5777','9999999999','2026-06-13','563',1,'Trichy',15236,0,0,0,0,0,8569,1569,7000,0,5263,0,0,0,1,1,NULL,NULL,'2026-06-13 14:39:17'),(6,6,'TN23AP5510','9940809824','2026-06-01','0244',5,'Vellore',21850,0,0,0,0,0,14000,12500,1500,100,5250,0,0,1,1,25,NULL,NULL,'2026-06-15 12:20:03'),(7,7,'TN22CR9865','9941806894','2026-06-01','001',6,'Chennai Local Services',6000,0,0,0,0,0,5500,5500,0,0,0,0,0,1,1,25,NULL,NULL,'2026-06-15 12:40:49'),(8,6,'TN25W9865','9710295668','2026-06-03','0245-0246-0247',5,'Vellore',21400,0,0,0,0,0,14000,13000,1000,100,4600,0,0,1,1,25,NULL,NULL,'2026-06-15 12:48:51'),(9,8,'AP22T-8651','9894723073','2026-06-03','0253',7,'Vizag',78000,0,0,0,0,0,68000,50000,18000,200,0,0,0,1,1,25,NULL,NULL,'2026-06-15 13:20:16'),(10,9,'TN22CR9851','9790295668','2026-06-05','0259',8,'Cochin (Up and Down)',30000,0,0,0,0,0,26000,25000,1000,0,0,0,0,1,1,25,NULL,NULL,'2026-06-15 13:48:04');
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transport_bill_payment`
--

LOCK TABLES `transport_bill_payment` WRITE;
/*!40000 ALTER TABLE `transport_bill_payment` DISABLE KEYS */;
INSERT INTO `transport_bill_payment` VALUES (1,2,2,6,5000,0,NULL,1,'2026-06-13 12:21:10','2026-06-13 12:11:34'),(2,2,1,0,2000,0,NULL,1,'2026-06-13 12:29:55','2026-06-13 12:29:55'),(3,2,2,3,1000,0,NULL,1,'2026-06-13 12:35:05','2026-06-13 12:35:05'),(4,3,2,1,5000,0,NULL,1,'2026-06-13 13:44:01','2026-06-13 13:44:01'),(5,3,1,0,9800,0,NULL,1,'2026-06-13 13:49:02','2026-06-13 13:49:02'),(6,4,1,0,0,0,NULL,1,'2026-06-13 14:31:09','2026-06-13 14:31:09'),(7,3,1,0,100,100,NULL,1,'2026-06-13 20:35:44','2026-06-13 20:35:44'),(8,5,1,0,0,0,NULL,25,'2026-06-15 12:24:02','2026-06-15 12:24:02'),(9,6,1,0,0,0,NULL,25,'2026-06-15 12:43:00','2026-06-15 12:43:00'),(10,7,1,0,0,0,NULL,25,'2026-06-15 12:53:11','2026-06-15 12:53:11'),(11,8,1,0,0,0,NULL,25,'2026-06-15 13:23:36','2026-06-15 13:23:36'),(12,9,2,5,0,0,NULL,25,'2026-06-15 13:27:31','2026-06-15 13:27:31'),(13,9,2,5,77000,1000,NULL,25,'2026-06-15 13:32:55','2026-06-15 13:32:55'),(14,10,2,1,0,0,NULL,25,'2026-06-15 13:50:42','2026-06-15 13:50:42'),(15,11,1,0,0,0,NULL,25,'2026-06-15 13:58:32','2026-06-15 13:58:32'),(16,11,2,1,20000,0,NULL,25,'2026-06-15 14:02:11','2026-06-15 14:02:11');
/*!40000 ALTER TABLE `transport_bill_payment` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transport_supplier_payment`
--

LOCK TABLES `transport_supplier_payment` WRITE;
/*!40000 ALTER TABLE `transport_supplier_payment` DISABLE KEYS */;
INSERT INTO `transport_supplier_payment` VALUES (1,5,1,0,569,NULL,1,'2026-06-13 21:06:32'),(2,5,1,0,1000,NULL,1,'2026-06-13 21:06:44'),(3,6,2,1,12500,NULL,25,'2026-06-15 12:20:03'),(4,7,2,1,5500,NULL,25,'2026-06-15 12:40:49'),(5,8,2,1,13000,NULL,25,'2026-06-15 12:48:51'),(6,9,1,0,50000,NULL,25,'2026-06-15 13:20:16'),(7,10,2,1,25000,NULL,25,'2026-06-15 13:48:04');
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_modules`
--

LOCK TABLES `user_modules` WRITE;
/*!40000 ALTER TABLE `user_modules` DISABLE KEYS */;
INSERT INTO `user_modules` VALUES (1,'LR Order'),(2,'LR Order List'),(3,'Transportation Bill'),(4,'Balance Collection'),(5,'Supplier collection'),(6,'Collection Report'),(7,'Supplier collection Report'),(8,'Profit Report'),(9,'Master'),(10,'Admin');
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
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_permission`
--

LOCK TABLES `user_permission` WRITE;
/*!40000 ALTER TABLE `user_permission` DISABLE KEYS */;
INSERT INTO `user_permission` VALUES (70,1,1,'2025-09-19','11:43:23'),(71,2,1,'2025-09-19','11:43:23'),(72,3,1,'2025-09-19','11:43:23'),(73,4,1,'2025-09-19','11:43:23'),(74,5,1,'2025-09-19','11:43:23'),(75,6,1,'2025-09-19','11:43:23'),(76,7,1,'2025-09-19','11:43:23'),(77,8,1,'2025-09-19','11:43:23'),(121,9,1,'2025-09-19','11:43:23'),(122,10,1,'2025-09-19','11:43:23'),(123,1,25,'2026-06-15','12:00:13'),(124,2,25,'2026-06-15','12:00:13'),(125,3,25,'2026-06-15','12:00:13'),(126,4,25,'2026-06-15','12:00:13'),(127,5,25,'2026-06-15','12:00:13'),(128,6,25,'2026-06-15','12:00:13'),(129,7,25,'2026-06-15','12:00:13'),(130,8,25,'2026-06-15','12:00:13'),(131,9,25,'2026-06-15','12:00:13'),(132,10,25,'2026-06-15','12:00:13');
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

-- Dump completed on 2026-06-17 14:36:49

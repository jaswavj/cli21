/*
SQLyog Community v13.3.1 (64 bit)
MySQL - 8.4.7 : Database - periyanayaki
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`periyanayaki` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `periyanayaki`;

/*Table structure for table `attender` */

DROP TABLE IF EXISTS `attender`;

CREATE TABLE `attender` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `is_active` int DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `attender` */

/*Table structure for table `company_details` */

DROP TABLE IF EXISTS `company_details`;

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

/*Data for the table `company_details` */

insert  into `company_details`(`id`,`shop_name`,`address`,`gstin`,`print_type`,`printer_name`,`bank_details`,`barcode_printer`) values 
(2,'PERIYANAYAKI LOGISTICS','No.18, Officers Colony 4th Main Road,\r\nAdambakkam,Chennai-600088\r\n9994182275 / 9884483426\r\nE-mail : periyanayakilogistics@gmail.com','33GYVPS4944G1ZN',2,'','Bank Name  : INDIAN BANK\r\nAccount no  : 8041288275\r\nIFSC             : IDIB000G079\r\nBranch         : G N Chetty Road','AP4909');

/*Table structure for table `configure_bank_details` */

DROP TABLE IF EXISTS `configure_bank_details`;

CREATE TABLE `configure_bank_details` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_blocked` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `configure_bank_details` */

insert  into `configure_bank_details`(`id`,`name`,`is_blocked`) values 
(1,'SBI BANK',0),
(2,'CANARA BANK',0),
(3,'AXIS BANK',0),
(4,'IOB BANK',0);

/*Table structure for table `configure_payment_type` */

DROP TABLE IF EXISTS `configure_payment_type`;

CREATE TABLE `configure_payment_type` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_blocked` int unsigned NOT NULL DEFAULT '0',
  `type_id` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `configure_payment_type` */

insert  into `configure_payment_type`(`id`,`name`,`is_blocked`,`type_id`) values 
(1,'Cash',0,1),
(2,'BANK',0,2);

/*Table structure for table `credit_days` */

DROP TABLE IF EXISTS `credit_days`;

CREATE TABLE `credit_days` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `credit_days` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `credit_days` */

insert  into `credit_days`(`id`,`credit_days`) values 
(1,10);

/*Table structure for table `customer_account` */

DROP TABLE IF EXISTS `customer_account`;

CREATE TABLE `customer_account` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `advance` decimal(10,2) NOT NULL DEFAULT '0.00',
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_id` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `customer_account` */

insert  into `customer_account`(`id`,`customer_id`,`advance`,`balance`) values 
(1,4,0.00,0.00),
(2,5,0.00,0.00),
(3,6,0.00,0.00),
(4,7,0.00,0.00),
(5,8,0.00,0.00),
(6,9,0.00,0.00),
(7,10,0.00,0.00),
(8,11,0.00,0.00),
(9,12,0.00,0.00),
(10,13,0.00,0.00),
(11,14,0.00,0.00),
(12,15,0.00,0.00),
(13,16,0.00,0.00),
(14,17,0.00,0.00),
(15,18,0.00,0.00),
(16,19,0.00,0.00),
(17,20,0.00,0.00),
(18,21,0.00,0.00),
(19,22,0.00,0.00),
(20,23,0.00,0.00),
(21,24,0.00,0.00),
(22,25,0.00,0.00),
(23,26,0.00,0.00),
(24,27,0.00,0.00),
(25,28,0.00,0.00),
(26,29,0.00,0.00);

/*Table structure for table `customers` */

DROP TABLE IF EXISTS `customers`;

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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `customers` */

insert  into `customers`(`id`,`name`,`phone_number`,`address`,`date`,`time`,`is_eligible_for_commission`,`is_active`,`gstin`,`is_gst`,`salesman`,`area`,`credit_limit`,`local`,`exchange_point`) values 
(1,'JASWA VIJAY','9597451419','SFASDFSADDFSD \r\nasgsdg \r\nSFSDDSDDGSDG','2026-06-10','21:47:48',0,1,'2112232wfsfffsd',1,NULL,NULL,0.00,1,0.000),
(2,'jeb','9898989898','','2026-06-10','22:20:38',0,1,'',0,NULL,NULL,0.00,1,0.000),
(3,'cc','','','2026-06-13','11:13:27',0,1,'',0,NULL,NULL,0.00,1,0.000),
(4,'M/s.Tablets India Ltd.,','','No.179, T H Road, Tondiarpet\r\nChennai-600081          ','2026-06-13','13:38:44',0,1,'33AAACT7987L1ZP',1,NULL,NULL,0.00,1,0.000),
(5,'M/s.Subbulakshmi Enterprises, ','','384B, Thamarai Street, Poompozhil Nagar, Avadi,Chennai - 600062','2026-06-15','12:18:46',0,1,'33ACIFS3563J1ZW',1,NULL,NULL,0.00,1,0.000),
(6,'M/s.Crown Worldwide Private Ltd.,','','119/1B1K, Moopanar Street, \r\nPerumattunallur, Pandur Village, \r\nChengalpattu District, Tamilnadu-603202','2026-06-15','12:39:48',0,1,'33AAACC6484D1ZX',1,NULL,NULL,0.00,1,0.000),
(7,'M/s. BES Global Logistics Pvt Ltd.,','','JK Towers No-28, 3rd Floor,\r\n\'\"B\" Wing Bazullah Road,\r\n T.Nagar,Chennai-600017','2026-06-15','13:17:56',0,1,'33AAJCB8783B1ZN',1,NULL,NULL,0.00,1,0.000),
(8,'M/s.Star Worldwide Group Private Ltd.,','','Lokesh Nagar, Old No. 1/10, New No.1/10A1, Tiruverkadu,Periyakoladi Road,Chennai Thiruvallur-600077','2026-06-15','13:46:19',0,1,'33AABCS5979A1ZG',1,NULL,NULL,0.00,1,0.000),
(9,'M/s.Time Medical International Ventures (I) Pvt Ltd.,','','Level-8 Prestige Palladium Bayan,\r\nNo-129-140, Thousand Lights, Greams Road,   \r\nChennai-600006','2026-06-24','19:09:37',0,1,'33AAHCT1130G1ZU',1,NULL,NULL,0.00,1,0.000),
(10,'M/s.Fischer Medical Ventures Ltd.,','','AMTZ Campus, Pragati Maidan,\r\nVM Steel Project S.O, \r\nVisakhapatnam','2026-06-24','19:11:27',0,1,'37AAACF0641D1Z7',1,NULL,NULL,0.00,1,0.000),
(11,'M/s.ALLIANZ BIOSCIENCES PRIVATE LIMITED.,				','','55/1 2 & 3 WHIRLPOOL ROAD, \r\nTHIRUVANDAR KOIL VILLAGE, MANNADIPET COMMUNE,\r\nPONDICHERRY-605102.','2026-06-24','19:12:57',0,1,'37AAACF0641D1Z7',1,NULL,NULL,0.00,1,0.000),
(12,'M/s.Sheng Long Bio-Tech (India) Pvt Ltd.,','','Chennai-601202','2026-06-24','19:13:56',0,1,'33AAVCS2912F1ZB',1,NULL,NULL,0.00,1,0.000),
(13,'M/s.Freyer International Logistics Pvt Ltd.,','','New No-45, Old No-20 TAGA Tower 1st Floor,             \r\nSait Colony 2nd Street, Egmore, \r\nChennai-600008','2026-06-24','19:15:21',0,1,'33AAQCA4076M1Z8',1,NULL,NULL,0.00,1,0.000),
(14,'KV Movers','','77/1 Prakasam Salai\r\nChennai 600108','2026-06-29','20:08:43',0,1,'33AAKFK2907Q2ZX',1,NULL,NULL,0.00,1,0.000),
(15,'Prakash','','','2026-07-02','11:11:29',0,1,'',0,NULL,NULL,0.00,1,0.000),
(16,'SRIRAM','','Chennai','2026-07-02','12:00:07',0,1,'',0,NULL,NULL,0.00,1,0.000),
(17,'UKL INSTRUMENTS PVT LTD','','232, 7th Street, Ashtalakshmi Nagar,  Alapakkam, Chennai -600 116','2026-07-18','14:23:24',0,1,'33AAACU8077E1ZC',1,NULL,NULL,0.00,1,0.000),
(18,'Prakash ','','','2026-08-04','23:27:30',0,1,'',0,NULL,NULL,0.00,1,0.000),
(19,'M/s.Tablets India Limited.,(TN DEPO)','','KVT Garden, Phase-2, Plot No. 5/6/17, VS Mani Street,VS Mani Nagar,100 Feet Road, Madavaram,Chennai-600060','2026-08-05','08:17:23',0,1,'33AAACT7987L1ZP',1,NULL,NULL,0.00,1,0.000),
(20,'VAPCO ENGINEERS PVT. LTD.,','','A-1108,Mahavir Icon,Plot No. 89,\r\nSector -15, Cbd Belapur,Navi Mumbai-400614','2026-08-07','12:12:26',0,1,'27AADCV3809N1ZW',1,NULL,NULL,0.00,1,0.000),
(21,'M/S.FREIGHT SYSTEMS INDIA PRIVATE LIMITED.,','','NO.10, VEERAPURAM VILLAGE, 1ST AVENUE, MAHINDRA WORLD CITY, CHENGALPET,\r\nKanchipuram, Tamil Nadu, 603002','2026-08-10','11:34:43',0,1,'33AAACF0677K1ZO',1,NULL,NULL,0.00,1,0.000),
(22,'M/S.FSL Interem Relocations India Pvt Ltd .,','','P-10, 1st Avenue, Mahindira World City\r\nChengalpet Dist-603004','2026-08-10','11:37:24',0,1,'33AACCF5968K1ZA',1,NULL,NULL,0.00,1,0.000),
(23,'M/S.UWS ENVIRO - TECH PVT. LTD.,','','Shop No. 342, 3rd Floor, Heuu Industrial Spaces, Plot No. 19/c, MIDC Chinchwad, Pune-411019','2026-08-12','11:00:25',0,1,'27AACCU2022P1Z7',1,NULL,NULL,0.00,1,0.000),
(24,'M/S.TABLETS (INDIA) LIMITED - Aquatic Feed Division ','','555/30,Thiruvottiyur High Road,Tondiarpet,Chennai-600081','2026-09-19','21:01:25',0,1,'33AAACT7987L4ZM',1,NULL,NULL,0.00,1,0.000),
(25,'M/S.APEX ECOTECH LIMITED(Formerly Apex Ecotech Private)','','Office No-202,Garden Plaza,Five Gardens Rd,\r\nSunshine Villas,Rahatani,Pune-411017','2026-09-21','13:32:47',0,1,'27AAHCA6649M1Z3',1,NULL,NULL,0.00,1,0.000),
(26,'M/S.FLYNNCARE HEALTH INNOVATIONS PRIVATE LIMITED.,','','8th Floor, No.43/1, Door No.129 to 140,Greams Road, Chennai – 600006','2026-09-21','13:45:57',0,1,'33AAGCF0182R1ZC',1,NULL,NULL,0.00,1,0.000),
(27,'SBS WATER & INFRA PROJECTS PVT LTD.,','','Gat No.49, Opposite To Bharat Weight Bridge,Dehu-Alandi,Talwade, Pin -411062','2026-09-22','10:57:29',0,1,'27ABCCS8531L1ZX',1,NULL,NULL,0.00,1,0.000),
(28,'WOG TECHNOLOGIES LIMITED,','','Unit No. 204, Second Floor,Kirti Deep Building, Plot No. 3 DDA,Nangal Raya, South West Delhi -110046','2026-10-06','09:45:11',0,1,'07AABCW0188P1ZT',1,NULL,NULL,0.00,1,0.000),
(29,'M/S.AGRAVARTI PROCESS ENGINEERS PVT. LTD.,','','D-Iii Block, 32/3, Midc,Chinchwad,\r\nPune -411019.','2026-10-15','10:25:26',0,1,'27AAMCA0873A1ZX',1,NULL,NULL,0.00,1,0.000);

/*Table structure for table `customers_exchange_point` */

DROP TABLE IF EXISTS `customers_exchange_point`;

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

/*Data for the table `customers_exchange_point` */

/*Table structure for table `expense_entry` */

DROP TABLE IF EXISTS `expense_entry`;

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

/*Data for the table `expense_entry` */

/*Table structure for table `expense_type` */

DROP TABLE IF EXISTS `expense_type`;

CREATE TABLE `expense_type` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `is_active` int DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `expense_type` */

/*Table structure for table `gstin` */

DROP TABLE IF EXISTS `gstin`;

CREATE TABLE `gstin` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `gstin` varchar(255) NOT NULL,
  `shop_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `gstin` */

/*Table structure for table `heading` */

DROP TABLE IF EXISTS `heading`;

CREATE TABLE `heading` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `head1` varchar(255) DEFAULT NULL,
  `head2` varchar(255) DEFAULT NULL,
  `head3` varchar(255) DEFAULT NULL,
  `active` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `heading` */

insert  into `heading`(`id`,`head1`,`head2`,`head3`,`active`) values 
(1,'Category','Brand','Product',200);

/*Table structure for table `order_tables` */

DROP TABLE IF EXISTS `order_tables`;

CREATE TABLE `order_tables` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_occupied` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `order_tables` */

/*Table structure for table `pro_bill_exchange` */

DROP TABLE IF EXISTS `pro_bill_exchange`;

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

/*Data for the table `pro_bill_exchange` */

/*Table structure for table `prod_batch` */

DROP TABLE IF EXISTS `prod_batch`;

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

/*Data for the table `prod_batch` */

/*Table structure for table `prod_batch_updated` */

DROP TABLE IF EXISTS `prod_batch_updated`;

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

/*Data for the table `prod_batch_updated` */

/*Table structure for table `prod_batch_zero_stock_bill` */

DROP TABLE IF EXISTS `prod_batch_zero_stock_bill`;

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

/*Data for the table `prod_batch_zero_stock_bill` */

/*Table structure for table `prod_bill` */

DROP TABLE IF EXISTS `prod_bill`;

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

/*Data for the table `prod_bill` */

/*Table structure for table `prod_bill_cancel` */

DROP TABLE IF EXISTS `prod_bill_cancel`;

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

/*Data for the table `prod_bill_cancel` */

/*Table structure for table `prod_bill_datechange` */

DROP TABLE IF EXISTS `prod_bill_datechange`;

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

/*Data for the table `prod_bill_datechange` */

/*Table structure for table `prod_bill_details` */

DROP TABLE IF EXISTS `prod_bill_details`;

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

/*Data for the table `prod_bill_details` */

/*Table structure for table `prod_bill_due` */

DROP TABLE IF EXISTS `prod_bill_due`;

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

/*Data for the table `prod_bill_due` */

/*Table structure for table `prod_bill_due_collection` */

DROP TABLE IF EXISTS `prod_bill_due_collection`;

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

/*Data for the table `prod_bill_due_collection` */

/*Table structure for table `prod_bill_payment` */

DROP TABLE IF EXISTS `prod_bill_payment`;

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

/*Data for the table `prod_bill_payment` */

/*Table structure for table `prod_bill_payment_mode` */

DROP TABLE IF EXISTS `prod_bill_payment_mode`;

CREATE TABLE `prod_bill_payment_mode` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `mode` varchar(255) NOT NULL,
  `is_active` int DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `prod_bill_payment_mode` */

insert  into `prod_bill_payment_mode`(`id`,`mode`,`is_active`) values 
(1,'cash',1),
(2,'bank',1),
(3,'mixed',1);

/*Table structure for table `prod_bill_payment_type` */

DROP TABLE IF EXISTS `prod_bill_payment_type`;

CREATE TABLE `prod_bill_payment_type` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `is_active` int DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `prod_bill_payment_type` */

insert  into `prod_bill_payment_type`(`id`,`type`,`is_active`) values 
(0,'CASH',1),
(1,'UPI',1),
(2,'DEBIT CARD',1),
(3,'CREDIT CARD',1),
(4,'NET BANKING',1),
(5,'WALLET',1),
(6,'CHEQUE',1);

/*Table structure for table `prod_bill_payment_type_change` */

DROP TABLE IF EXISTS `prod_bill_payment_type_change`;

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

/*Data for the table `prod_bill_payment_type_change` */

/*Table structure for table `prod_brands` */

DROP TABLE IF EXISTS `prod_brands`;

CREATE TABLE `prod_brands` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `is_active` int DEFAULT '1',
  PRIMARY KEY (`id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `prod_brands` */

insert  into `prod_brands`(`id`,`name`,`date`,`time`,`is_active`) values 
(1,'own','2026-05-14','13:02:30',1);

/*Table structure for table `prod_category` */

DROP TABLE IF EXISTS `prod_category`;

CREATE TABLE `prod_category` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `is_active` int DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `prod_category` */

insert  into `prod_category`(`id`,`name`,`date`,`time`,`is_active`) values 
(1,'Dress','2026-05-14','13:02:23',1),
(2,'Wire','2026-05-23','13:40:32',1);

/*Table structure for table `prod_cheque_allocation` */

DROP TABLE IF EXISTS `prod_cheque_allocation`;

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

/*Data for the table `prod_cheque_allocation` */

/*Table structure for table `prod_cheque_events` */

DROP TABLE IF EXISTS `prod_cheque_events`;

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

/*Data for the table `prod_cheque_events` */

/*Table structure for table `prod_cheque_stock` */

DROP TABLE IF EXISTS `prod_cheque_stock`;

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

/*Data for the table `prod_cheque_stock` */

/*Table structure for table `prod_lifecycle` */

DROP TABLE IF EXISTS `prod_lifecycle`;

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

/*Data for the table `prod_lifecycle` */

/*Table structure for table `prod_order` */

DROP TABLE IF EXISTS `prod_order`;

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

/*Data for the table `prod_order` */

/*Table structure for table `prod_order_details` */

DROP TABLE IF EXISTS `prod_order_details`;

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

/*Data for the table `prod_order_details` */

/*Table structure for table `prod_product` */

DROP TABLE IF EXISTS `prod_product`;

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

/*Data for the table `prod_product` */

insert  into `prod_product`(`id`,`name`,`code`,`category_id`,`brand_id`,`unit_id`,`hsn`,`uid`,`date`,`time`,`is_active`,`gst`) values 
(1,'Denim','102',1,1,1,NULL,1,'2026-06-10','21:46:59',1,12);

/*Table structure for table `prod_product_components` */

DROP TABLE IF EXISTS `prod_product_components`;

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

/*Data for the table `prod_product_components` */

/*Table structure for table `prod_purchase` */

DROP TABLE IF EXISTS `prod_purchase`;

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

/*Data for the table `prod_purchase` */

/*Table structure for table `prod_purchase_counter` */

DROP TABLE IF EXISTS `prod_purchase_counter`;

CREATE TABLE `prod_purchase_counter` (
  `id` int NOT NULL,
  `last_pr_no` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_purchase_counter` */

/*Table structure for table `prod_purchase_details` */

DROP TABLE IF EXISTS `prod_purchase_details`;

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

/*Data for the table `prod_purchase_details` */

/*Table structure for table `prod_purchase_edit_log` */

DROP TABLE IF EXISTS `prod_purchase_edit_log`;

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

/*Data for the table `prod_purchase_edit_log` */

/*Table structure for table `prod_purchase_entry_details_link` */

DROP TABLE IF EXISTS `prod_purchase_entry_details_link`;

CREATE TABLE `prod_purchase_entry_details_link` (
  `id` int NOT NULL AUTO_INCREMENT,
  `link_id` int NOT NULL,
  `po_detail_id` bigint unsigned NOT NULL,
  `pe_detail_id` bigint unsigned NOT NULL,
  `quantity_received` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_purchase_entry_details_link` */

/*Table structure for table `prod_purchase_entry_link` */

DROP TABLE IF EXISTS `prod_purchase_entry_link`;

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

/*Data for the table `prod_purchase_entry_link` */

/*Table structure for table `prod_purchase_order_counter` */

DROP TABLE IF EXISTS `prod_purchase_order_counter`;

CREATE TABLE `prod_purchase_order_counter` (
  `id` int NOT NULL DEFAULT '1',
  `last_po_no` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_purchase_order_counter` */

/*Table structure for table `prod_purchase_request` */

DROP TABLE IF EXISTS `prod_purchase_request`;

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

/*Data for the table `prod_purchase_request` */

/*Table structure for table `prod_purchase_request_counter` */

DROP TABLE IF EXISTS `prod_purchase_request_counter`;

CREATE TABLE `prod_purchase_request_counter` (
  `id` int NOT NULL DEFAULT '1',
  `last_req_no` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_purchase_request_counter` */

/*Table structure for table `prod_purchase_request_details` */

DROP TABLE IF EXISTS `prod_purchase_request_details`;

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

/*Data for the table `prod_purchase_request_details` */

/*Table structure for table `prod_purchase_return` */

DROP TABLE IF EXISTS `prod_purchase_return`;

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

/*Data for the table `prod_purchase_return` */

/*Table structure for table `prod_purchase_return_details` */

DROP TABLE IF EXISTS `prod_purchase_return_details`;

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

/*Data for the table `prod_purchase_return_details` */

/*Table structure for table `prod_purchase_supplier_payment` */

DROP TABLE IF EXISTS `prod_purchase_supplier_payment`;

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

/*Data for the table `prod_purchase_supplier_payment` */

/*Table structure for table `prod_purchase_supplier_payment_details` */

DROP TABLE IF EXISTS `prod_purchase_supplier_payment_details`;

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

/*Data for the table `prod_purchase_supplier_payment_details` */

/*Table structure for table `prod_quotation` */

DROP TABLE IF EXISTS `prod_quotation`;

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

/*Data for the table `prod_quotation` */

/*Table structure for table `prod_quotation_details` */

DROP TABLE IF EXISTS `prod_quotation_details`;

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

/*Data for the table `prod_quotation_details` */

/*Table structure for table `prod_stock_adjustment` */

DROP TABLE IF EXISTS `prod_stock_adjustment`;

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

/*Data for the table `prod_stock_adjustment` */

/*Table structure for table `prod_stock_totals` */

DROP TABLE IF EXISTS `prod_stock_totals`;

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

/*Data for the table `prod_stock_totals` */

/*Table structure for table `prod_supplier` */

DROP TABLE IF EXISTS `prod_supplier`;

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
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;

/*Data for the table `prod_supplier` */

insert  into `prod_supplier`(`id`,`name`,`phone_number`,`description`,`date`,`time`,`is_active`,`gstin`,`is_gst`) values 
(1,'On call Ramesh','9841876076','Chennai','2026-05-14','13:03:13',1,NULL,0),
(2,'Shree Bhairavar Transport','9363040666','Chennai.','2026-06-11','16:23:03',1,NULL,0),
(3,'Shree Jayam Transport','8807224599','Chennai.','2026-06-13','11:11:55',1,NULL,0),
(4,'Rajalakshmi Transport','9962163483','Chennai.','2026-06-13','11:16:30',1,NULL,0),
(5,'Raju Transport','9841098222','Chennai.','2026-06-13','13:37:41',1,NULL,0),
(6,'SR Transport','9841496208','Madavarm','2026-06-15','12:09:09',1,NULL,0),
(7,'Periyapalayathamman Transport','9500070474','Poonamalle','2026-06-15','12:36:12',1,NULL,0),
(8,'SREE MANJUNATHA TRANSPORT','9840561132','Chennai','2026-06-15','13:15:14',1,NULL,0),
(9,'Mathi transport','9884129002','Madavarm','2026-06-15','13:41:25',1,NULL,0),
(10,'Sri Murugan Lorry Service','7200060103','Chennai','2026-06-24','19:18:39',1,NULL,0),
(11,'Sri Murugan Roadlines','9444505152','Chennai','2026-06-24','19:19:03',1,NULL,0),
(12,'Annai Meenakshi Transport','9841627049','Chennai','2026-06-24','19:19:31',1,NULL,0),
(13,'Annai Mahalakshmi Transport','9840969642','Chennai','2026-06-24','19:20:10',1,NULL,0),
(14,'Sri Mahalakshmi Lorry Suppliers','9043631110','Chennai','2026-06-24','19:20:45',1,NULL,0),
(15,'Popular Goods Transport','7200004605','Chennai','2026-06-24','19:21:23',1,NULL,0),
(16,'National Mini Transport','9791105988','Chennai','2026-06-24','19:22:17',1,NULL,0),
(17,'Hercules Transport','9884319093','Chennai','2026-06-24','19:22:57',1,NULL,0),
(18,'Mohan Roadways','9840085870','Chennai','2026-06-24','19:23:19',1,NULL,0),
(19,'Chandran Road Carrier','9176018416','Chennai','2026-06-24','19:24:18',1,NULL,0),
(20,'Friends Roadlines','9383882006','Chennai','2026-06-24','19:27:12',1,NULL,0),
(21,'GVS Transport','9940237190','Chennai','2026-06-24','19:31:43',1,NULL,0),
(22,'Ayyanar Transport','7010662027','Pondy','2026-06-24','20:08:47',1,NULL,0),
(23,'Madavaram 20 feet','','Chennai','2026-06-25','19:18:01',1,NULL,0),
(24,'Sai Dhinesh Roadways','9543975757','Chennai','2026-06-25','21:16:06',1,NULL,0),
(25,'Ranjani Transport','9677194515','Chennai','2026-06-25','21:17:15',1,NULL,0),
(26,'RR Roadways','9940417944','Chennai','2026-06-26','19:19:34',1,NULL,0),
(27,'Santhi Narayan Road Transport','9940116614','Chennai','2026-06-26','19:40:13',1,NULL,0),
(28,'Maruthy Transport','7868021671','Pondy','2026-06-26','20:08:07',1,NULL,0),
(29,'New Super Roadways','9626434301','Chennai','2026-06-29','19:57:41',1,NULL,0),
(30,'Annai Velankanni Roadways','9786211799','Chennai','2026-06-29','20:00:30',1,NULL,0),
(31,'SSK Transport-Pondy','7010662027','Pondy','2026-06-29','20:02:33',1,NULL,0),
(32,'Jeelani Roadways','','Chennai','2026-07-02','12:06:30',1,NULL,0),
(33,'Santhakumar','','Pondy','2026-07-04','21:50:32',1,NULL,0),
(34,'Vetri Vinayaga Transport','9841487615','Chennai','2026-07-18','18:58:38',1,NULL,0),
(35,'Super fast Cargo','9382857007','Sholavaranm','2026-07-28','10:07:31',1,NULL,0),
(36,'Balaji Transport','','Kolkata','2026-07-31','21:20:16',1,NULL,0),
(37,'Subh Cargo Carrier','','Chennai','2026-07-31','21:28:01',1,NULL,0),
(38,'Vinayaka Container Service','','','2026-08-06','08:50:00',1,NULL,0),
(39,'On call Naresh','','Vizag','2026-08-28','20:11:16',1,NULL,0),
(40,'Mumbai - Munaji','8080814284','','2026-09-21','13:25:34',1,NULL,0),
(41,'Manju Roadways','','Chennai','2026-10-08','18:00:33',1,NULL,0),
(42,'Velu','','','2026-10-27','13:33:25',1,NULL,0),
(43,'New India Translines','','Mumbai','2026-10-29','09:52:05',1,NULL,0);

/*Table structure for table `prod_supplier_cheque_allocation` */

DROP TABLE IF EXISTS `prod_supplier_cheque_allocation`;

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

/*Data for the table `prod_supplier_cheque_allocation` */

/*Table structure for table `prod_supplier_cheque_events` */

DROP TABLE IF EXISTS `prod_supplier_cheque_events`;

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

/*Data for the table `prod_supplier_cheque_events` */

/*Table structure for table `prod_supplier_cheque_stock` */

DROP TABLE IF EXISTS `prod_supplier_cheque_stock`;

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

/*Data for the table `prod_supplier_cheque_stock` */

/*Table structure for table `prod_units` */

DROP TABLE IF EXISTS `prod_units`;

CREATE TABLE `prod_units` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `convertion_unit` varchar(255) DEFAULT NULL,
  `convertion_calculation` decimal(10,2) DEFAULT NULL,
  `is_active` int DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `prod_units` */

insert  into `prod_units`(`id`,`name`,`convertion_unit`,`convertion_calculation`,`is_active`) values 
(1,'NOS',NULL,NULL,1),
(2,'Gram',NULL,NULL,1),
(3,'KG',NULL,NULL,1),
(4,'Meter',NULL,NULL,1),
(5,'length','Feet',20.00,1);

/*Table structure for table `sales_area` */

DROP TABLE IF EXISTS `sales_area`;

CREATE TABLE `sales_area` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_active` int DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `sales_area` */

/*Table structure for table `sales_man` */

DROP TABLE IF EXISTS `sales_man`;

CREATE TABLE `sales_man` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_active` int DEFAULT '1',
  `created_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `sales_man` */

/*Table structure for table `special_permission` */

DROP TABLE IF EXISTS `special_permission`;

CREATE TABLE `special_permission` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `content` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `special_permission` */

insert  into `special_permission`(`id`,`content`) values 
(1,'allow to Zero stock billing ');

/*Table structure for table `transport_bill` */

DROP TABLE IF EXISTS `transport_bill`;

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
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `transport_bill` */

insert  into `transport_bill`(`id`,`invoice_no`,`bill_date`,`customer_id`,`po_no`,`sac_code`,`grand_total`,`paid_amount`,`balance`,`payment_mode`,`payment_type`,`credit_days`,`due_date`,`is_cancelled`,`cancel_uid`,`cancel_date_time`,`entry_user`,`entry_date`) values 
(1,'123-2026/27','2026-06-23',6,'2604-00373','996791',6000,0,6000,'Cash',1,'30 Days',NULL,0,NULL,NULL,25,'2026-06-23 19:28:50'),
(2,'124-2026/27','2026-06-25',12,NULL,'996791',3500,0,3500,'Cash',1,'Immediate',NULL,0,NULL,NULL,25,'2026-06-25 19:23:09'),
(3,'125-2026/27','2026-06-30',14,NULL,'996791',9000,0,9000,'Bank/UPI',2,'15 Days Only.',NULL,0,NULL,NULL,25,'2026-07-02 11:06:42'),
(4,'126-2026/27','2026-06-30',6,'2606-02687','996791',6000,0,6000,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-07-02 12:16:46'),
(5,'127-2026/27','2026-07-02',9,NULL,'996791',98000,0,98000,'Bank/UPI',2,'Immediate',NULL,1,25,'2026-07-02 12:27:10',25,'2026-07-02 12:26:06'),
(6,'128-2026/27','2026-07-02',9,NULL,'996791',98000,0,98000,'Cash',1,'Immediate',NULL,0,NULL,NULL,25,'2026-07-02 12:29:44'),
(7,'129-2026/27','2026-07-03',13,NULL,'996791',85000,0,85000,'Bank/UPI',2,'30  Days Only',NULL,0,NULL,NULL,25,'2026-07-03 15:44:50'),
(8,'130-2026/27','2026-07-03',7,NULL,'996791',80000,0,80000,'Bank/UPI',2,'15 Days Only.',NULL,0,NULL,NULL,25,'2026-07-03 15:48:03'),
(9,'131-2026/27','2026-07-05',5,NULL,'996791',37850,0,37850,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-05 14:17:27'),
(10,'132-2026/27','2026-07-05',5,NULL,'996791',31100,0,31100,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-05 14:17:52'),
(11,'133-2026/27','2026-07-05',5,NULL,'996791',12820,0,12820,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-05 14:18:34'),
(12,'134-2026/27','2026-07-05',5,NULL,'996791',25100,0,25100,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-05 14:18:59'),
(13,'135-2026/27','2026-07-05',5,NULL,'996791',35100,0,35100,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-05 14:19:20'),
(14,'136-2026/27','2026-07-05',5,NULL,'996791',16208,0,16208,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-05 14:19:50'),
(15,'137-2026/27','2026-07-05',5,NULL,'996791',20809,0,20809,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-05 14:20:13'),
(16,'138-2026/27','2026-07-05',5,NULL,'996791',6100,0,6100,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-05 14:21:13'),
(17,'139-2026/27','2026-07-05',5,NULL,'996791',14358,0,14358,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-05 14:21:41'),
(18,'140-2026/27','2026-07-05',5,NULL,'996791',1000,0,1000,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-05 14:24:27'),
(19,'141-2026/27','2026-07-05',5,NULL,'996791',1000,0,1000,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-05 14:24:44'),
(20,'142-2026/27','2026-07-10',12,NULL,'996791',8000,0,8000,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-07-10 19:04:52'),
(21,'143-2026/27','2026-07-10',4,NULL,'996791',258198,0,258198,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-07-10 19:41:29'),
(22,'144-2026/27','2026-07-10',4,NULL,'996791',17550,0,17550,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-07-10 19:56:45'),
(23,'145-2026/27','2026-07-10',4,NULL,'996791',12550,0,12550,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-07-10 20:09:19'),
(24,'146-2026/27','2026-07-12',4,'TN DEPO','996791',94915,0,94915,'Bank/UPI',2,'30  Days',NULL,0,NULL,NULL,25,'2026-07-12 19:08:36'),
(25,'147-2026/27','2026-07-16',4,'FG STORES','996791',16600,0,16600,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-07-16 12:15:16'),
(26,'148-2026/27','2026-07-18',17,NULL,'996791',21600,0,21600,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-07-18 19:05:03'),
(27,'149-2026/27','2026-07-18',17,NULL,'996791',34100,0,34100,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-07-18 19:07:43'),
(28,'150-2026/27','2026-07-18',5,NULL,'996791',11050,0,11050,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-24 10:48:06'),
(29,'151-2026/27','2026-07-18',5,NULL,'996791',14298,0,14298,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-24 10:49:41'),
(30,'152-2026/27','2026-07-18',5,NULL,'996791',11300,0,11300,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-24 10:50:08'),
(31,'153-2026/27','2026-07-18',5,NULL,'996791',18144,0,18144,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-24 10:51:21'),
(32,'154-2026/27','2026-07-18',5,NULL,'996791',18143,0,18143,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-24 10:51:45'),
(33,'155-2026/27','2026-07-18',5,NULL,'996791',12540,0,12540,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-24 10:52:11'),
(34,'156-2026/27','2026-07-18',5,NULL,'996791',17650,0,17650,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-07-24 10:52:43'),
(35,'157-2026/27','2026-07-24',14,NULL,'996791',9000,0,9000,'Bank/UPI',2,'15 Days',NULL,0,NULL,NULL,25,'2026-07-24 11:00:44'),
(36,'158-2026/27','2026-07-28',17,NULL,'996791',77100,0,77100,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-07-28 10:18:52'),
(37,'159-2026/27','2026-07-28',6,'2504-02438-05','996791',43500,0,43500,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-07-28 10:24:32'),
(38,'160-2026/27','2026-07-28',6,'2604-02764','996791',7500,0,7500,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-07-28 10:28:04'),
(39,'161-2026/27','2026-07-28',6,'2607-00651','996791',6000,0,6000,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-07-28 10:31:01'),
(40,'162-2026/27','2026-07-31',12,NULL,'996791',6000,0,6000,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-07-31 22:00:46'),
(41,'163-2026/27','2026-07-31',15,NULL,'996791',10000,0,10000,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-08-04 23:29:54'),
(42,'164-2026/27','2026-07-31',15,NULL,'996791',10000,0,10000,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-08-04 23:30:19'),
(43,'165-2026/27','2026-08-05',4,NULL,'996791',127506,0,127506,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-08-05 08:43:16'),
(44,'166-2026/27','2026-08-05',19,NULL,'996791',70530,0,70530,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-08-05 08:58:40'),
(45,'167-2026/27','2026-08-05',4,'RM STORE','996791',16100,0,16100,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-08-05 09:08:20'),
(46,'168-2026/27','2026-08-05',4,NULL,'996791',2500,0,2500,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-08-05 09:13:30'),
(47,'169-2026/27','2026-08-05',4,NULL,'996791',12600,0,12600,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-08-06 08:40:52'),
(48,'170-2026/27','2026-08-05',5,NULL,'996791',8100,0,8100,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-08-06 08:42:38'),
(49,'171-2026/27','2026-08-05',5,NULL,'996791',9300,0,9300,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-08-06 08:43:08'),
(50,'172-2026/27','2026-08-05',5,NULL,'996791',29900,0,29900,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-08-06 08:43:33'),
(51,'173-2026/27','2026-08-05',5,NULL,'996791',12780,0,12780,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-08-06 08:43:55'),
(52,'174-2026/27','2026-08-05',5,NULL,'996791',13350,0,13350,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-08-06 08:44:30'),
(53,'175-2026/27','2026-08-05',5,NULL,'996791',11789,0,11789,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-08-06 08:44:56'),
(54,'176-2026/27','2026-08-05',5,NULL,'996791',10500,0,10500,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-08-06 08:45:17'),
(55,'177-2026/27','2026-08-05',5,NULL,'996791',15700,0,15700,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-08-06 08:45:37'),
(56,'178-2026/27','2026-08-05',5,NULL,'996791',29320,0,29320,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-08-06 08:45:56'),
(57,'179-2026/27','2026-08-06',17,NULL,'996791',77100,0,77100,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-08-06 08:56:01'),
(58,'180-2026/27','2026-08-06',17,NULL,'996791',35100,0,35100,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-08-06 08:58:05'),
(59,'181-2026/27','2026-08-06',9,NULL,'996791',220000,0,220000,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-08-06 12:11:34'),
(60,'182-2026/27','2026-08-07',20,NULL,'996791',44200,0,44200,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-08-07 12:16:33'),
(61,'183-2026/27','2026-08-10',22,NULL,'996791',13050,0,13050,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-08-10 12:00:00'),
(62,'184-2026/27','2026-08-10',21,NULL,'996791',26050,0,26050,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-08-10 12:02:37'),
(63,'185-2026/27','2026-08-11',17,NULL,'996791',80200,0,80200,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-08-11 08:56:20'),
(64,'186-2026/27','2026-08-11',17,NULL,'996791',60100,0,60100,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-08-11 08:59:41'),
(65,'187-2026/27','2026-08-11',17,NULL,'996791',34100,0,34100,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-08-11 09:01:26'),
(66,'188-2026/27','2026-08-11',17,NULL,'996791',36200,0,36200,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-08-11 09:04:00'),
(67,'189-2026/27','2026-08-12',23,NULL,'996791',38000,0,38000,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-08-12 11:04:49'),
(68,'190-2026/27','2026-08-13',12,NULL,'996791',7000,0,7000,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-08-13 19:51:27'),
(69,'191-2026/27','2026-08-13',12,NULL,'996791',5000,0,5000,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-08-13 19:53:04'),
(70,'192-2026/27','2026-08-18',13,NULL,'996791',85000,0,85000,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-08-18 10:50:09'),
(71,'193-2026/27','2026-08-18',6,'2504-02438-10','996791',7000,0,7000,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-08-18 11:01:26'),
(72,'194-2026/27','2026-08-28',17,NULL,'996791',46100,0,46100,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-08-28 13:23:55'),
(73,'195-2026/27','2026-08-28',17,NULL,'996791',21200,0,21200,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-08-28 13:28:04'),
(74,'196-2026/27','2026-08-28',9,NULL,'996791',442000,0,442000,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-08-28 20:17:00'),
(75,'197-2026/27','2026-08-31',15,NULL,'996791',1000,0,1000,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-09-04 12:37:11'),
(76,'198-2026/27','2026-08-31',15,NULL,'996791',1000,0,1000,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-09-04 12:39:04'),
(77,'199-2026/27','2026-09-04',5,NULL,'996791',11100,0,11100,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-09-04 12:45:46'),
(78,'200-2026/27','2026-09-04',5,NULL,'996791',11500,0,11500,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-09-04 12:46:09'),
(79,'201-2026/27','2026-09-04',5,NULL,'996791',16098,0,16098,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-09-04 12:46:29'),
(80,'202-2026/27','2026-09-04',5,NULL,'996791',19440,0,19440,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-09-04 12:46:54'),
(81,'203-2026/27','2026-09-04',5,NULL,'996791',12860,0,12860,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-09-04 12:47:15'),
(82,'204-2026/27','2026-09-04',5,NULL,'996791',18704,0,18704,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-09-04 12:47:35'),
(83,'205-2026/27','2026-09-04',5,NULL,'996791',9100,0,9100,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-09-04 12:47:52'),
(84,'206-2026/27','2026-09-04',5,NULL,'996791',19017,0,19017,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-09-04 12:48:12'),
(85,'207-2026/27','2026-09-04',5,NULL,'996791',22970,0,22970,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-09-04 12:49:38'),
(86,'208-2026/27','2026-09-04',5,NULL,'996791',10100,0,10100,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-09-04 12:49:58'),
(87,'209-2026/27','2026-09-04',5,NULL,'996791',11830,0,11830,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-09-04 12:51:37'),
(88,'210-2026/27','2026-09-04',5,NULL,'996791',15853,0,15853,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-09-04 12:52:22'),
(89,'211-2026/27','2026-09-04',8,'102491202','996791',28000,0,28000,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-09-04 13:10:08'),
(90,'212-2026/27','2026-09-07',17,NULL,'996791',72200,0,72200,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-09-07 20:17:00'),
(91,'213-2026/27','2026-09-07',17,NULL,'996791',32100,0,32100,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-09-07 20:20:22'),
(92,'214-2026/27','2026-09-07',17,NULL,'996791',19100,0,19100,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-09-07 20:22:12'),
(93,'215-2026/27','2026-09-07',17,NULL,'996791',32100,0,32100,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-09-07 20:24:23'),
(94,'216-2026/27','2026-09-10',19,'TN DEPO','996791',26160,0,26160,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-09-10 18:43:20'),
(95,'217-2026/27','2026-09-10',4,'RM STORE','996791',30750,0,30750,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-09-10 18:55:07'),
(96,'218-2026/27','2026-09-10',4,'IMPORT/EXPORT','996791',9500,0,9500,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-09-10 19:08:14'),
(97,'219-2026/27','2026-09-10',4,NULL,'996791',229521,0,229521,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-09-10 19:34:05'),
(98,'220-2026/27','2026-09-21',25,NULL,'996791',20000,0,20000,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-09-21 13:35:13'),
(99,'221-2026/27','2026-09-21',17,NULL,'996791',57100,0,57100,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-09-21 13:39:47'),
(100,'222-2026/27','2026-09-21',17,NULL,'996791',57200,0,57200,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-09-21 13:42:15'),
(101,'223-2026/27','2026-09-21',26,NULL,'996791',8500,0,8500,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-09-21 13:48:40'),
(102,'224-2026/27','2026-09-21',6,'2505-03709-08','996791',17000,0,17000,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-09-21 13:59:57'),
(103,'225-2026/27','2026-09-21',6,'2609-00912','996791',16000,0,16000,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-09-21 14:02:51'),
(104,'226-2026/27','2026-09-21',6,'2607-01135','996791',4000,0,4000,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-09-21 14:05:51'),
(105,'227-2026/27','2026-09-21',6,'2607-00645','996791',6000,0,6000,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-09-21 14:12:26'),
(106,'228-2026/27','2026-09-22',27,NULL,'996791',20000,0,20000,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-09-22 11:00:24'),
(107,'229-2026/27','2026-09-28',21,NULL,'996791',10500,0,10500,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-09-28 13:08:31'),
(108,'230-2026/27','2026-09-30',6,'2505-03709-08','996791',28000,0,28000,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-10-04 19:41:04'),
(109,'231-2026/27','2026-09-30',6,'2604-01910','996791',7500,0,7500,'Cash',1,'30 Days',NULL,0,NULL,NULL,25,'2026-10-04 19:46:31'),
(110,'232-2026/27','2026-09-30',14,NULL,'996791',9000,0,9000,'Bank/UPI',2,'15 Days',NULL,0,NULL,NULL,25,'2026-10-04 19:54:12'),
(111,'233-2026/27','2026-09-30',15,NULL,'996791',10000,0,10000,'Cash',1,NULL,NULL,0,NULL,NULL,25,'2026-10-04 19:58:59'),
(112,'234-2026/27','2026-09-30',15,NULL,'996791',10000,0,10000,'Cash',1,NULL,NULL,0,NULL,NULL,25,'2026-10-04 19:59:19'),
(113,'235-2026/27','2026-10-04',14,NULL,'996791',9500,0,9500,'Bank/UPI',2,'15 Days',NULL,0,NULL,NULL,25,'2026-10-04 20:51:48'),
(114,'236-2026/27','2026-10-05',28,NULL,'996791',12000,0,12000,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-10-06 09:47:52'),
(115,'237-2026/27','2026-10-05',5,NULL,'996791',5000,0,5000,'Cash',1,NULL,NULL,0,NULL,NULL,25,'2026-10-07 19:55:55'),
(116,'238-2026/27','2026-10-05',5,NULL,'996791',15477,0,15477,'Cash',1,NULL,NULL,0,NULL,NULL,25,'2026-10-07 19:56:15'),
(117,'239-2026/27','2026-10-05',5,NULL,'996791',11100,0,11100,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-10-07 19:56:43'),
(118,'240-2026/27','2026-10-05',5,NULL,'996791',13828,0,13828,'Cash',1,NULL,NULL,0,NULL,NULL,25,'2026-10-07 19:57:05'),
(119,'241-2026/27','2026-10-05',5,NULL,'996791',11630,0,11630,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-10-07 19:57:23'),
(120,'242-2026/27','2026-10-05',5,NULL,'996791',13576,0,13576,'Cash',1,NULL,NULL,0,NULL,NULL,25,'2026-10-07 19:57:40'),
(121,'243-2026/27','2026-10-05',5,NULL,'996791',11234,0,11234,'Cash',1,NULL,NULL,0,NULL,NULL,25,'2026-10-07 19:58:02'),
(122,'244-2026/27','2026-10-05',5,NULL,'996791',18989,0,18989,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-10-07 19:58:28'),
(123,'245-2026/27','2026-10-05',5,NULL,'996791',12100,0,12100,'Cash',1,NULL,NULL,0,NULL,NULL,25,'2026-10-07 19:58:44'),
(124,'246-2026/27','2026-10-05',5,NULL,'996791',13165,0,13165,'Cash',1,NULL,NULL,0,NULL,NULL,25,'2026-10-07 19:59:05'),
(125,'247-2026/27','2026-10-05',5,NULL,'996791',12100,0,12100,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-10-07 19:59:31'),
(126,'248-2026/27','2026-10-05',5,NULL,'996791',12100,0,12100,'Cash',1,NULL,NULL,0,NULL,NULL,25,'2026-10-07 19:59:51'),
(127,'249-2026/27','2026-10-05',5,NULL,'996791',22120,0,22120,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-10-07 20:00:10'),
(128,'250-2026/27','2026-10-05',5,NULL,'996791',15854,0,15854,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-10-07 20:00:29'),
(129,'251-2026/27','2026-10-05',5,NULL,'996791',32735,0,32735,'Bank/UPI',2,NULL,NULL,0,NULL,NULL,25,'2026-10-07 20:00:50'),
(130,'252-2026/27','2026-10-06',17,NULL,'996791',31100,0,31100,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-10-07 20:09:51'),
(131,'253-2026/27','2026-10-06',9,NULL,'996791',82000,0,82000,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-10-07 20:14:16'),
(132,'254-2026/27','2026-10-08',24,'Aquatic Feed Division','996791',52270,0,52270,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-10-08 18:43:38'),
(133,'255-2026/27','2026-10-08',24,'TN DEPO','996791',16400,0,16400,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-10-08 18:51:55'),
(134,'256-2026/27','2026-10-08',4,NULL,'996791',8600,0,8600,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-10-08 19:07:08'),
(135,'257-2026/27','2026-10-08',24,NULL,'996791',4550,0,4550,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-10-08 19:09:56'),
(136,'258-2026/27','2026-10-08',4,'IMPORT/EXPORT','996791',20100,0,20100,'Bank/UPI',2,'30 Days',NULL,1,25,'2026-10-23 00:03:21',25,'2026-10-08 19:19:41'),
(137,'259-2026/27','2026-10-08',4,'FG STORE','996791',68447,0,68447,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-10-08 19:35:33'),
(138,'260-2026/27','2026-10-08',4,'RM STORE','996791',12100,0,12100,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-10-08 19:40:01'),
(139,'261-2026/27','2026-10-13',6,'2604-01910','996791',7500,0,7500,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-10-13 09:53:21'),
(140,'262-2026/27','2026-10-13',6,'2609-03449-02','996791',72000,0,72000,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-10-13 09:57:26'),
(141,'263-2026/27','2026-10-13',6,'2505-03709-08','996791',6000,0,6000,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-10-13 10:00:01'),
(142,'264-2026/27','2026-10-13',12,NULL,'996791',8000,0,8000,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-10-13 10:12:05'),
(143,'265-2026/27','2026-10-15',22,NULL,'996791',51000,0,51000,'Bank/UPI',2,'15 Days',NULL,0,NULL,NULL,25,'2026-10-15 10:19:57'),
(144,'266-2026/27','2026-10-15',22,NULL,'996791',16000,0,16000,'Bank/UPI',2,'15 Days',NULL,0,NULL,NULL,25,'2026-10-15 10:21:58'),
(145,'267-2026/27','2026-10-15',29,NULL,'996791',38000,0,38000,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-10-15 10:27:33'),
(146,'268-2026/27','2026-10-22',4,'IMPORT/EXPORT','996791',10050,0,10050,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-10-23 00:07:03'),
(147,'269-2026/27','2026-10-22',4,'IMPORT - Oragadam Factory','996791',10050,0,10050,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-10-23 00:09:40'),
(148,'270-2026/27','2026-10-22',17,NULL,'996791',76200,0,76200,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-10-23 00:43:22'),
(149,'271-2026/27','2026-10-22',17,NULL,'996791',38100,0,38100,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-10-23 00:46:38'),
(150,'272-2026/27','2026-10-22',17,NULL,'996791',53100,0,53100,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-10-23 00:50:20'),
(151,'273-2026/27','2026-10-26',6,'2602-00824','996791',15500,0,15500,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-10-27 13:39:06'),
(152,'274-2026/27','2026-10-26',6,'2610-01108','996791',4500,0,4500,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-10-27 13:42:46'),
(153,'275-2026/27','2026-10-26',12,NULL,'996791',8500,0,8500,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-10-27 13:47:17'),
(154,'276-2026/27','2026-10-28',17,NULL,'996791',57100,0,57100,'Bank/UPI',2,'Immediate',NULL,0,NULL,NULL,25,'2026-10-29 09:56:14'),
(155,'277-2026/27','2026-10-29',13,NULL,'996791',150000,0,150000,'Bank/UPI',2,'30 Days',NULL,0,NULL,NULL,25,'2026-10-29 12:59:54'),
(156,'278-2026/27','2026-10-29',7,NULL,'996791',130000,0,130000,'Bank/UPI',2,'15 Days',NULL,0,NULL,NULL,25,'2026-10-29 13:03:18'),
(157,'279-2026/27','2026-11-04',1,'qq','996791',300,200,100,'Cash',1,'1','2026-11-05',1,1,'2026-11-04 11:06:26',1,'2026-11-04 11:05:57'),
(158,'280-2026/27','2026-11-04',1,NULL,'996791',400,0,400,'Cash',1,NULL,NULL,0,NULL,NULL,1,'2026-11-04 11:07:30');

/*Table structure for table `transport_bill_balance` */

DROP TABLE IF EXISTS `transport_bill_balance`;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `transport_bill_balance` */

insert  into `transport_bill_balance`(`id`,`bill_id`,`balance_amount`,`due_date`,`collected_amount`,`collected_date`,`collected_mode`,`is_collected`,`notes`,`entry_date`) values 
(1,157,100,'2026-11-05',0,NULL,NULL,0,NULL,'2026-11-04 11:05:57');

/*Table structure for table `transport_bill_details` */

DROP TABLE IF EXISTS `transport_bill_details`;

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
) ENGINE=InnoDB AUTO_INCREMENT=1245 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `transport_bill_details` */

insert  into `transport_bill_details`(`id`,`bill_id`,`bill_lr_id`,`logistics_id`,`lr_no`,`lr_date`,`particular`,`qty`,`rate_wt`,`amount`,`sort_order`) values 
(22,1,1,1,'         -',NULL,'Used Household Goods','As per ','F T L',6000,1),
(23,1,1,1,NULL,NULL,'','','',0,2),
(24,1,1,1,NULL,NULL,'Chennai local ','','',0,3),
(25,1,1,1,NULL,NULL,'','','',0,4),
(26,1,1,1,NULL,NULL,'20 feet closed Container','','',0,5),
(27,1,1,1,NULL,NULL,'','','',0,6),
(28,1,1,1,NULL,NULL,'A/c.JOSHUA CANNON','','',0,7),
(29,2,2,19,'            -','2026-06-25','Aqua Products','05','F T L',3500,1),
(30,2,2,19,NULL,NULL,'','','',0,2),
(31,2,2,19,NULL,NULL,'Tondiarpet to Gummidipoondi','','',0,3),
(32,2,2,19,NULL,NULL,'','','',0,4),
(33,2,2,19,NULL,NULL,'Container No. TN03AE5173','','',0,5),
(34,3,3,52,'          -','2026-07-29','Used Household Goods','09','F T L',9000,1),
(35,3,3,52,NULL,NULL,'','','',0,2),
(36,3,3,52,NULL,NULL,'Chennai to Bangalore','','',0,3),
(37,3,3,52,NULL,NULL,'','','',0,4),
(38,3,3,52,NULL,NULL,'Container No. TN73AH7796','','',0,5),
(39,3,3,52,NULL,NULL,'','','',0,6),
(40,3,3,52,NULL,NULL,'A/c.Mr.Devaraj Pannerselvam','','',0,7),
(41,4,4,57,'           -','2026-06-30','Used Household Goods','Asper List','F T L',6000,1),
(42,4,4,57,NULL,NULL,'','','',0,2),
(43,4,4,57,NULL,NULL,'Chennai local Transportation','','',0,3),
(44,4,4,57,NULL,NULL,'','','',0,4),
(45,4,4,57,NULL,NULL,'20 feet Closed Container','','',0,5),
(46,4,4,57,NULL,NULL,'','','',0,6),
(47,4,4,57,NULL,NULL,'A/c. Divya Sharma','','',0,7),
(48,5,5,47,'         0270','2026-06-26','MRI SYSTEM','09','F T L',90000,1),
(49,5,5,47,NULL,NULL,'','','',0,2),
(50,5,5,47,NULL,NULL,'Two days Halting charges at Chennai','','',8000,3),
(51,5,5,47,NULL,NULL,'','','',0,4),
(52,5,5,47,NULL,NULL,'Vizag to Chennai','','',0,5),
(53,5,5,47,NULL,NULL,'','','',0,6),
(54,5,5,47,NULL,NULL,'40 Feet Open Trailer','','',0,7),
(55,5,5,47,NULL,NULL,'','','',0,8),
(56,5,5,47,NULL,NULL,'Vehicle No. : AP39TQ3369','','',0,9),
(57,6,6,47,'       0270','2026-06-26','MRI SYSTEM','09','F T L',90000,1),
(58,6,6,47,NULL,NULL,'','','',0,2),
(59,6,6,47,NULL,NULL,'Two Days Halting Charges at Chennai','','',8000,3),
(60,6,6,47,NULL,NULL,'','','',0,4),
(61,6,6,47,NULL,NULL,'Vizag to Chennai','','',0,5),
(62,6,6,47,NULL,NULL,'','','',0,6),
(63,6,6,47,NULL,NULL,'40 Feet Open Trailer','','',0,7),
(64,6,6,47,NULL,NULL,'','','',0,8),
(65,6,6,47,NULL,NULL,'Vehicle No. AP39TQ3369','','',0,9),
(66,7,7,56,'326','2026-06-30','MRI COMPONENTS','03','F T L',85000,1),
(67,7,7,56,NULL,NULL,'','','',0,2),
(68,7,7,56,NULL,NULL,'Chennai to Vizag','','',0,3),
(69,7,7,56,NULL,NULL,'','','',0,4),
(70,7,7,56,NULL,NULL,'40 Feet Open Trailer','','',0,5),
(71,7,7,56,NULL,NULL,'','','',0,6),
(72,7,7,56,NULL,NULL,'Vehicle No. : AP39WC8499','','',0,7),
(73,8,8,58,'327','2026-07-01','MRI BODY COVER','04','F T L',80000,1),
(74,8,8,58,NULL,NULL,'','','',0,2),
(75,8,8,58,NULL,NULL,'Chennai to Vizag','','',0,3),
(76,8,8,58,NULL,NULL,'','','',0,4),
(77,8,8,58,NULL,NULL,'40 Feet Open Trailer','','',0,5),
(78,8,8,58,NULL,NULL,'','','',0,6),
(79,8,8,58,NULL,NULL,'Vehicle No. : KA01AQ5679','','',0,7),
(80,9,9,38,NULL,NULL,'FREIGHT CHARGES RECEIVED','','',37850,1),
(81,10,10,39,NULL,NULL,'FREIGHT CHARGES RECEIVED','','',31100,1),
(82,11,11,40,NULL,NULL,'FREIGHT CHARGES RECEIVED','','',12820,1),
(83,12,12,43,NULL,NULL,'FREIGHT CHARGES RECEIVED','','',25100,1),
(84,13,13,44,NULL,NULL,'FREIGHT CHARGES RECEIVED','','',35100,1),
(85,14,14,46,NULL,NULL,'FREIGHT CHARGES RECEIVED','','',16208,1),
(86,15,15,45,NULL,NULL,'FREIGHT CHARGES RECEIVED','','',20809,1),
(87,16,16,49,NULL,NULL,'FREIGHT CHARGES RECEIVED','','',6100,1),
(88,17,17,50,NULL,NULL,'FREIGHT CHARGES RECEIVED','','',14358,1),
(89,18,18,64,NULL,NULL,'RETURN CHARGES','','',1000,1),
(90,19,19,65,NULL,NULL,'RETURN CHARGES','','',1000,1),
(91,20,20,69,'-','2026-07-09','Aqua Products','15','F T L',8000,1),
(92,20,20,69,NULL,NULL,'','','',0,2),
(93,20,20,69,NULL,NULL,'Tondiarpet to Gummidipoondi','','',0,3),
(94,20,20,69,NULL,NULL,'','','',0,4),
(95,20,20,69,NULL,NULL,'17 Feet closed container','','',0,5),
(96,20,20,69,NULL,NULL,'','','',0,6),
(97,20,20,69,NULL,NULL,'Container No. : TN18AB2214','','',0,7),
(98,21,21,16,'0255','2026-06-10','H L MEDICINES & AQUA PRODUCTS','1011','F T L',77400,1),
(99,21,21,16,NULL,NULL,'','','',0,2),
(100,21,21,16,NULL,NULL,'L R charges','','',50,3),
(101,21,21,16,NULL,NULL,'','','',0,4),
(102,21,21,16,NULL,NULL,'Unloading charges at Kolkata','','',4550,5),
(103,21,21,16,NULL,NULL,'(Unloading slip enclosed)','','',0,6),
(104,21,21,16,NULL,NULL,'','','',0,7),
(105,21,21,16,NULL,NULL,'Chennai to Kolkata','','',0,8),
(106,21,21,16,NULL,NULL,'','','',0,9),
(107,21,21,16,NULL,NULL,'20 feet container No. : TN18BH3638','','',0,10),
(108,21,21,16,NULL,NULL,'Note: Loading charges Rs.2450 paid by us.','','',0,11),
(109,21,22,25,'0256','2026-06-11','H L MEDICINES','1022','F T L',79500,1),
(110,21,22,25,NULL,NULL,'','','',0,2),
(111,21,22,25,NULL,NULL,'L R charges','','',50,3),
(112,21,22,25,NULL,NULL,'','','',0,4),
(113,21,22,25,NULL,NULL,'Unloading charges at Kolkata','','',4600,5),
(114,21,22,25,NULL,NULL,'(Unloading slip enclosed)','','',0,6),
(115,21,22,25,NULL,NULL,'','','',0,7),
(116,21,22,25,NULL,NULL,'Chennai to Kolkata','','',0,8),
(117,21,22,25,NULL,NULL,'','','',0,9),
(118,21,22,25,NULL,NULL,'24 Feet Container No. : TN12BS0813','','',0,10),
(119,21,22,25,NULL,NULL,'Note: Loading charges Rs.3025 paid by us.','','',0,11),
(120,21,23,35,'0263','2026-06-16','H L MEDICINES','610','F T L',26400,1),
(121,21,23,35,NULL,NULL,'','','',0,2),
(122,21,23,35,NULL,NULL,'L R charges','','',50,3),
(123,21,23,35,NULL,NULL,'','','',0,4),
(124,21,23,35,NULL,NULL,'Unloading charges at Vijayawada','','',610,5),
(125,21,23,35,NULL,NULL,'(Unloading slip enclosed)','','',0,6),
(126,21,23,35,NULL,NULL,'','','',0,7),
(127,21,23,35,NULL,NULL,'Chennai to Vijayawada','','',0,8),
(128,21,23,35,NULL,NULL,'','','',0,9),
(129,21,23,35,NULL,NULL,'20 feet container No. : TN12U1036','','',0,10),
(130,21,23,35,NULL,NULL,'Note: Loading charges Rs.1950 paid by us.','','',0,11),
(131,21,24,37,'0264','2026-06-17','H L MEDICINES','633','F T L',16600,1),
(132,21,24,37,NULL,NULL,'','','',0,2),
(133,21,24,37,NULL,NULL,'L R Charges','','',50,3),
(134,21,24,37,NULL,NULL,'','','',0,4),
(135,21,24,37,NULL,NULL,'Unloading charges at Bangalore','','',4431,5),
(136,21,24,37,NULL,NULL,'(Written in our LR copy backside)','','',0,6),
(137,21,24,37,NULL,NULL,'','','',0,7),
(138,21,24,37,NULL,NULL,'Chennai to Bangalore','','',0,8),
(139,21,24,37,NULL,NULL,'','','',0,9),
(140,21,24,37,NULL,NULL,'17 Feet Container No. : KA03AJ7757','','',0,10),
(141,21,24,37,NULL,NULL,'Note: Loading charges Rs.1640 paid by us.','','',0,11),
(142,21,25,48,'0271','2026-06-27','H L MEDICINES','341','F T L',15300,1),
(143,21,25,48,NULL,NULL,'','','',0,2),
(144,21,25,48,NULL,NULL,'L R Charges','','',50,3),
(145,21,25,48,NULL,NULL,'','','',0,4),
(146,21,25,48,NULL,NULL,'Unloading charges at Bangalore','','',2397,5),
(147,21,25,48,NULL,NULL,'(Written in our LR copy backside)','','',0,6),
(148,21,25,48,NULL,NULL,'','','',0,7),
(149,21,25,48,NULL,NULL,'Chennai to Bangalore','','',0,8),
(150,21,25,48,NULL,NULL,'','','',0,9),
(151,21,25,48,NULL,NULL,'14 Feet Container No. : KA02AL0907','','',0,10),
(152,21,25,48,NULL,NULL,'Note: Loading charges Rs.820 paid by us.','','',0,11),
(153,21,26,51,'0272','2026-06-29','H L MEDICINES & AQUA PRODUCTS','507','F T L',25600,1),
(154,21,26,51,NULL,NULL,'','','',0,2),
(155,21,26,51,NULL,NULL,'L R Charges','','',50,3),
(156,21,26,51,NULL,NULL,'','','',0,4),
(157,21,26,51,NULL,NULL,'Unloading charges at Vijayawada','','',510,5),
(158,21,26,51,NULL,NULL,'(Unloading slip enclosed)','','',0,6),
(159,21,26,51,NULL,NULL,'','','',0,7),
(160,21,26,51,NULL,NULL,'Chennai to Vijayawada','','',0,8),
(161,21,26,51,NULL,NULL,'','','',0,9),
(162,21,26,51,NULL,NULL,'20 Feet container No. : TN18BH3623','','',0,10),
(163,21,26,51,NULL,NULL,'Note: Loading charges Rs.1620 paid by us.','','',0,11),
(164,22,27,20,'0269','2026-06-25','MEDICINES','939','F T L',13000,1),
(165,22,27,20,NULL,NULL,'','','',0,2),
(166,22,27,20,NULL,NULL,'L R Charges','','',50,3),
(167,22,27,20,NULL,NULL,'','','',0,4),
(168,22,27,20,NULL,NULL,'Tondiarpet to Ennore','','',0,5),
(169,22,27,20,NULL,NULL,'','','',0,6),
(170,22,27,20,NULL,NULL,'20 Feet Container 2 Vehicles used','','',0,7),
(171,22,27,20,NULL,NULL,'Container No. : TN12AU1549','','',0,8),
(172,22,27,20,NULL,NULL,'Container No. : TN12AU1570','','',0,9),
(173,22,28,36,'-','2026-06-17','AQUA PRODUCTS','152','F T L',4500,1),
(174,22,28,36,NULL,NULL,'','','',0,2),
(175,22,28,36,NULL,NULL,'Tondiarpet to Triway CFS','','',0,3),
(176,22,28,36,NULL,NULL,'','','',0,4),
(177,22,28,36,NULL,NULL,'17 Feet container No. : TN10J3677','','',0,5),
(178,23,29,11,'-','2026-06-08','MEDICINES','03','F T L',2500,1),
(179,23,29,11,NULL,NULL,'','','',0,2),
(180,23,29,11,NULL,NULL,'Thirurani CFS Madavaram to Tondiarpet','','',0,3),
(181,23,29,11,NULL,NULL,'','','',0,4),
(182,23,29,11,NULL,NULL,'Vehicle No. : TN02BX7239','','',0,5),
(183,23,30,30,'0262','2026-06-13','H L MEDICINES','20','F T L',6000,1),
(184,23,30,30,NULL,NULL,'','','',0,2),
(185,23,30,30,NULL,NULL,'L R Charges','','',50,3),
(186,23,30,30,NULL,NULL,'','','',0,4),
(187,23,30,30,NULL,NULL,'Chennai Airport to Pondy','','',0,5),
(188,23,30,30,NULL,NULL,'','','',0,6),
(189,23,30,30,NULL,NULL,'Dost Container No. : TN51AU8620','','',0,7),
(190,23,31,70,'-','2026-07-10','OFFICE ITEMS','02','F T L',4000,1),
(191,23,31,70,NULL,NULL,'','','',0,2),
(192,23,31,70,NULL,NULL,'Ennore(EECT) TO Adyar','','',0,3),
(193,23,31,70,NULL,NULL,'','','',0,4),
(194,23,31,70,NULL,NULL,'Bada Dost Container No. TN13AH1735','','',0,5),
(195,24,32,14,'0254','2026-06-09','H L MEDICINES','300','F T L',12750,1),
(196,24,32,14,NULL,NULL,'','','',0,2),
(197,24,32,14,NULL,NULL,'L R Charges','','',50,3),
(198,24,32,14,NULL,NULL,'','','',0,4),
(199,24,32,14,NULL,NULL,'Unloading charges at Bangalore','','',3000,5),
(200,24,32,14,NULL,NULL,'(Written in our LR copy)','','',0,6),
(201,24,32,14,NULL,NULL,'','','',0,7),
(202,24,32,14,NULL,NULL,'Chennai to Bangalore','','',0,8),
(203,24,32,14,NULL,NULL,'','','',0,9),
(204,24,32,14,NULL,NULL,'Container No. : TN73BY5098','','',0,10),
(205,24,33,42,'0268','2026-06-20','H L MEDICINES','161','F T L',26300,1),
(206,24,33,42,NULL,NULL,'','','',0,2),
(207,24,33,42,NULL,NULL,'L R Charges','','',50,3),
(208,24,33,42,NULL,NULL,'','','',0,4),
(209,24,33,42,NULL,NULL,'Unloading charges at Kalaburagi','','',2415,5),
(210,24,33,42,NULL,NULL,'(Written in our LR copy)','','',0,6),
(211,24,33,42,NULL,NULL,'','','',0,7),
(212,24,33,42,NULL,NULL,'Chennai to Kalaburagi','','',0,8),
(213,24,33,42,NULL,NULL,'','','',0,9),
(214,24,33,42,NULL,NULL,'Vehicle No. : MH13DQ6840','','',0,10),
(215,24,34,53,'0273','2026-06-30','AQUA PRODUCTS','34','F T L',11000,1),
(216,24,34,53,NULL,NULL,'','','',0,2),
(217,24,34,53,NULL,NULL,'L R Charges','','',50,3),
(218,24,34,53,NULL,NULL,'','','',0,4),
(219,24,34,53,NULL,NULL,'Unloading charges at Nagapatinam','','',200,5),
(220,24,34,53,NULL,NULL,'(Written in our LR copy)','','',0,6),
(221,24,34,53,NULL,NULL,'','','',0,7),
(222,24,34,53,NULL,NULL,'Chennai to Nagapatinam','','',0,8),
(223,24,34,53,NULL,NULL,'','','',0,9),
(224,24,34,53,NULL,NULL,'Vehicle No. : TN49CR2089','','',0,10),
(225,24,35,54,'0274','2026-06-30','AQUA PRODUCTS','379','F T L',21250,1),
(226,24,35,54,NULL,NULL,'','','',0,2),
(227,24,35,54,NULL,NULL,'L R Charges','','',50,3),
(228,24,35,54,NULL,NULL,'','','',0,4),
(229,24,35,54,NULL,NULL,'Chennai to Repalle','','',0,5),
(230,24,35,54,NULL,NULL,'','','',0,6),
(231,24,35,54,NULL,NULL,'Vehicle No. : AP39UW7643','','',0,7),
(232,24,36,55,'0275','2026-06-30','AQUA PRODUCTS','162','F T L',17750,1),
(233,24,36,55,NULL,NULL,'','','',0,2),
(234,24,36,55,NULL,NULL,'L R Charges','','',50,3),
(235,24,36,55,NULL,NULL,'','','',0,4),
(236,24,36,55,NULL,NULL,'Chennai to Koduru','','',0,5),
(237,24,36,55,NULL,NULL,'','','',0,6),
(238,24,36,55,NULL,NULL,'Vehicle No. : AP39UX9391','','',0,7),
(239,24,36,55,NULL,NULL,'(Note: Loading charges Rs.792 paid by us.)','','',0,8),
(240,24,36,55,NULL,NULL,'','','',0,9),
(241,24,36,55,NULL,NULL,'TOTAL LR\'s = 06 No\'s Only.','','',0,10),
(242,25,37,41,'0267','2026-06-19','MEDICINES','534','F T L',10500,1),
(243,25,37,41,NULL,NULL,'','','',0,2),
(244,25,37,41,NULL,NULL,'L R Charges','','',50,3),
(245,25,37,41,NULL,NULL,'','','',0,4),
(246,25,37,41,NULL,NULL,'Tondiarpet to Oragadam','','',0,5),
(247,25,37,41,NULL,NULL,'','','',0,6),
(248,25,37,41,NULL,NULL,'20 Feet container No. : TN12AM2845','','',0,7),
(249,25,37,41,NULL,NULL,'Note: Loading charges Rs.500 paid by us.','','',0,8),
(250,25,38,62,'328','2026-07-03','MEDICINES','90','F T L',6000,1),
(251,25,38,62,NULL,NULL,'','','',0,2),
(252,25,38,62,NULL,NULL,'L R Charges','','',50,3),
(253,25,38,62,NULL,NULL,'','','',0,4),
(254,25,38,62,NULL,NULL,'Tondiarpet to Oragadam','','',0,5),
(255,25,38,62,NULL,NULL,'','','',0,6),
(256,25,38,62,NULL,NULL,'Dost Container No. : TN02CH2469','','',0,7),
(257,25,38,62,NULL,NULL,'','','',0,8),
(258,25,38,62,NULL,NULL,'TOTAL LR\'s = 02 No\'s ONLY.','','',0,9),
(259,26,39,73,'354','2026-07-15','FRP TANK & TOP MOUNT FRONT FACING FILTER','143','F T L',21500,1),
(260,26,39,73,NULL,NULL,'','','',0,2),
(261,26,39,73,NULL,NULL,'L R Charges','','',100,3),
(262,26,39,73,NULL,NULL,'','','',0,4),
(263,26,39,73,NULL,NULL,'Chennai to Coimbatore','','',0,5),
(264,26,39,73,NULL,NULL,'','','',0,6),
(265,26,39,73,NULL,NULL,'20 Feet Container No. : TN38DP3913','','',0,7),
(266,27,40,76,'355','2026-07-16','ROMH','02','F T L',34000,1),
(267,27,40,76,NULL,NULL,'(02 WOODEN BOXES)','','',0,2),
(268,27,40,76,NULL,NULL,'','','',0,3),
(269,27,40,76,NULL,NULL,'L R Charges','','',100,4),
(270,27,40,76,NULL,NULL,'','','',0,5),
(271,27,40,76,NULL,NULL,'Chennai to Goa','','',0,6),
(272,27,40,76,NULL,NULL,'','','',0,7),
(273,27,40,76,NULL,NULL,'20 Feet Open Truck No.KA28AB7992','','',0,8),
(274,28,41,59,NULL,NULL,'FREIGHT CHARGES','','',11050,1),
(275,29,42,60,NULL,NULL,'FREIGHT CHARGHES','','',14298,1),
(276,30,43,61,NULL,NULL,'FREIGHT CHARGES','','',11300,1),
(277,31,44,66,NULL,NULL,'FREIGHT CHARGES','','',18144,1),
(278,32,45,67,NULL,NULL,'FREIGHT CHARGES','','',18143,1),
(279,33,46,68,NULL,NULL,'FREIGHT CHARGES','','',12540,1),
(280,34,47,74,NULL,NULL,'FREIGHT CHARGES','','',17650,1),
(281,35,48,81,NULL,NULL,'Used Household Goods','14','F T L',9000,1),
(282,35,48,81,NULL,NULL,'','','',0,2),
(283,35,48,81,NULL,NULL,'Chennai to Bangalore','','',0,3),
(284,35,48,81,NULL,NULL,'','','',0,4),
(285,35,48,81,NULL,NULL,'Bolero Container No. TN18AT3957','','',0,5),
(286,36,49,82,NULL,NULL,'ROMH','28','F T L',77000,1),
(287,36,49,82,NULL,NULL,'','','',0,2),
(288,36,49,82,NULL,NULL,'L R Charges','','',100,3),
(289,36,49,82,NULL,NULL,'','','',0,4),
(290,36,49,82,NULL,NULL,'Chennai to Faridabad','','',0,5),
(291,36,49,82,NULL,NULL,'','','',0,6),
(292,36,49,82,NULL,NULL,'24 Feet Open Truck No. : HR38AD2250','','',0,7),
(293,37,50,83,'5005','2026-07-23','Used Household Goods','Asper List','F T L',43500,1),
(294,37,50,83,NULL,NULL,'','','',0,2),
(295,37,50,83,NULL,NULL,'(Chennai to Bangalore)','','',0,3),
(296,37,50,83,NULL,NULL,'','','',0,4),
(297,37,50,83,'5006','2026-07-23','Used Household Goods','Asper List','F T L',0,5),
(298,37,50,83,NULL,NULL,'','','',0,6),
(299,37,50,83,NULL,NULL,'(Chennai to Goa)','','',0,7),
(300,37,50,83,NULL,NULL,'','','',0,8),
(301,37,50,83,NULL,NULL,'20 Feet Closed Container','','',0,9),
(302,37,50,83,NULL,NULL,'','','',0,10),
(303,37,50,83,NULL,NULL,'Container No. : TN34AD3479','','',0,11),
(304,37,50,83,NULL,NULL,'','','',0,12),
(305,37,50,83,NULL,NULL,'A/c.M/s.ELITE RELOCATIONS','','',0,13),
(306,38,51,84,NULL,NULL,'Used Household Goods','Asper List','F T L',7500,1),
(307,38,51,84,NULL,NULL,'','','',0,2),
(308,38,51,84,NULL,NULL,'Hiranandhini Warehouse to Tryway CFS','','',0,3),
(309,38,51,84,NULL,NULL,'','','',0,4),
(310,38,51,84,NULL,NULL,'24 Feet Truck','','',0,5),
(311,38,51,84,NULL,NULL,'','','',0,6),
(312,38,51,84,NULL,NULL,'A/c.Mr.JOHN LUND','','',0,7),
(313,39,52,85,NULL,NULL,'Used Household Goods','Asper List','F T L',6000,1),
(314,39,52,85,NULL,NULL,'','','',0,2),
(315,39,52,85,NULL,NULL,'Chennai Local use','','',0,3),
(316,39,52,85,NULL,NULL,'','','',0,4),
(317,39,52,85,NULL,NULL,'20 Feet Closed Container','','',0,5),
(318,39,52,85,NULL,NULL,'','','',0,6),
(319,39,52,85,NULL,NULL,'A/c. NAMUNAN','','',0,7),
(320,40,53,92,'5009','2026-07-29','ANIML FEED','100','500 Kg',6000,1),
(321,40,53,92,NULL,NULL,'','','',0,2),
(322,40,53,92,NULL,NULL,'Tondiarpet to Thervoy Kandigai','','',0,3),
(323,40,53,92,NULL,NULL,'','','',0,4),
(324,40,53,92,NULL,'2026-07-29','EMPTY TRAY','07','F T L',0,5),
(325,40,53,92,NULL,NULL,'','','',0,6),
(326,40,53,92,NULL,NULL,'Thervoy Kandigai to Tondiarpet','','',0,7),
(327,40,53,92,NULL,NULL,'','','',0,8),
(328,40,53,92,NULL,NULL,'Container No. TN03AE5173','','',0,9),
(329,41,54,103,NULL,NULL,'','','',10000,1),
(330,42,55,104,NULL,NULL,'','','',10000,1),
(331,43,56,63,'329','2026-07-04','AQUA PRODUCTS & H L MEDICINES','463','F T L',25950,1),
(332,43,56,63,NULL,NULL,'','','',0,2),
(333,43,56,63,NULL,NULL,'L R Charges','','',50,3),
(334,43,56,63,NULL,NULL,'','','',0,4),
(335,43,56,63,NULL,NULL,'Unloading charges at Vijayawada','','',470,5),
(336,43,56,63,NULL,NULL,'(Unloading slip enclosed)','','',0,6),
(337,43,56,63,NULL,NULL,'','','',0,7),
(338,43,56,63,NULL,NULL,'Chennai to Vijayawada','','',0,8),
(339,43,56,63,NULL,NULL,'','','',0,9),
(340,43,56,63,NULL,NULL,'20 Feet Container No. : TN12BR5413','','',0,10),
(341,43,56,63,NULL,NULL,'(Loading charges Rs.1460/- paid by us.)','','',0,11),
(342,43,57,75,NULL,NULL,'AQUA PRODUCTS & H L MEDICINES','753','F T L',26780,1),
(343,43,57,75,NULL,NULL,'','','',0,2),
(344,43,57,75,NULL,NULL,'L R Charges','','',50,3),
(345,43,57,75,NULL,NULL,'','','',0,4),
(346,43,57,75,NULL,NULL,'Unloading charges at Vijayawada','','',750,5),
(347,43,57,75,NULL,NULL,'(Unloading slip enclosed)','','',0,6),
(348,43,57,75,NULL,NULL,'','','',0,7),
(349,43,57,75,NULL,NULL,'Chennai to Vijayawada','','',0,8),
(350,43,57,75,NULL,NULL,'','','',0,9),
(351,43,57,75,NULL,NULL,'','','',0,10),
(352,43,57,75,NULL,NULL,'20 Feet Container No. : TN48BZ8579','','',0,11),
(353,43,57,75,NULL,NULL,'(Loading charges Rs.2780/- paid by us.)','','',0,12),
(354,43,58,80,NULL,NULL,'H L MEDICINES','638','F T L',17750,1),
(355,43,58,80,NULL,NULL,'','','',0,2),
(356,43,58,80,NULL,NULL,'L R Charges','','',50,3),
(357,43,58,80,NULL,NULL,'','','',0,4),
(358,43,58,80,NULL,NULL,'Unloading charges at Bangalore','','',4466,5),
(359,43,58,80,NULL,NULL,'(Written in our LR copy Backside)','','',0,6),
(360,43,58,80,NULL,NULL,'','','',0,7),
(361,43,58,80,NULL,NULL,'Chennai to Bangalore','','',0,8),
(362,43,58,80,NULL,NULL,'','','',0,9),
(363,43,58,80,NULL,NULL,'','','',0,10),
(364,43,58,80,NULL,NULL,'Truck No. : MH45AE9054','','',0,11),
(365,43,58,80,NULL,NULL,'(Loading charges Rs.1760/- paid by us.)','','',0,12),
(366,43,59,88,NULL,NULL,'H L MEDICINES','484','F T L',25300,1),
(367,43,59,88,NULL,NULL,'','','',0,2),
(368,43,59,88,NULL,NULL,'L R Charges','','',50,3),
(369,43,59,88,NULL,NULL,'','','',0,4),
(370,43,59,88,NULL,NULL,'Unloading charges at Vijayawada','','',490,5),
(371,43,59,88,NULL,NULL,'(Unloading slip enclosed)','','',0,6),
(372,43,59,88,NULL,NULL,'','','',0,7),
(373,43,59,88,NULL,NULL,'Chennai to Vijayawada','','',0,8),
(374,43,59,88,NULL,NULL,'','','',0,9),
(375,43,59,88,NULL,NULL,'20 Feet Container No. : TN12AS8949','','',0,10),
(376,43,59,88,NULL,NULL,'(Loading charges Rs.1310/- paid by us.)','','',0,11),
(388,44,61,71,NULL,NULL,'H L MEDICINES','251','F T L',14000,1),
(389,44,61,71,NULL,NULL,'','','',0,2),
(390,44,61,71,NULL,NULL,'L R Charges','','',50,3),
(391,44,61,71,NULL,NULL,'','','',0,4),
(392,44,61,71,NULL,NULL,'Unloading charges at Bangalore','','',2510,5),
(393,44,61,71,NULL,NULL,'(Written in our LR copy)','','',0,6),
(394,44,61,71,NULL,NULL,'','','',0,7),
(395,44,61,71,NULL,NULL,'Chennai to Bangalore','','',0,8),
(396,44,61,71,NULL,NULL,'','','',0,9),
(397,44,61,71,NULL,NULL,'Container No. : TN59DU6585','','',0,10),
(398,44,61,71,NULL,NULL,'(Loading charges Rs.500/- paid by us.)','','',0,11),
(399,44,62,72,NULL,NULL,'H L MEDICINES','601','F T L',33500,1),
(400,44,62,72,NULL,NULL,'','','',0,2),
(401,44,62,72,NULL,NULL,'L R Charges','','',50,3),
(402,44,62,72,NULL,NULL,'','','',0,4),
(403,44,62,72,NULL,NULL,'Unloading charges at Kalaburagi','','',9000,5),
(404,44,62,72,NULL,NULL,'(Written in our LR copy)','','',0,6),
(405,44,62,72,NULL,NULL,'','','',0,7),
(406,44,62,72,NULL,NULL,'Chennai to Kalaburagi','','',0,8),
(407,44,62,72,NULL,NULL,'','','',0,9),
(408,44,62,72,NULL,NULL,'Truck No. : MH12YB9418','','',0,10),
(409,44,62,72,NULL,NULL,'(loading charges Rs.1550/- paid by us.)','','',0,11),
(410,44,63,101,NULL,NULL,'AQUA PRODUCTS','59','F T L',11170,1),
(411,44,63,101,NULL,NULL,'','','',0,2),
(412,44,63,101,NULL,NULL,'L R Charges','','',50,3),
(413,44,63,101,NULL,NULL,'','','',0,4),
(414,44,63,101,NULL,NULL,'Unloading charges at Nagapatinam','','',200,5),
(415,44,63,101,NULL,NULL,'(Written in our LR copy)','','',0,6),
(416,44,63,101,NULL,NULL,'','','',0,7),
(417,44,63,101,NULL,NULL,'Chennai to Nagapatinam','','',0,8),
(418,44,63,101,NULL,NULL,'','','',0,9),
(419,44,63,101,NULL,NULL,'Vehicle No. : TN99AB2710','','',0,10),
(420,44,63,101,NULL,NULL,'(Loading charges Rs.170/- paid by us.)','','',0,11),
(421,44,63,101,NULL,NULL,'','','',0,12),
(422,43,60,93,NULL,NULL,'H L MEDICINES & AQUA PRODUCTS','299','F T L',25000,1),
(423,43,60,93,NULL,NULL,'','','',0,2),
(424,43,60,93,NULL,NULL,'L R Charges','','',50,3),
(425,43,60,93,NULL,NULL,'','','',0,4),
(426,43,60,93,NULL,NULL,'Unloading charges at Vijayawada','','',300,5),
(427,43,60,93,NULL,NULL,'(Unloading slip enclosed)','','',0,6),
(428,43,60,93,NULL,NULL,'','','',0,7),
(429,43,60,93,NULL,NULL,'Chennai to Vijayawada','','',0,8),
(430,43,60,93,NULL,NULL,'','','',0,9),
(431,43,60,93,NULL,NULL,'20 Feet Container No. : TN12AS8949','','',0,10),
(432,43,60,93,NULL,NULL,'(Loading charges Rs.1078/- paid by us.)','','',0,11),
(433,43,60,93,NULL,NULL,'TOTAL LR\'s = 05 No\'s ONLY.','','',0,12),
(434,45,64,87,NULL,NULL,'MEDICINES','112','F T L',6000,1),
(435,45,64,87,NULL,NULL,'','','',0,2),
(436,45,64,87,NULL,NULL,'L R Charges','','',50,3),
(437,45,64,87,NULL,NULL,'','','',0,4),
(438,45,64,87,NULL,NULL,'Tondiarpet to Oragadam','','',0,5),
(439,45,64,87,NULL,NULL,'','','',0,6),
(440,45,64,87,NULL,NULL,'Container No. : TN02BY0927','','',0,7),
(448,46,66,97,'-',NULL,'MEDICINES','Asper List','F T L',2500,1),
(449,46,66,97,NULL,NULL,'','','',0,2),
(450,46,66,97,NULL,NULL,'Triway CFS to Tondiarpet','','',0,3),
(451,46,66,97,NULL,NULL,'','','',0,4),
(452,46,66,97,NULL,NULL,'Container No. : TN03AE5173','','',0,5),
(453,45,65,94,NULL,NULL,'EMPTY BOTTLES','188','F T L',10000,1),
(454,45,65,94,NULL,NULL,'','','',0,2),
(455,45,65,94,NULL,NULL,'L R Charges','','',50,3),
(456,45,65,94,NULL,NULL,'','','',0,4),
(457,45,65,94,NULL,NULL,'Tondiarpet to Oragadam','','',0,5),
(458,45,65,94,NULL,NULL,'','','',0,6),
(459,45,65,94,NULL,NULL,'20 Feet Container No. : TN73L2684 ','','',0,7),
(460,47,67,79,NULL,NULL,'MEDICINES','10','F T L',10000,1),
(461,47,67,79,NULL,NULL,'','','',0,2),
(462,47,67,79,NULL,NULL,'L R Charges','','',50,3),
(463,47,67,79,NULL,NULL,'','','',0,4),
(464,47,67,79,NULL,NULL,'TONDIARPET TO SANCO -CFS ENNORE','','',0,5),
(465,47,67,79,NULL,NULL,'','','',0,6),
(466,47,67,79,NULL,NULL,'17 Feet Container 2 No\'s Used','','',0,7),
(467,47,67,79,NULL,NULL,'Container No. : TN18AB2214','','',0,8),
(468,47,67,79,NULL,NULL,'Container No. : TN12AU1549','','',0,9),
(469,47,68,86,NULL,NULL,'MEDICNES','167','F T L',2500,1),
(470,47,68,86,NULL,NULL,'','','',0,2),
(471,47,68,86,NULL,NULL,'L R charges','','',50,3),
(472,47,68,86,NULL,NULL,'','','',0,4),
(473,47,68,86,NULL,NULL,'Tondiarpet to Airport','','',0,5),
(474,47,68,86,NULL,NULL,'','','',0,6),
(475,47,68,86,NULL,NULL,'Container No. : TN03AE5173','','',0,7),
(476,48,69,77,NULL,NULL,'','','',8100,1),
(477,49,70,78,NULL,NULL,'','','',9300,1),
(478,50,71,96,NULL,NULL,'','','',29900,1),
(479,51,72,98,NULL,NULL,'','','',12780,1),
(480,52,73,99,NULL,NULL,'','','',13350,1),
(481,53,74,100,NULL,NULL,'','','',11789,1),
(482,54,75,89,NULL,NULL,'','','',10500,1),
(483,55,76,91,NULL,NULL,'','','',15700,1),
(484,56,77,102,NULL,NULL,'','','',29320,1),
(485,57,78,95,NULL,NULL,'ROMH - NEW GEN FILTER','1099','F T L',77000,1),
(486,57,78,95,NULL,NULL,'','','',0,2),
(487,57,78,95,NULL,NULL,'L R Charges','','',100,3),
(488,57,78,95,NULL,NULL,'','','',0,4),
(489,57,78,95,NULL,NULL,'Chennai to Delhi','','',0,5),
(490,57,78,95,NULL,NULL,'','','',0,6),
(491,57,78,95,NULL,NULL,'24 Feet Container No. : UP14RT9359','','',0,7),
(492,58,79,105,NULL,NULL,'ROMH','41','F T L',34000,1),
(493,58,79,105,NULL,NULL,'','','',0,2),
(494,58,79,105,NULL,NULL,'Halting Charges at Goa','','',1000,3),
(495,58,79,105,NULL,NULL,'','','',0,4),
(496,58,79,105,NULL,NULL,'L R Charges','','',100,5),
(497,58,79,105,NULL,NULL,'','','',0,6),
(498,58,79,105,NULL,NULL,'Chennai to Goa','','',0,7),
(499,58,79,105,NULL,NULL,'','','',0,8),
(500,58,79,105,NULL,NULL,'20 Feet Truck No. : KA22A5564','','',0,9),
(501,59,80,90,NULL,NULL,'MRI DUMMY MODEL','01','F T L',110000,1),
(502,59,80,90,NULL,NULL,'','','',0,2),
(503,59,80,90,NULL,NULL,'Vizag to Mumbai','','',0,3),
(504,59,80,90,NULL,NULL,'','','',0,4),
(505,59,80,90,NULL,NULL,'32 Feet Open Truck No. MH23AU6834','','',0,5),
(506,59,81,106,NULL,NULL,'MRI DUMMY MODEL','01','F T L',110000,1),
(507,59,81,106,NULL,NULL,'','','',0,2),
(508,59,81,106,NULL,NULL,'Mumbai to Vizag','','',0,3),
(509,59,81,106,NULL,NULL,'','','',0,4),
(510,59,81,106,NULL,NULL,'32 Feet Open Truck No. MH23AU6834','','',0,5),
(511,60,82,107,'368','2026-08-06','ROMH','19','F T L',44000,1),
(512,60,82,107,NULL,NULL,'','','',0,2),
(513,60,82,107,NULL,NULL,'Chennai to Pune','','',0,3),
(514,60,82,107,NULL,NULL,'','','',0,4),
(515,60,82,107,'369','2026-08-06','ROMH','16','F T L',0,5),
(516,60,82,107,NULL,NULL,'','','',0,6),
(517,60,82,107,NULL,NULL,'Chennai to Khalapur','','',0,7),
(518,60,82,107,NULL,NULL,'','','',0,8),
(519,60,82,107,NULL,NULL,'L R Charges','','',200,9),
(520,60,82,107,NULL,NULL,'','','',0,10),
(521,60,82,107,NULL,NULL,'22 Feet Truck No. : KA22AA4652','','',0,11),
(522,61,83,110,NULL,NULL,'Used Office Goods','As per List','F T L',13000,1),
(523,61,83,110,NULL,NULL,'','','',0,2),
(524,61,83,110,NULL,NULL,'L R Charges','','',50,3),
(525,61,83,110,NULL,NULL,'','','',0,4),
(526,61,83,110,NULL,NULL,'Chennai to Ranipet (Up & Down)','','',0,5),
(527,61,83,110,NULL,NULL,'','','',0,6),
(528,61,83,110,NULL,NULL,'Dost Container No. : TN18AW2000','','',0,7),
(529,61,83,110,NULL,NULL,'','','',0,8),
(530,61,83,110,NULL,NULL,'A/s.M/s.  ABBOT HEALTH CARE','','',0,9),
(531,62,84,114,NULL,NULL,'Used Household Goods','90','F T L',26000,1),
(532,62,84,114,NULL,NULL,'','','',0,2),
(533,62,84,114,NULL,NULL,'L R Charges','','',50,3),
(534,62,84,114,NULL,NULL,'','','',0,4),
(535,62,84,114,NULL,NULL,'Chennai to Madurai','','',0,5),
(536,62,84,114,NULL,NULL,'','','',0,6),
(537,62,84,114,NULL,NULL,'20 Feet Container No. : TN82Z9555','','',0,7),
(538,62,84,114,NULL,NULL,'','','',0,8),
(539,62,84,114,NULL,NULL,'A/C.MR.MOHAMED RASOOL','','',0,9),
(540,63,85,108,'364','2026-08-02','ROMH','116','F T L',80000,1),
(541,63,85,108,NULL,NULL,'','','',0,2),
(542,63,85,108,NULL,NULL,'(Chennai to Surat)','','',0,3),
(543,63,85,108,NULL,NULL,'','','',0,4),
(544,63,85,108,'365','2026-08-02','ROMH','219','F T L',0,5),
(545,63,85,108,NULL,NULL,'','','',0,6),
(546,63,85,108,NULL,NULL,'(Chennai to Ahmedabad)','','',0,7),
(547,63,85,108,NULL,NULL,'','','',0,8),
(548,63,85,108,NULL,NULL,'L R Charges','','',200,9),
(549,63,85,108,NULL,NULL,'','','',0,10),
(550,63,85,108,NULL,NULL,'32 Feet Container No. HR63C1052','','',0,11),
(551,64,86,113,NULL,NULL,'FRP TANK & ROMH','270','F T L',60000,1),
(552,64,86,113,NULL,NULL,'','','',0,2),
(553,64,86,113,NULL,NULL,'L R Charges','','',100,3),
(554,64,86,113,NULL,NULL,'','','',0,4),
(555,64,86,113,NULL,NULL,'Chennai to Nagpur','','',0,5),
(556,64,86,113,NULL,NULL,'','','',0,6),
(557,64,86,113,NULL,NULL,'32 Feet Container No. RJ14GU5162 ','','',0,7),
(558,65,87,115,NULL,NULL,'ROMH','40','F T L',34000,1),
(559,65,87,115,NULL,NULL,'','','',0,2),
(560,65,87,115,NULL,NULL,'L R Charges','','',100,3),
(561,65,87,115,NULL,NULL,'','','',0,4),
(562,65,87,115,NULL,NULL,'Chennai to Goa','','',0,5),
(563,65,87,115,NULL,NULL,'','','',0,6),
(564,65,87,115,NULL,NULL,'20 Feet Truck No. MH43BP4572','','',0,7),
(565,66,88,116,'5014','2026-08-08','ROMH','12','F T L',36000,1),
(566,66,88,116,NULL,NULL,'','','',0,2),
(567,66,88,116,'5015','2026-08-08','ROMH','27','F T L',0,3),
(568,66,88,116,NULL,NULL,'','','',0,4),
(569,66,88,116,NULL,NULL,'L R Charges','','',200,5),
(570,66,88,116,NULL,NULL,'','','',0,6),
(571,66,88,116,NULL,NULL,'Chennai to Goa','','',0,7),
(572,66,88,116,NULL,NULL,'','','',0,8),
(573,66,88,116,NULL,NULL,'22 Feet Truck No. : MH09GJ-9574','','',0,9),
(574,67,89,117,NULL,NULL,'ROMH','13','F T L',38000,1),
(575,67,89,117,NULL,NULL,'','','',0,2),
(576,67,89,117,NULL,NULL,'Chennai to Pune','','',0,3),
(577,67,89,117,NULL,NULL,'','','',0,4),
(578,67,89,117,NULL,NULL,'22 Feet Open Truck No. : MH11DD7167','','',0,5),
(579,68,90,118,NULL,NULL,'ANIMAL FEEDS','08','1000 KG',7000,1),
(580,68,90,118,NULL,NULL,'','','',0,2),
(581,68,90,118,NULL,NULL,'Tondiarpet to Thervoy Kandigai','','',0,3),
(582,68,90,118,NULL,NULL,'','','',0,4),
(583,68,90,118,NULL,'2026-08-11','EMPTY TRAY','07','F T L',0,5),
(584,68,90,118,NULL,NULL,'','','',0,6),
(585,68,90,118,NULL,NULL,'Thervoy Kandigai to Tondiarpet','','',0,7),
(586,68,90,118,NULL,NULL,'','','',0,8),
(587,68,90,118,NULL,NULL,'Container No. TN03AE5173','','',0,9),
(588,69,91,119,NULL,NULL,'ANIMAL FEEDS','08','1000 KG',5000,1),
(589,69,91,119,NULL,NULL,'','','',0,2),
(590,69,91,119,NULL,NULL,'Tondiarpet to Thervoy Kandigai','','',0,3),
(591,69,91,119,NULL,NULL,'','','',0,4),
(592,69,91,119,NULL,NULL,'Container No. TN03AE5173','','',0,5),
(593,70,92,120,NULL,NULL,'1.5 MRI ELECTRONICS','42','F T L',85000,1),
(594,70,92,120,NULL,NULL,'','','',0,2),
(595,70,92,120,NULL,NULL,'Chennai to Vizag','','',0,3),
(596,70,92,120,NULL,NULL,'','','',0,4),
(597,70,92,120,NULL,NULL,'40 Feet Open Trailer','','',0,5),
(598,70,92,120,NULL,NULL,'','','',0,6),
(599,70,92,120,NULL,NULL,'Vehicle No. : AP39WS7279','','',0,7),
(600,71,93,121,'-',NULL,'Used Household Goods','Asper List','F T L',7000,1),
(601,71,93,121,NULL,NULL,'','','',0,2),
(602,71,93,121,NULL,NULL,'Chennai Local ','','',0,3),
(603,71,93,121,NULL,NULL,'','','',0,4),
(604,71,93,121,NULL,NULL,'20 Feet Container','','',0,5),
(605,71,93,121,NULL,NULL,'','','',0,6),
(606,71,93,121,NULL,NULL,'A/C.MR.SHIVA KUMAR','','',0,7),
(607,72,94,122,NULL,NULL,'ROMH & FRP TANK','212','F T L',46000,1),
(608,72,94,122,NULL,NULL,'','','',0,2),
(609,72,94,122,NULL,NULL,'L R Charges','','',100,3),
(610,72,94,122,NULL,NULL,'','','',0,4),
(611,72,94,122,NULL,NULL,'Chennai to Pune','','',0,5),
(612,72,94,122,NULL,NULL,'','','',0,6),
(613,72,94,122,NULL,NULL,'32 Feet Container No. : MH12WX0569','','',0,7),
(614,73,95,123,'404','2026-08-25','ROMH','06','F T L',21000,1),
(615,73,95,123,NULL,NULL,'','','',0,2),
(616,73,95,123,'405','2026-08-25','ROMH','01','F T L',0,3),
(617,73,95,123,NULL,NULL,'','','',0,4),
(618,73,95,123,NULL,NULL,'L R Charges','','',200,5),
(619,73,95,123,NULL,NULL,'','','',0,6),
(620,73,95,123,NULL,NULL,'Chennai to Thirupur','','',0,7),
(621,73,95,123,NULL,NULL,'','','',0,8),
(622,73,95,123,NULL,NULL,'22 Feet Open Truck No. : TN38DR5251','','',0,9),
(623,74,96,124,'5021','2026-08-16','CT SCAN & MRI ACCESSORIES','13','F T L',442000,1),
(624,74,96,124,NULL,NULL,'','','',0,2),
(625,74,96,124,NULL,NULL,'Vizag to New Delhi','','',0,3),
(626,74,96,124,NULL,NULL,'','','',0,4),
(627,74,96,124,'5022','2026-08-23','CT SCAN & MRI ACCESSORIES','13','F T L',0,5),
(628,74,96,124,NULL,NULL,'','','',0,6),
(629,74,96,124,NULL,NULL,'New Delhi to Vizag','','',0,7),
(630,74,96,124,NULL,NULL,'','','',0,8),
(631,74,96,124,NULL,NULL,'40 Feet Open Trailer No. AP39WP9779','','',0,9),
(632,75,97,147,NULL,NULL,'','','',1000,1),
(633,76,98,148,NULL,NULL,'','','',1000,1),
(634,77,99,109,NULL,NULL,'','','',11100,1),
(635,78,100,111,NULL,NULL,'','','',11500,1),
(636,79,101,112,NULL,NULL,'','','',16098,1),
(637,80,102,125,NULL,NULL,'','','',19440,1),
(638,81,103,126,NULL,NULL,'','','',12860,1),
(639,82,104,127,NULL,NULL,'','','',18704,1),
(640,83,105,128,NULL,NULL,'','','',9100,1),
(641,84,106,129,NULL,NULL,'','','',19017,1),
(642,85,107,130,NULL,NULL,'','','',22970,1),
(643,86,108,131,NULL,NULL,'','','',10100,1),
(644,87,109,132,NULL,NULL,'','','',11830,1),
(645,88,110,133,NULL,NULL,'','','',15853,1),
(646,89,111,149,NULL,NULL,'Used Household Goods','41','F T L',28000,1),
(647,89,111,149,NULL,NULL,'','','',0,2),
(648,89,111,149,NULL,NULL,'Chennai to Wellington','','',0,3),
(649,89,111,149,NULL,NULL,'','','',0,4),
(650,89,111,149,NULL,NULL,'20 Feet Container No.TN66AV1499','','',0,5),
(651,89,111,149,NULL,NULL,'','','',0,6),
(652,89,111,149,NULL,NULL,'A/c.Michael King','','',0,7),
(653,90,112,150,'411','2026-09-01','ROMH','293','F T L',72000,1),
(654,90,112,150,NULL,NULL,'','','',0,2),
(655,90,112,150,NULL,NULL,'(Chennai to Surat)','','',0,3),
(656,90,112,150,NULL,NULL,'','','',0,4),
(657,90,112,150,'412','2026-09-01','ROMH','486','F T L',0,5),
(658,90,112,150,NULL,NULL,'','','',0,6),
(659,90,112,150,NULL,NULL,'(Chennai to Ahmedabad)','','',0,7),
(660,90,112,150,NULL,NULL,'','','',0,8),
(661,90,112,150,NULL,NULL,'L R Charges','','',200,9),
(662,90,112,150,NULL,NULL,'','','',0,10),
(663,90,112,150,NULL,NULL,'32 Feet Closed Container','','',0,11),
(664,90,112,150,NULL,NULL,'','','',0,12),
(665,90,112,150,NULL,NULL,'Container No. : KA01AT0710','','',0,13),
(666,91,113,151,NULL,NULL,'ROMH & FRP TANK','170','F T L',32000,1),
(667,91,113,151,NULL,NULL,'','','',0,2),
(668,91,113,151,NULL,NULL,'L R Charges','','',100,3),
(669,91,113,151,NULL,NULL,'','','',0,4),
(670,91,113,151,NULL,NULL,'Chennai to Secundrabad','','',0,5),
(671,91,113,151,NULL,NULL,'','','',0,6),
(672,91,113,151,NULL,NULL,'22 Feet Container No. : TN56S2121','','',0,7),
(673,92,114,152,NULL,NULL,'PRESSURE TUBES','02','F T L',19000,1),
(674,92,114,152,NULL,NULL,'','','',0,2),
(675,92,114,152,NULL,NULL,'L R Charges','','',100,3),
(676,92,114,152,NULL,NULL,'','','',0,4),
(677,92,114,152,NULL,NULL,'Chennai to Perambalur','','',0,5),
(678,92,114,152,NULL,NULL,'','','',0,6),
(679,92,114,152,NULL,NULL,'22 Feet Open Truck No. : TN48BW8131','','',0,7),
(680,93,115,153,NULL,NULL,'FRP TANK & ROMH','180','F T L',32000,1),
(681,93,115,153,NULL,NULL,'','','',0,2),
(682,93,115,153,NULL,NULL,'L R Charges','','',100,3),
(683,93,115,153,NULL,NULL,'','','',0,4),
(684,93,115,153,NULL,NULL,'Chennai to Secundrabad','','',0,5),
(685,93,115,153,NULL,NULL,'','','',0,6),
(686,93,115,153,NULL,NULL,'22 Feet Container No. : TN16J8069','','',0,7),
(701,94,116,134,'370',NULL,'H L MEDICINES','486','F T L',19300,1),
(702,94,116,134,NULL,NULL,'','','',0,2),
(703,94,116,134,NULL,NULL,'Unloading Charges ','',' ',5760,3),
(704,94,116,134,NULL,NULL,'(Written in Our LR Copy)','','',0,4),
(705,94,116,134,NULL,NULL,' ','','',0,5),
(706,94,116,134,'371',NULL,'H L MEDICINES','70`','F T L',0,6),
(707,94,116,134,NULL,NULL,' ','','',0,7),
(708,94,116,134,NULL,NULL,'Unloading Charges ','','',1000,8),
(709,94,116,134,NULL,NULL,'(Written in Our LR Copy)','','',0,9),
(710,94,116,134,NULL,NULL,'','','',0,10),
(711,94,116,134,NULL,NULL,'L R Charges','','',100,11),
(712,94,116,134,NULL,NULL,'','','',0,12),
(713,94,116,134,NULL,NULL,'Chennai to Bangalore','','',0,13),
(714,94,116,134,NULL,NULL,'','','',0,14),
(715,94,116,134,NULL,NULL,'20 Feet Container No. : KA04AC5639','','',0,15),
(716,94,116,134,NULL,NULL,'','','',0,16),
(717,94,116,134,NULL,NULL,'Note: Loading Charges Rs.1890 paid by us.','','',0,17),
(726,95,118,141,NULL,NULL,'MEDICINE RAW MATERIALS','136','F T L',10700,1),
(727,95,118,141,NULL,NULL,'','','',0,2),
(728,95,118,141,NULL,NULL,'L R Charges','','',50,3),
(729,95,118,141,NULL,NULL,'','','',0,4),
(730,95,118,141,NULL,NULL,'Tondiarpet to Oragadam','','',0,5),
(731,95,118,141,NULL,NULL,'','','',0,6),
(732,95,118,141,NULL,NULL,'20 Feet Container No. : TN20DH9680','','',0,7),
(733,95,118,141,NULL,NULL,'Note: Loading Charges Rs.700 Paid By us.','','',0,8),
(734,95,119,144,NULL,NULL,'EMPTY BOTTLES','20','F T L',10700,1),
(735,95,119,144,NULL,NULL,'','','',0,2),
(736,95,119,144,NULL,NULL,'L R Charges','','',50,3),
(737,95,119,144,NULL,NULL,'','','',0,4),
(738,95,119,144,NULL,NULL,'Tondiarpet to Oragadam','','',0,5),
(739,95,119,144,NULL,NULL,'','','',0,6),
(740,95,119,144,NULL,NULL,'20 Feet Container No. : TN20DH9680','','',0,7),
(741,95,119,144,NULL,NULL,'Note: Loading Charges Rs.700 Paid By us.','','',0,8),
(742,96,120,135,NULL,NULL,'MEDICINES','01','F T L',2500,1),
(743,96,120,135,NULL,NULL,'','','',0,2),
(744,96,120,135,NULL,NULL,'THIRURANI CFS, MADHAVARAM TO TONDIARPET FACTORY','','',0,3),
(745,96,120,135,NULL,NULL,'','','',0,4),
(746,96,120,135,NULL,NULL,'Container No. TN02BP1046','','',0,5),
(747,96,121,142,'-','2026-08-21','MEDICINES','05','F T L',4500,1),
(748,96,121,142,NULL,NULL,'','','',0,2),
(749,96,121,142,NULL,NULL,'THIRURANI CFS, MADHAVARAM TO TONDIARPET FACTORY','','',0,3),
(750,96,121,142,NULL,NULL,'','','',0,4),
(751,96,121,142,NULL,NULL,'17 feet container No.TN18AB2214','','',0,5),
(752,96,122,154,'-',NULL,'MEDICINES','45','F T L',2500,1),
(753,96,122,154,NULL,NULL,'','','',0,2),
(754,96,122,154,NULL,NULL,'TRIWAY CFS, NAPPALAYAM TO TONDIARPET FACTORY BOLERO - CLOSED','','',0,3),
(755,96,122,154,NULL,NULL,'','','',0,4),
(756,96,122,154,NULL,NULL,'Container No. : TN18BX3534','','',0,5),
(757,95,117,137,'5020',NULL,'EMPTY DRUMS & MEDICINES','145','F T L',9200,1),
(758,95,117,137,NULL,NULL,'','','',0,2),
(759,95,117,137,NULL,NULL,'L R Charges','','',50,3),
(760,95,117,137,NULL,NULL,'','','',0,4),
(761,95,117,137,NULL,NULL,'Tondiarpet to Oragadam','','',0,5),
(762,95,117,137,NULL,NULL,'','','',0,6),
(763,95,117,137,NULL,NULL,'17 Feet Container No. : TN32T0149','','',0,7),
(764,95,117,137,NULL,NULL,'Note: Loading Charges Rs.700 Paid By us.','','',0,8),
(765,97,123,136,NULL,NULL,'AQUA PRODUCTS & H L MEDICINES','627','F T L',59200,1),
(766,97,123,136,NULL,NULL,'','','',0,2),
(767,97,123,136,NULL,NULL,'L R Charges','','',50,3),
(768,97,123,136,NULL,NULL,'','','',0,4),
(769,97,123,136,NULL,NULL,'Unloading Charges At Bhubaneshwar','','',2822,5),
(770,97,123,136,NULL,NULL,'(Written in Our LR Copy Backside)','','',0,6),
(771,97,123,136,NULL,NULL,'Chennai to Bhubaneshwar','','',0,7),
(772,97,123,136,NULL,NULL,'20 Feet Container No. TN18CC6148','','',0,8),
(773,97,123,136,NULL,NULL,'Note: Loading Charges Rs.2240 paid by us.','','',0,9),
(774,97,124,138,NULL,NULL,'AQUA PRODUCTS & H L MEDICINES','550','F T L',26000,1),
(775,97,124,138,NULL,NULL,'','','',0,2),
(776,97,124,138,NULL,NULL,'L R Charges','','',50,3),
(777,97,124,138,NULL,NULL,'','','',0,4),
(778,97,124,138,NULL,NULL,'Unloading Charges At Vijayawada','','',550,5),
(779,97,124,138,NULL,NULL,'(Unloading slip enclosed)','','',0,6),
(780,97,124,138,NULL,NULL,'Chennai to Vijayawada','','',0,7),
(781,97,124,138,NULL,NULL,'20 Feet Container No. TN12AS8949','','',0,8),
(782,97,124,138,NULL,NULL,'Note: Loading Charges Rs.2030 paid by us.','','',0,9),
(783,97,125,139,NULL,NULL,'H L MEDICINES','1052','F T L',26000,1),
(784,97,125,139,NULL,NULL,'','','',0,2),
(785,97,125,139,NULL,NULL,'L R Charges','','',50,3),
(786,97,125,139,NULL,NULL,'','','',0,4),
(787,97,125,139,NULL,NULL,'Unloading Charges At Vijayawada','','',1050,5),
(788,97,125,139,NULL,NULL,'(Unloading slip enclosed)','','',0,6),
(789,97,125,139,NULL,NULL,'Chennai to Vijayawada','','',0,7),
(790,97,125,139,NULL,NULL,'20 Feet Container No. TN48BZ8579','','',0,8),
(791,97,125,139,NULL,NULL,'Note: Loading Charges Rs.2507 paid by us.','','',0,9),
(792,97,126,140,NULL,NULL,'AQUA PRODUCTS & H L MEDICINES','773','F T L',57900,1),
(793,97,126,140,NULL,NULL,'','','',0,2),
(794,97,126,140,NULL,NULL,'L R Charges','','',50,3),
(795,97,126,140,NULL,NULL,'','','',0,4),
(796,97,126,140,NULL,NULL,'Unloading Charges At Bhubaneshwar','','',3479,5),
(797,97,126,140,NULL,NULL,'(Written in Our LR Copy Backside)','','',0,6),
(798,97,126,140,NULL,NULL,'Chennai to Bhubaneshwar','','',0,7),
(799,97,126,140,NULL,NULL,'20 Feet Container No. TN18BH3638','','',0,8),
(800,97,126,140,NULL,NULL,'Note: Loading Charges Rs.1927 paid by us.','','',0,9),
(801,97,126,140,NULL,NULL,'','','',0,10),
(802,97,127,143,NULL,NULL,'H L MEDICINES','733','F T L',25800,1),
(803,97,127,143,NULL,NULL,'','','',0,2),
(804,97,127,143,NULL,NULL,'L R Charges','','',50,3),
(805,97,127,143,NULL,NULL,'','','',0,4),
(806,97,127,143,NULL,NULL,'Unloading Charges At Vijayawada','','',740,5),
(807,97,127,143,NULL,NULL,'(Unloading slip enclosed)','','',0,6),
(808,97,127,143,NULL,NULL,'Chennai to Vijayawada','','',0,7),
(809,97,127,143,NULL,NULL,'20 Feet Container No. TN48BZ8579','','',0,8),
(810,97,127,143,NULL,NULL,'Note: Loading Charges Rs.1806 paid by us.','','',0,9),
(811,97,128,145,NULL,NULL,'AQUA PRODUCTS & H L MEDICINES','429','F T L',25250,1),
(812,97,128,145,NULL,NULL,'','','',0,2),
(813,97,128,145,NULL,NULL,'L R Charges','','',50,3),
(814,97,128,145,NULL,NULL,'','','',0,4),
(815,97,128,145,NULL,NULL,'Unloading Charges At Vijayawada','','',430,5),
(816,97,128,145,NULL,NULL,'(Unloading slip enclosed)','','',0,6),
(817,97,128,145,NULL,NULL,'Chennai to Vijayawada','','',0,7),
(818,97,128,145,NULL,NULL,'20 Feet Container No. TN12AS8949','','',0,8),
(819,97,128,145,NULL,NULL,'Note: Loading Charges Rs.1270 paid by us.','','',0,9),
(820,98,129,158,NULL,NULL,'ROMH','16','F T L',20000,1),
(821,98,129,158,NULL,NULL,'','','',0,2),
(822,98,129,158,NULL,NULL,'Chennai to Pune','','',0,3),
(823,98,129,158,NULL,NULL,'','','',0,4),
(824,98,129,158,NULL,NULL,'Vehicle No. MH46CU7945','','',0,5),
(825,99,130,155,NULL,NULL,'ROMH','48','F T L',57000,1),
(826,99,130,155,NULL,NULL,'','','',0,2),
(827,99,130,155,NULL,NULL,'L R Charges','','',100,3),
(828,99,130,155,NULL,NULL,'','','',0,4),
(829,99,130,155,NULL,NULL,'Chennai to Goa','','',0,5),
(830,99,130,155,NULL,NULL,'','','',0,6),
(831,99,130,155,NULL,NULL,'32 Feet Open Truck No. : MH12QG8233','','',0,7),
(832,100,131,156,'418','2026-09-16','ROMH','29','F T L',57000,1),
(833,100,131,156,NULL,NULL,'','','',0,2),
(834,100,131,156,'419','2026-09-16','ROMH','20','F T L',0,3),
(835,100,131,156,NULL,NULL,'','','',0,4),
(836,100,131,156,NULL,NULL,'L R Charges','','',200,5),
(837,100,131,156,NULL,NULL,'','','',0,6),
(838,100,131,156,NULL,NULL,'Chennai to Goa','','',0,7),
(839,100,131,156,NULL,NULL,'','','',0,8),
(840,100,131,156,NULL,NULL,'32 Feet Truck No. : MH04LQ7169','','',0,9),
(841,101,132,159,'5033','2026-09-19','Kiosk Fabrication Body','01','F T L',8500,1),
(842,101,132,159,NULL,NULL,'','','',0,2),
(843,101,132,159,'5034','2026-09-19','Kiosk Fabrication Body','01','F T L',0,3),
(844,101,132,159,NULL,NULL,'','','',0,4),
(845,101,132,159,NULL,NULL,'Chennai to Bangalore','','',0,5),
(846,101,132,159,NULL,NULL,'','','',0,6),
(847,101,132,159,NULL,NULL,'Bolero Container No. KA51 AC 6549','','',0,7),
(848,102,133,160,NULL,NULL,'Used Household Goods','Asper List','F T L',17000,1),
(849,102,133,160,NULL,NULL,'','','',0,2),
(850,102,133,160,NULL,NULL,'Chennai to Bangalore','','',0,3),
(851,102,133,160,NULL,NULL,'','','',0,4),
(852,102,133,160,NULL,NULL,'20 Feet Container No. : TN99AF3834','','',0,5),
(853,102,133,160,NULL,NULL,'','','',0,6),
(854,102,133,160,NULL,NULL,'A/C.SINDHU BHARADWAJ','','',0,7),
(855,103,134,161,NULL,NULL,'Used Household Goods','61','F T L',16000,1),
(856,103,134,161,NULL,NULL,'','','',0,2),
(857,103,134,161,NULL,NULL,'Chennai to Bangalore','','',0,3),
(858,103,134,161,NULL,NULL,'','','',0,4),
(859,103,134,161,NULL,NULL,'20 Feet Container No. TN70AF1813','','',0,5),
(860,103,134,161,NULL,NULL,'','','',0,6),
(861,103,134,161,NULL,NULL,'A/C.SAMBA SIVA RAO JASTI','','',0,7),
(862,104,135,162,'-','2026-09-15','Used Household Goods','Asper List','F T L',4000,1),
(863,104,135,162,NULL,NULL,'','','',0,2),
(864,104,135,162,NULL,NULL,'Hastinapuram to Airport','','',0,3),
(865,104,135,162,NULL,NULL,'','','',0,4),
(866,104,135,162,NULL,NULL,'Container No. : TN18AW2000','','',0,5),
(867,104,135,162,NULL,NULL,'','','',0,6),
(868,104,135,162,NULL,NULL,'A/C.GARIPOLI GIUSEPPE','','',0,7),
(876,106,137,157,'421','2026-09-17','ROMH','01','F T L',20000,1),
(877,106,137,157,NULL,NULL,'','','',0,2),
(878,106,137,157,NULL,NULL,'Chennai to Pune','','',0,3),
(879,106,137,157,NULL,NULL,'','','',0,4),
(880,106,137,157,NULL,NULL,'Truck No. : MH46CU7945','','',0,5),
(881,107,138,164,NULL,NULL,'Used Household Goods','46','F T L',10500,1),
(882,107,138,164,NULL,NULL,'','','',0,2),
(883,107,138,164,NULL,NULL,'Chennai to Bangalore','','',0,3),
(884,107,138,164,NULL,NULL,'','','',0,4),
(885,107,138,164,NULL,NULL,'Container No. : TN73D6566','','',0,5),
(886,107,138,164,NULL,NULL,'','','',0,6),
(887,107,138,164,NULL,NULL,'A/C.SUKHDEEP SINGH JOHAR','','',0,7),
(888,108,139,165,NULL,NULL,'Used Household Goods','62','F T L',28000,1),
(889,108,139,165,NULL,NULL,'','','',0,2),
(890,108,139,165,NULL,NULL,'Mumbai to Bangalore','','',0,3),
(891,108,139,165,NULL,NULL,'','','',0,4),
(892,108,139,165,NULL,NULL,'Container No. : KA22AA9457','','',0,5),
(893,108,139,165,NULL,NULL,'','','',0,6),
(894,108,139,165,NULL,NULL,'A/C.DIVYA GUPTA','','',0,7),
(895,109,140,166,NULL,NULL,'Used Household Goods','As per List','F T L',7500,1),
(896,109,140,166,NULL,NULL,'','','',0,2),
(897,109,140,166,NULL,NULL,'Manpower Charges ','','',0,3),
(898,109,140,166,NULL,NULL,'','','',0,4),
(899,109,140,166,NULL,NULL,'A/C.KEITARO','','',0,5),
(900,110,141,167,'-','2026-09-29','Used Household Goods','22','F T KL',9000,1),
(901,110,141,167,NULL,NULL,'','','',0,2),
(902,110,141,167,NULL,NULL,'Chennai to Bangalore','','',0,3),
(903,110,141,167,NULL,NULL,'','','',0,4),
(904,110,141,167,NULL,NULL,'Container No. : TN18AT3957','','',0,5),
(905,111,142,168,NULL,NULL,'','','',10000,1),
(906,112,143,169,NULL,NULL,'','','',10000,1),
(907,113,144,170,'-','2026-10-01','Used Household Goods','Asper List','F T L',9500,1),
(908,113,144,170,NULL,NULL,'','','',0,2),
(909,113,144,170,NULL,NULL,'Chennai to Bangalore','','',0,3),
(910,113,144,170,NULL,NULL,'','','',0,4),
(911,113,144,170,NULL,NULL,'Container No. : TN73AK9390','','',0,5),
(912,114,145,171,NULL,NULL,'ROMH','09','F T L',12000,1),
(913,114,145,171,NULL,NULL,'','','',0,2),
(914,114,145,171,NULL,NULL,'Chennai to Pondicheery','','',0,3),
(915,114,145,171,NULL,NULL,'','','',0,4),
(916,114,145,171,NULL,NULL,'Truck No. : TN32H8364','','',0,5),
(917,114,145,171,NULL,NULL,'','','',0,6),
(918,115,146,172,NULL,NULL,'','','',5000,1),
(919,116,147,173,NULL,NULL,'','','',15477,1),
(920,117,148,174,NULL,NULL,'','','',11100,1),
(921,118,149,175,NULL,NULL,'','','',13828,1),
(922,119,150,176,NULL,NULL,'','','',11630,1),
(923,120,151,177,NULL,NULL,'','','',13576,1),
(924,121,152,178,NULL,NULL,'','','',11234,1),
(925,122,153,179,NULL,NULL,'','','',18989,1),
(926,123,154,180,NULL,NULL,'','','',12100,1),
(927,124,155,181,NULL,NULL,'','','',13165,1),
(928,125,156,182,NULL,NULL,'','','12100',12100,1),
(929,126,157,183,NULL,NULL,'','','',12100,1),
(930,127,158,184,NULL,NULL,'','','',22120,1),
(931,128,159,185,NULL,NULL,'','','',15854,1),
(932,129,160,186,NULL,NULL,'','','',32735,1),
(933,130,161,187,NULL,NULL,'WATER TREATMENT ITEMS','05','F T L',31000,1),
(934,130,161,187,NULL,NULL,'','','',0,2),
(935,130,161,187,NULL,NULL,'L R Charges','','',100,3),
(936,130,161,187,NULL,NULL,'','','',0,4),
(937,130,161,187,NULL,NULL,'Chennai to Bellary','','',0,5),
(938,130,161,187,NULL,NULL,'','','',0,6),
(939,130,161,187,NULL,NULL,'Truck No.MH11CH6396','','',0,7),
(940,131,162,188,NULL,NULL,'MRI COMPONENTS','05','F T L',82000,1),
(941,131,162,188,NULL,NULL,'','','',0,2),
(942,131,162,188,NULL,NULL,'Vizag to Chennai','','',0,3),
(943,131,162,188,NULL,NULL,'','','',0,4),
(944,131,162,188,NULL,NULL,'40 Feet Trailer No. : AP16TX6427','','',0,5),
(945,132,163,191,NULL,NULL,'AQUA PRODUCTS','458','F T L',25750,1),
(946,132,163,191,NULL,NULL,'','','',0,2),
(947,132,163,191,NULL,NULL,'L R Charges','','',50,3),
(948,132,163,191,NULL,NULL,'','','',0,4),
(949,132,163,191,NULL,NULL,'Unloading charges at Vijayawada','','',460,5),
(950,132,163,191,NULL,NULL,'','','',0,6),
(951,132,163,191,NULL,NULL,'Chennai to Vijayawada','','',0,7),
(952,132,163,191,NULL,NULL,'','','',0,8),
(953,132,163,191,NULL,NULL,'20 Feet Container No. : TN10U8033','','',0,9),
(954,132,163,191,NULL,NULL,'Note: Loading Charges Rs.1780 paid by us.','','',0,10),
(955,132,163,191,NULL,NULL,'','','',0,11),
(956,132,164,199,NULL,NULL,'AQUA PRODUCTS','407','F T L',25550,1),
(957,132,164,199,NULL,NULL,'','','',0,2),
(958,132,164,199,NULL,NULL,'L R Charges','','',50,3),
(959,132,164,199,NULL,NULL,'','','',0,4),
(960,132,164,199,NULL,NULL,'Unloading charges at Vijayawada','','',410,5),
(961,132,164,199,NULL,NULL,'','','',0,6),
(962,132,164,199,NULL,NULL,'Chennai to Vijayawada','','',0,7),
(963,132,164,199,NULL,NULL,'','','',0,8),
(964,132,164,199,NULL,NULL,'20 Feet Container No. : TN10U8033','','',0,9),
(965,132,164,199,NULL,NULL,'Note: Loading Charges Rs.1574 paid by us.','','',0,10),
(966,133,165,193,NULL,NULL,'AQUA PRODUCST','120','F T L',16350,1),
(967,133,165,193,NULL,NULL,'','','',0,2),
(968,133,165,193,NULL,NULL,'L R Charges','','',50,3),
(969,133,165,193,NULL,NULL,'','','',0,4),
(970,133,165,193,NULL,NULL,'Chennai to Malikipuram','','',0,5),
(971,133,165,193,NULL,NULL,'','','',0,6),
(972,133,165,193,NULL,NULL,'Vehicle No. : AP39WF8767','','',0,7),
(973,133,165,193,NULL,NULL,'Note: Loading Charges Rs.360 paid by us.','','',0,8),
(974,133,165,193,NULL,NULL,'','','',0,9),
(985,135,168,196,NULL,NULL,'AQUA PRODUCTS','127','F T L',4500,1),
(986,135,168,196,NULL,NULL,'','','',0,2),
(987,135,168,196,NULL,NULL,'L R Charges','','',50,3),
(988,135,168,196,NULL,NULL,'','','',0,4),
(989,135,168,196,NULL,NULL,'Tondiarpet to TRIWAY CFS','','',0,5),
(990,135,168,196,NULL,NULL,'','','',0,6),
(991,135,168,196,NULL,NULL,'Container No. : TN04AB0765','','',0,7),
(992,134,166,192,NULL,NULL,'MEDICINES - 08 PALLETS','140','F T L',5000,1),
(993,134,166,192,NULL,NULL,'','','',0,2),
(994,134,166,192,NULL,NULL,'L R Charges','','',50,3),
(995,134,166,192,NULL,NULL,'','','',0,4),
(996,134,166,192,NULL,NULL,'Tondiarpet to Sanco CFS','','',0,5),
(997,134,166,192,NULL,NULL,'','','',0,6),
(998,134,166,192,NULL,NULL,'Container No. : TN12AR5837','','',0,7),
(999,134,167,197,NULL,NULL,'MEDICINES','25','F T L',3500,1),
(1000,134,167,197,NULL,NULL,'','','',0,2),
(1001,134,167,197,NULL,NULL,'L R Charges','','',50,3),
(1002,134,167,197,NULL,NULL,'','','',0,4),
(1003,134,167,197,NULL,NULL,'Tondiarpet to Meenambakkam','','',0,5),
(1004,134,167,197,NULL,NULL,'','','',0,6),
(1005,134,167,197,NULL,NULL,'Container No. TN18AW2000','','',0,7),
(1013,136,170,202,NULL,NULL,'EMPTY BOTTLES','14','F T L',10000,1),
(1014,136,170,202,NULL,NULL,'','PALLETS','',0,2),
(1015,136,170,202,NULL,NULL,'','','',0,3),
(1016,136,170,202,NULL,NULL,'L R Charges','','',50,4),
(1017,136,170,202,NULL,NULL,'','','',0,5),
(1018,136,170,202,NULL,NULL,'Tondiarpet to Oragadam','','',0,6),
(1019,136,170,202,NULL,NULL,'','','',0,7),
(1020,136,170,202,NULL,NULL,'20 Feet Container No. : TN12AC4298','','',0,8),
(1021,137,171,189,NULL,NULL,'H L MEDICINES','1669','F T L',14100,1),
(1022,137,171,189,NULL,NULL,'','','',0,2),
(1023,137,171,189,NULL,NULL,'L R Charges','','',50,3),
(1024,137,171,189,NULL,NULL,'','','',0,4),
(1025,137,171,189,NULL,NULL,'Unloading Charges at Pondy','','',600,5),
(1026,137,171,189,NULL,NULL,'','','',0,6),
(1027,137,171,189,NULL,NULL,'Chennai to Pondy','','',0,7),
(1028,137,171,189,NULL,NULL,'Note: Loading charges Rs.4112 paid by us.','','',0,8),
(1029,137,172,194,NULL,NULL,'H L MEDICINES','441','F T L',14050,1),
(1030,137,172,194,NULL,NULL,'','','',0,2),
(1031,137,172,194,NULL,NULL,'L R Charges','','',50,3),
(1032,137,172,194,NULL,NULL,'','','',0,4),
(1033,137,172,194,NULL,NULL,'Unloading Charges at Bangalore','','',3087,5),
(1034,137,172,194,NULL,NULL,'','','',0,6),
(1035,137,172,194,NULL,NULL,'Chennai to Bangalore','','',0,7),
(1036,137,172,194,NULL,NULL,'','','',0,8),
(1037,137,172,194,NULL,NULL,'Container No.: TN59DV5038','','',0,9),
(1038,137,172,194,NULL,NULL,'Note: Loading Charges Rs.1087 paid by us.','','',0,10),
(1039,137,173,195,NULL,NULL,'H L MEDICINES','613','F T L',25500,1),
(1040,137,173,195,NULL,NULL,'','','',0,2),
(1041,137,173,195,NULL,NULL,'L R Charges','','',50,3),
(1042,137,173,195,NULL,NULL,'','','',0,4),
(1043,137,173,195,NULL,NULL,'Unloading Charges at Vijayawada','','',610,5),
(1044,137,173,195,NULL,NULL,'','','',0,6),
(1045,137,173,195,NULL,NULL,'Chennai to Vijayawada','','',0,7),
(1046,137,173,195,NULL,NULL,'','','',0,8),
(1047,137,173,195,NULL,NULL,'20 Feet Container No. TN18AC3279','','',0,9),
(1048,137,173,195,NULL,NULL,'Note: Loading Charges Rs.1516 paid by us.','','',0,10),
(1049,137,173,195,NULL,NULL,'','','',0,11),
(1050,137,174,200,'431','2026-09-29','H L MEDICINES','210','F T L',9850,1),
(1051,137,174,200,'432','2026-09-29','H L MEDICINES','128','F T L',0,2),
(1052,137,174,200,NULL,NULL,'','','',0,3),
(1053,137,174,200,NULL,NULL,'L R Charges','','',100,4),
(1054,137,174,200,NULL,NULL,'','','',0,5),
(1055,137,174,200,NULL,NULL,'Unloading Charges at Pondy','','',400,6),
(1056,137,174,200,NULL,NULL,'','','',0,7),
(1057,137,174,200,NULL,NULL,'Chennai to Pondy','','',0,8),
(1058,137,174,200,NULL,NULL,'','','',0,9),
(1059,137,174,200,NULL,NULL,'17 Feet Container No. TN32M8395','','',0,10),
(1060,137,174,200,NULL,NULL,'Note: Loading Charges Rs.894 paid by us.','','',0,11),
(1061,138,175,190,NULL,NULL,'MEDICINE RAW MATERIAL','43','F T L',6000,1),
(1062,138,175,190,NULL,NULL,'','','',0,2),
(1063,138,175,190,NULL,NULL,'L R Charges','','',50,3),
(1064,138,175,190,NULL,NULL,'','','',0,4),
(1065,138,175,190,NULL,NULL,'Tondiarpet to Oragadam','','',0,5),
(1066,138,175,190,NULL,NULL,'','','',0,6),
(1067,138,175,190,NULL,NULL,'Container No. : TN18AW2000','','',0,7),
(1068,138,176,201,NULL,NULL,'MEDICINE RAW MATERIALS','127','F T L',6000,1),
(1069,138,176,201,NULL,NULL,'','','',0,2),
(1070,138,176,201,NULL,NULL,'L R Charges','','',50,3),
(1071,138,176,201,NULL,NULL,'','','',0,4),
(1072,138,176,201,NULL,NULL,'Tondiarpet to Oragadam','','',0,5),
(1073,138,176,201,NULL,NULL,'','','',0,6),
(1074,138,176,201,NULL,NULL,'Container No. : TN02CA4952','','',0,7),
(1075,139,177,203,'-','2026-09-28','Used Household Goods','Asper List','F T L',7500,1),
(1076,139,177,203,NULL,NULL,'','','',0,2),
(1077,139,177,203,NULL,NULL,'Manpower & Truck Cost','','',0,3),
(1078,139,177,203,NULL,NULL,'','','',0,4),
(1079,139,177,203,NULL,NULL,'Chennai Local Usage','','',0,5),
(1080,139,177,203,NULL,NULL,'','','',0,6),
(1081,139,177,203,NULL,NULL,'A/C.KEITARO','','',0,7),
(1082,140,178,205,NULL,NULL,'Used Household Goods','67','F T L',72000,1),
(1083,140,178,205,NULL,NULL,'','','',0,2),
(1084,140,178,205,NULL,NULL,'Chennai to Kolkata','','',0,3),
(1085,140,178,205,NULL,NULL,'','','',0,4),
(1086,140,178,205,NULL,NULL,'17 Feet Container No. : DL1LAR1934','','',0,5),
(1087,140,178,205,NULL,NULL,'','','',0,6),
(1088,140,178,205,NULL,NULL,'A/C. HRISHIKESH PANDEY','','',0,7),
(1089,141,179,206,NULL,NULL,'Used Household Goods','Asper List','F T L',6000,1),
(1090,141,179,206,NULL,NULL,'','','',0,2),
(1091,141,179,206,NULL,NULL,'Chennai Fort to Astinapuram','','',0,3),
(1092,141,179,206,NULL,NULL,'','','',0,4),
(1093,141,179,206,NULL,NULL,'20 Feet Container','','',0,5),
(1094,141,179,206,NULL,NULL,'','','',0,6),
(1095,141,179,206,NULL,NULL,'A/C.LOGANATHAN','','',0,7),
(1096,142,180,207,'-','2026-10-09','AQUA PRODUCTS','12','F T L',8000,1),
(1097,142,180,207,NULL,NULL,'','','',0,2),
(1098,142,180,207,NULL,NULL,'Tondiarpet to Thervoy Kandigai','','',0,3),
(1099,142,180,207,NULL,NULL,'','','',0,4),
(1100,142,180,207,'-','2026-10-09','EMPTY BOXES','12','F T L',0,5),
(1101,142,180,207,NULL,NULL,'','','',0,6),
(1102,142,180,207,NULL,NULL,'Thervoy Kandigai to Tondiarpet','','',0,7),
(1103,142,180,207,NULL,NULL,'','','',0,8),
(1104,142,180,207,NULL,NULL,'Vehicle No. TN04BH2147','','',0,9),
(1105,143,181,208,NULL,NULL,'Machinery','04','F T L',51000,1),
(1106,143,181,208,NULL,NULL,'','','',0,2),
(1107,143,181,208,NULL,NULL,'Sricity to Daman & Diu','','',0,3),
(1108,143,181,208,NULL,NULL,'','','',0,4),
(1109,143,181,208,NULL,NULL,'20 Feet Open Truck No. : MH48DQ5707','','',0,5),
(1110,143,181,208,NULL,NULL,'','','',0,6),
(1111,143,181,208,NULL,NULL,'A/C.PANASONIC','','',0,7),
(1112,144,182,209,NULL,NULL,'Packing Materials','-','F T L',16000,1),
(1113,144,182,209,NULL,NULL,'','','',0,2),
(1114,144,182,209,NULL,NULL,'Mahindra City to SriCity','','',0,3),
(1115,144,182,209,NULL,NULL,'(Up & Down)','','',0,4),
(1116,144,182,209,NULL,NULL,'','','',0,5),
(1117,144,182,209,NULL,NULL,'Container No. : TN18AW2000','','',0,6),
(1118,144,182,209,NULL,NULL,'','','',0,7),
(1119,144,182,209,NULL,NULL,'A/C.PANASONIC','','',0,8),
(1120,144,182,209,NULL,NULL,'','','',0,9),
(1121,145,183,210,NULL,NULL,'ROMH','40','F T L',38000,1),
(1122,145,183,210,NULL,NULL,'','','',0,2),
(1123,145,183,210,NULL,NULL,'Chennai to Pune','','',0,3),
(1124,145,183,210,NULL,NULL,'','','',0,4),
(1125,145,183,210,NULL,NULL,'22 Feet Truck No. : MH12UM7016','','',0,5),
(1126,146,184,198,NULL,NULL,'ISOMALT DC 101-IMP','11','F T L',10000,1),
(1127,146,184,198,NULL,NULL,'','Pallets','',0,2),
(1128,146,184,198,NULL,NULL,'','','',0,3),
(1129,146,184,198,NULL,NULL,'L R Charges','','',50,4),
(1130,146,184,198,NULL,NULL,'','','',0,5),
(1131,146,184,198,NULL,NULL,'Chennai to Pondy','','',0,6),
(1132,146,184,198,NULL,NULL,'','','',0,7),
(1133,146,184,198,NULL,NULL,'20 Feet Container No. TN32BL1990','','',0,8),
(1134,147,185,202,NULL,NULL,'EMPTY BOTTLES','14','F T L',10000,1),
(1135,147,185,202,NULL,NULL,'','Pallets','',0,2),
(1136,147,185,202,NULL,NULL,'','','',0,3),
(1137,147,185,202,NULL,NULL,'L R Charges','','',50,4),
(1138,147,185,202,NULL,NULL,'','','',0,5),
(1139,147,185,202,NULL,NULL,'Tondiarpet to Oragadam','','',0,6),
(1140,147,185,202,NULL,NULL,'','','',0,7),
(1141,147,185,202,NULL,NULL,'20 Feet Container No. : TN12AC4298','','',0,8),
(1142,147,185,202,NULL,NULL,'','','',0,9),
(1143,147,185,202,NULL,NULL,'','','',0,10),
(1144,136,169,198,NULL,NULL,'ISOMALT DC 101-IMP','11','F T L',10000,1),
(1145,136,169,198,NULL,NULL,'','Pallets','',0,2),
(1146,136,169,198,NULL,NULL,'','','',0,3),
(1147,136,169,198,NULL,NULL,'L R Charges','','',50,4),
(1148,136,169,198,NULL,NULL,'','','',0,5),
(1149,136,169,198,NULL,NULL,'Chennai to Pondy','','',0,6),
(1150,136,169,198,NULL,NULL,'','','',0,7),
(1151,136,169,198,NULL,NULL,'20 Feet Container No. TN32BL1990','','',0,8),
(1152,148,186,213,'444','2026-10-09','ROMH','129','F T L',76000,1),
(1153,148,186,213,NULL,NULL,'','','',0,2),
(1154,148,186,213,NULL,NULL,'(Chennai to Surat)','','',0,3),
(1155,148,186,213,NULL,NULL,'','','',0,4),
(1156,148,186,213,'445','2026-10-09','ROMH','512','F T L',0,5),
(1157,148,186,213,NULL,NULL,'','','',0,6),
(1158,148,186,213,NULL,NULL,'(Chennai to Ahmedabad)','','',0,7),
(1159,148,186,213,NULL,NULL,'','','',0,8),
(1160,148,186,213,NULL,NULL,'L R Charges','','',200,9),
(1161,148,186,213,NULL,NULL,'','','',0,10),
(1162,148,186,213,NULL,NULL,'32 Feet Container No. : KA01AT0709','','',0,11),
(1163,149,187,211,NULL,NULL,'ROMH','329','F T L',38000,1),
(1164,149,187,211,NULL,NULL,'','','',0,2),
(1165,149,187,211,NULL,NULL,'L R Charges','','',100,3),
(1166,149,187,211,NULL,NULL,'','','',0,4),
(1167,149,187,211,NULL,NULL,'Chennai to Pune','','',0,5),
(1168,149,187,211,NULL,NULL,'','','',0,6),
(1169,149,187,211,NULL,NULL,'22 Feet Truck No. : MH24BW3088','','',0,7),
(1170,150,188,212,NULL,NULL,'ROMH','12','F T L',53000,1),
(1171,150,188,212,NULL,NULL,'','','',0,2),
(1172,150,188,212,NULL,NULL,'L R Charges','','',100,3),
(1173,150,188,212,NULL,NULL,'','','',0,4),
(1174,150,188,212,NULL,NULL,'Chennai to Vadodara','','',0,5),
(1175,150,188,212,NULL,NULL,'','','',0,6),
(1176,150,188,212,NULL,NULL,'20 Feet Truck No. : KA22AA4670','','',0,7),
(1177,151,189,214,'-','2026-10-20','CRANE AND MANPOWER ACTIVITY','-','F T L',15500,1),
(1178,151,189,214,NULL,NULL,'','','',0,2),
(1179,151,189,214,NULL,NULL,'A/C.CROWN FINE ARTS','','',0,3),
(1180,151,189,214,NULL,NULL,'','','',0,4),
(1181,151,189,214,NULL,NULL,'','','',0,5),
(1182,152,190,215,'-',NULL,'USED HOUSEHOLD GOODS','ASPER LIST','F T L',4500,1),
(1183,152,190,215,NULL,NULL,'','','',0,2),
(1184,152,190,215,NULL,NULL,'14 Feet Container','','',0,3),
(1185,152,190,215,NULL,NULL,'','','',0,4),
(1186,152,190,215,NULL,NULL,'Chennai Local','','',0,5),
(1187,152,190,215,NULL,NULL,'','','',0,6),
(1188,152,190,215,NULL,NULL,'A/C.FATIH GENCO AKIN','','',0,7),
(1189,153,191,216,NULL,NULL,'AQUA PRODUCTS','12','F T L',8500,1),
(1190,153,191,216,NULL,NULL,'','','',0,2),
(1191,153,191,216,NULL,NULL,'Tondiarpet to Thervoy Kandigai','','',0,3),
(1192,153,191,216,NULL,NULL,'','','',0,4),
(1193,153,191,216,NULL,'2026-10-27','EMPTY BOXES','12','F T L',0,5),
(1194,153,191,216,NULL,NULL,'','','',0,6),
(1195,153,191,216,NULL,NULL,' Thervoy Kandigai to Tondiarpet ','','',0,7),
(1196,153,191,216,NULL,NULL,'','','',0,8),
(1197,153,191,216,NULL,NULL,'407 Container No. TN20 AL 7971','','',0,9),
(1198,154,192,217,NULL,NULL,'ROMH','54','F T L',57000,1),
(1199,154,192,217,NULL,NULL,'','','',0,2),
(1200,154,192,217,NULL,NULL,'L R Charges','','',100,3),
(1201,154,192,217,NULL,NULL,'','','',0,4),
(1202,154,192,217,NULL,NULL,'Chennai to Goa','','',0,5),
(1203,154,192,217,NULL,NULL,'','','',0,6),
(1204,154,192,217,NULL,NULL,'32 Feet Truck No. : MH46DL2795','','',0,7),
(1205,155,193,218,NULL,NULL,'0.35T PICA - Whole Body MRI System','08','F T L',150000,1),
(1206,155,193,218,NULL,NULL,'','','',0,2),
(1207,155,193,218,NULL,NULL,'Vishakhapatnam to Mumbai','','',0,3),
(1208,155,193,218,NULL,NULL,'','','',0,4),
(1209,155,193,218,NULL,NULL,'40 Feet Open Trailer','','',0,5),
(1210,155,193,218,NULL,NULL,'','','',0,6),
(1211,155,193,218,NULL,NULL,'Vehicle No. : MH46DC4633','','',0,7),
(1212,156,194,219,NULL,NULL,'Zeedas 64 Slice CT','06','F T L',130000,1),
(1213,156,194,219,NULL,NULL,'','','',0,2),
(1214,156,194,219,NULL,NULL,'Chennai Airport to Nizampur(Vadodara)','','',0,3),
(1215,156,194,219,NULL,NULL,'','','',0,4),
(1216,156,194,219,NULL,NULL,'40 Feet Open Trailer','','',0,5),
(1217,156,194,219,NULL,NULL,'','','',0,6),
(1218,156,194,219,NULL,NULL,'Vehicle No. MH43CQ7889','','',0,7),
(1219,105,136,163,'-',NULL,'Used Household Goods','ASPER LIST','F T L',6000,1),
(1220,105,136,163,NULL,NULL,'','','',0,2),
(1221,105,136,163,NULL,NULL,'Chennai Local Usage','','',0,3),
(1222,105,136,163,NULL,NULL,'','','',0,4),
(1223,105,136,163,NULL,NULL,'20 Feet Container','','',0,5),
(1224,105,136,163,NULL,NULL,'','','',0,6),
(1225,105,136,163,NULL,NULL,'A/C.AGNES VILMER','','',0,7),
(1226,105,136,163,NULL,NULL,'','','',0,8),
(1227,105,136,163,NULL,NULL,'','','',0,9),
(1228,105,136,163,NULL,NULL,'','','',0,10),
(1229,105,136,163,NULL,NULL,'','','',0,11),
(1230,105,136,163,NULL,NULL,'','','',0,12),
(1231,105,136,163,NULL,NULL,'','','',0,13),
(1232,105,136,163,NULL,NULL,'','','',0,14),
(1233,105,136,163,NULL,NULL,'','','',0,15),
(1234,105,136,163,NULL,NULL,'','','',0,16),
(1235,105,136,163,NULL,NULL,'sss','','',0,17),
(1236,105,136,163,NULL,NULL,'','','',0,18),
(1237,105,136,163,NULL,NULL,'','','',0,19),
(1238,105,136,163,NULL,NULL,'','','',0,20),
(1239,105,136,163,NULL,NULL,'','','',0,21),
(1240,105,136,163,NULL,NULL,'','','',0,22),
(1241,105,136,163,NULL,NULL,'sss','','',0,23),
(1242,157,195,220,'1','2026-11-04','aa','1','1',300,1),
(1244,158,196,221,NULL,NULL,'aa','','',400,1);

/*Table structure for table `transport_bill_lr` */

DROP TABLE IF EXISTS `transport_bill_lr`;

CREATE TABLE `transport_bill_lr` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `logistics_id` int NOT NULL,
  `lr_total` double NOT NULL DEFAULT '0',
  `notes` text,
  PRIMARY KEY (`id`),
  KEY `idx_tblr_bill` (`bill_id`),
  KEY `idx_tblr_lr` (`logistics_id`)
) ENGINE=InnoDB AUTO_INCREMENT=197 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `transport_bill_lr` */

insert  into `transport_bill_lr`(`id`,`bill_id`,`logistics_id`,`lr_total`,`notes`) values 
(1,1,1,6000,NULL),
(2,2,19,3500,NULL),
(3,3,52,9000,NULL),
(4,4,57,6000,NULL),
(5,5,47,98000,NULL),
(6,6,47,98000,NULL),
(7,7,56,85000,NULL),
(8,8,58,80000,NULL),
(9,9,38,37850,NULL),
(10,10,39,31100,NULL),
(11,11,40,12820,NULL),
(12,12,43,25100,NULL),
(13,13,44,35100,NULL),
(14,14,46,16208,NULL),
(15,15,45,20809,NULL),
(16,16,49,6100,NULL),
(17,17,50,14358,NULL),
(18,18,64,1000,NULL),
(19,19,65,1000,NULL),
(20,20,69,8000,NULL),
(21,21,16,82000,NULL),
(22,21,25,84150,NULL),
(23,21,35,27060,NULL),
(24,21,37,21081,NULL),
(25,21,48,17747,NULL),
(26,21,51,26160,'TOTAL LR\'s = 06 No\'s ONLY.'),
(27,22,20,13050,NULL),
(28,22,36,4500,NULL),
(29,23,11,2500,NULL),
(30,23,30,6050,NULL),
(31,23,70,4000,NULL),
(32,24,14,15800,'(Note: loading charges Rs.800/- paid by us.)'),
(33,24,42,28765,'(Note: loading charges Rs.322/- paid by us.)'),
(34,24,53,11250,NULL),
(35,24,54,21300,'(Note: Loading charges Rs.1760 paid by us.)'),
(36,24,55,17800,NULL),
(37,25,41,10550,NULL),
(38,25,62,6050,NULL),
(39,26,73,21600,NULL),
(40,27,76,34100,NULL),
(41,28,59,11050,NULL),
(42,29,60,14298,NULL),
(43,30,61,11300,NULL),
(44,31,66,18144,NULL),
(45,32,67,18143,NULL),
(46,33,68,12540,NULL),
(47,34,74,17650,NULL),
(48,35,81,9000,NULL),
(49,36,82,77100,NULL),
(50,37,83,43500,NULL),
(51,38,84,7500,NULL),
(52,39,85,6000,NULL),
(53,40,92,6000,NULL),
(54,41,103,10000,NULL),
(55,42,104,10000,NULL),
(56,43,63,26470,NULL),
(57,43,75,27580,NULL),
(58,43,80,22266,NULL),
(59,43,88,25840,NULL),
(60,43,93,25350,NULL),
(61,44,71,16560,NULL),
(62,44,72,42550,NULL),
(63,44,101,11420,'TOTAL LR\'s = 03 No\'s ONLY.'),
(64,45,87,6050,NULL),
(65,45,94,10050,NULL),
(66,46,97,2500,NULL),
(67,47,79,10050,NULL),
(68,47,86,2550,'TOTAL LR\'s = 02 No\'s ONLY.'),
(69,48,77,8100,NULL),
(70,49,78,9300,NULL),
(71,50,96,29900,NULL),
(72,51,98,12780,NULL),
(73,52,99,13350,NULL),
(74,53,100,11789,NULL),
(75,54,89,10500,NULL),
(76,55,91,15700,NULL),
(77,56,102,29320,NULL),
(78,57,95,77100,NULL),
(79,58,105,35100,NULL),
(80,59,90,110000,NULL),
(81,59,106,110000,NULL),
(82,60,107,44200,NULL),
(83,61,110,13050,NULL),
(84,62,114,26050,NULL),
(85,63,108,80200,NULL),
(86,64,113,60100,NULL),
(87,65,115,34100,NULL),
(88,66,116,36200,NULL),
(89,67,117,38000,NULL),
(90,68,118,7000,NULL),
(91,69,119,5000,NULL),
(92,70,120,85000,NULL),
(93,71,121,7000,NULL),
(94,72,122,46100,NULL),
(95,73,123,21200,NULL),
(96,74,124,442000,NULL),
(97,75,147,1000,NULL),
(98,76,148,1000,NULL),
(99,77,109,11100,NULL),
(100,78,111,11500,NULL),
(101,79,112,16098,NULL),
(102,80,125,19440,NULL),
(103,81,126,12860,NULL),
(104,82,127,18704,NULL),
(105,83,128,9100,NULL),
(106,84,129,19017,NULL),
(107,85,130,22970,NULL),
(108,86,131,10100,NULL),
(109,87,132,11830,NULL),
(110,88,133,15853,NULL),
(111,89,149,28000,NULL),
(112,90,150,72200,NULL),
(113,91,151,32100,NULL),
(114,92,152,19100,NULL),
(115,93,153,32100,NULL),
(116,94,134,26160,'TOTAL LR\'s = 02 No\'s ONLY.'),
(117,95,137,9250,'TOTAL LR\'s = 03 No\'s ONLY.'),
(118,95,141,10750,NULL),
(119,95,144,10750,NULL),
(120,96,135,2500,NULL),
(121,96,142,4500,NULL),
(122,96,154,2500,NULL),
(123,97,136,62072,NULL),
(124,97,138,26600,NULL),
(125,97,139,27100,NULL),
(126,97,140,61429,NULL),
(127,97,143,26590,NULL),
(128,97,145,25730,'TOTAL LR\'s = 06 No\'s ONLY.'),
(129,98,158,20000,NULL),
(130,99,155,57100,NULL),
(131,100,156,57200,NULL),
(132,101,159,8500,NULL),
(133,102,160,17000,NULL),
(134,103,161,16000,NULL),
(135,104,162,4000,NULL),
(136,105,163,6000,NULL),
(137,106,157,20000,NULL),
(138,107,164,10500,NULL),
(139,108,165,28000,NULL),
(140,109,166,7500,NULL),
(141,110,167,9000,NULL),
(142,111,168,10000,NULL),
(143,112,169,10000,NULL),
(144,113,170,9500,NULL),
(145,114,171,12000,NULL),
(146,115,172,5000,NULL),
(147,116,173,15477,NULL),
(148,117,174,11100,NULL),
(149,118,175,13828,NULL),
(150,119,176,11630,NULL),
(151,120,177,13576,NULL),
(152,121,178,11234,NULL),
(153,122,179,18989,NULL),
(154,123,180,12100,NULL),
(155,124,181,13165,NULL),
(156,125,182,12100,NULL),
(157,126,183,12100,NULL),
(158,127,184,22120,NULL),
(159,128,185,15854,NULL),
(160,129,186,32735,NULL),
(161,130,187,31100,NULL),
(162,131,188,82000,NULL),
(163,132,191,26260,NULL),
(164,132,199,26010,NULL),
(165,133,193,16400,NULL),
(166,134,192,5050,NULL),
(167,134,197,3550,NULL),
(168,135,196,4550,NULL),
(169,136,198,10050,NULL),
(170,136,202,10050,NULL),
(171,137,189,14750,NULL),
(172,137,194,17187,NULL),
(173,137,195,26160,NULL),
(174,137,200,10350,'TOTAL LR\'s = 05 No\'s ONLY.'),
(175,138,190,6050,NULL),
(176,138,201,6050,'TOTAL LR\'s = 02 No\'s ONLY.'),
(177,139,203,7500,NULL),
(178,140,205,72000,NULL),
(179,141,206,6000,NULL),
(180,142,207,8000,NULL),
(181,143,208,51000,NULL),
(182,144,209,16000,NULL),
(183,145,210,38000,NULL),
(184,146,198,10050,NULL),
(185,147,202,10050,NULL),
(186,148,213,76200,NULL),
(187,149,211,38100,NULL),
(188,150,212,53100,NULL),
(189,151,214,15500,NULL),
(190,152,215,4500,NULL),
(191,153,216,8500,NULL),
(192,154,217,57100,NULL),
(193,155,218,150000,'The Freight Changes including 3 days Halting Charges at Mumbai.'),
(194,156,219,130000,NULL),
(195,157,220,300,NULL),
(196,158,221,400,NULL);

/*Table structure for table `transport_bill_order` */

DROP TABLE IF EXISTS `transport_bill_order`;

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
) ENGINE=InnoDB AUTO_INCREMENT=222 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `transport_bill_order` */

insert  into `transport_bill_order`(`id`,`supplier_id`,`vehicle_no`,`driver_phone`,`lr_date`,`lr_no`,`customer_id`,`destination`,`dpf`,`dpf_freight`,`dpf_lr_charge`,`dpf_load`,`dpf_ul`,`dpf_halting`,`lh`,`lh_paid`,`lh_balance`,`load_amt`,`ul`,`lc`,`hoting`,`is_billed`,`is_active`,`entry_user`,`cancel_uid`,`cancel_date_time`,`entry_date_time`) values 
(1,7,'TN22CR9851','','2026-06-18','111',6,'Chennai Local Services',6000,6000,0,0,0,0,5500,5000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-06-23 19:25:29'),
(2,6,'','','2026-06-01','244',5,'Vellore',21850,16500,100,0,5250,0,14000,12500,1500,100,5250,0,0,0,1,25,NULL,NULL,'2026-06-24 19:33:42'),
(3,7,'','','2026-06-01','12',6,'Chennai Local Services',5500,5500,0,0,0,0,5000,5000,0,0,0,0,0,0,1,25,NULL,NULL,'2026-06-24 19:35:55'),
(4,6,'','','2026-06-03','245\r\n246\r\n247',5,'Vellore',21400,16500,300,0,4600,0,14000,13000,1000,100,4600,0,0,0,1,25,NULL,NULL,'2026-06-24 19:43:57'),
(5,8,'','','2026-06-03','253',7,'Vizag',78000,78000,0,0,0,0,68000,50000,18000,200,0,0,0,0,1,25,NULL,NULL,'2026-06-24 19:45:51'),
(6,7,'','','2026-06-03','13',6,'Chennai Local Services',6000,6000,0,0,0,0,5500,5500,0,0,0,0,0,0,1,25,NULL,NULL,'2026-06-24 19:46:23'),
(7,16,'','','2026-06-04','248',5,'Hyderabad',36600,35000,100,0,1500,0,32000,30000,2000,100,1500,0,0,0,1,25,NULL,NULL,'2026-06-24 19:47:35'),
(8,14,'','','2026-06-04','249',5,'Kodad',48415,45000,100,0,2315,1000,40000,36000,4000,100,2315,0,1000,0,1,25,NULL,NULL,'2026-06-24 19:49:43'),
(9,9,'','','2026-06-05','259',8,'Cochin (Up and Down)',30000,30000,0,0,0,0,26000,26000,0,0,0,0,0,0,1,25,NULL,NULL,'2026-06-24 19:51:34'),
(10,7,'','','2026-06-06','14',6,'Chennai Local Services',6000,6000,0,0,0,0,5500,5500,0,0,0,0,0,0,1,25,NULL,NULL,'2026-06-24 19:52:36'),
(11,1,'','','2026-06-08','15',4,'Madavaram to Tondiarpet',2500,2500,0,0,0,0,1800,1800,0,0,0,0,0,1,1,25,NULL,NULL,'2026-06-24 19:55:09'),
(12,6,'','','2026-06-08','276277',5,'Kanchipuram/Vellore',11230,9500,200,0,1530,0,8500,7500,1000,100,1530,0,0,0,1,25,NULL,NULL,'2026-06-24 19:56:40'),
(13,6,'','','2026-06-09','278\r\n279',5,'Vellore',10120,8500,200,1420,0,0,7500,6500,1000,100,1420,0,0,0,1,25,NULL,NULL,'2026-06-24 19:58:33'),
(14,11,'','','2026-06-09','254',4,'Bangalore',15800,12000,50,750,3000,0,10000,9000,1000,800,3000,0,0,1,1,25,NULL,NULL,'2026-06-24 20:00:49'),
(15,1,'','','2026-06-09','96',6,'Bangalore',16500,16500,0,0,0,0,14500,12000,2500,0,0,0,0,0,1,25,NULL,NULL,'2026-06-24 20:01:56'),
(16,2,'','','2026-06-10','255',4,'Kolkata',82000,75000,50,2400,4550,0,67000,62000,5000,2450,5000,0,0,1,1,25,NULL,NULL,'2026-06-24 20:06:00'),
(17,6,'','','2026-06-10','280',5,'Kanchipuram',11408,9000,100,0,2308,0,8000,7000,1000,100,2308,0,0,0,1,25,NULL,NULL,'2026-06-24 20:07:05'),
(18,31,'','','2026-06-10','281',5,'Pondy',12272,11000,100,0,1172,0,9500,8500,1000,100,1172,0,0,0,1,25,NULL,NULL,'2026-06-24 20:09:48'),
(19,1,'TN03AE5173','+919962908899','2026-06-25','25',12,'Gummidipoondi',3500,3500,0,0,0,0,2800,2800,0,350,0,0,0,1,1,25,NULL,NULL,'2026-06-25 19:17:41'),
(20,23,'TN12AU1549 / TN12AU1570','9360958170','2026-06-25','269',4,'Tondiarpet to Ennore',13050,13000,50,0,0,0,12000,12000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-06-25 19:19:26'),
(21,4,'','','2026-06-11','282\r\n283',5,'Trichy/Karur',28493,26000,200,0,2293,0,24000,22500,1500,100,2293,0,0,0,1,25,NULL,NULL,'2026-06-25 21:02:31'),
(22,18,'','','2026-06-11','284\r\n285\r\n286',5,'Trichy/Dindugal',29266,27000,300,0,1966,0,24200,22200,2000,100,1966,0,0,0,1,25,NULL,NULL,'2026-06-25 21:04:33'),
(23,6,'','','2026-06-11','266',5,'Vellore to Chennai',8100,8000,100,0,0,0,8500,7500,1000,100,0,0,0,0,1,25,NULL,NULL,'2026-06-25 21:05:54'),
(24,1,'','','2026-06-11','265',5,'Kanchipuram to Chennai',7100,7000,100,0,0,0,7000,7000,0,100,0,0,0,0,1,25,NULL,NULL,'2026-06-25 21:06:47'),
(25,21,'','','2026-06-11','256',4,'Kolkata',84150,76500,50,3000,4600,0,67000,60000,7000,3025,4800,0,0,1,1,25,NULL,NULL,'2026-06-25 21:10:07'),
(26,1,'','','2026-06-11','257\r\n258',9,'Malur  to Raipur',40000,40000,0,0,0,0,36000,36000,0,0,0,0,0,0,1,25,NULL,NULL,'2026-06-25 21:14:46'),
(27,24,'','','2026-06-12','260\r\n261',5,'Hubli/Bangalore',42200,42000,200,0,0,0,38000,36000,2000,100,0,0,0,0,1,25,NULL,NULL,'2026-06-25 21:19:13'),
(28,6,'','','2026-06-12','287',5,'Kanchipuram',13750,10500,100,0,3150,0,9100,8100,1000,100,3150,0,0,0,1,25,NULL,NULL,'2026-06-25 21:20:59'),
(29,1,'','','2026-06-12','288',5,'Vellore',12155,9500,100,0,2555,0,8500,7500,1000,100,2555,0,0,0,1,25,NULL,NULL,'2026-06-25 21:22:34'),
(30,26,'','','2026-06-13','262',4,'Pondy',6050,6000,50,0,0,0,5000,5000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-06-26 19:20:23'),
(31,1,'','','2026-06-15','19',6,'Chennai Local Services',12000,12000,0,0,0,0,11000,11000,0,0,0,0,0,0,1,25,NULL,NULL,'2026-06-26 19:21:33'),
(32,10,'','','2026-06-15','289\r\n290',5,'Vilupuram',14910,11500,200,0,3210,0,10000,9000,1000,100,3210,0,0,0,1,25,NULL,NULL,'2026-06-26 19:22:49'),
(33,3,'','','2026-06-15','291\r\n292',5,'Ranipet/Vellore',11170,9500,200,0,1470,0,8500,8000,500,100,1490,0,0,0,1,25,NULL,NULL,'2026-06-26 19:24:06'),
(34,10,'','','2026-06-15','293',5,'Pondy',13064,11000,100,0,1964,0,9500,8500,1000,100,1964,0,0,0,1,25,NULL,NULL,'2026-06-26 19:25:09'),
(35,25,'','','2026-06-16','263',4,'Vijayawada',27060,24500,50,1900,610,0,23500,22000,1500,1950,610,0,0,1,1,25,NULL,NULL,'2026-06-26 19:32:06'),
(36,1,'','','2026-06-17','20',4,'Tondiarpet to Triway',4500,4500,0,0,0,0,4000,4000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-06-26 19:32:57'),
(37,1,'','','2026-06-17','264',4,'Bangalore',21081,15000,50,1600,4431,0,14000,13000,1000,1640,4431,0,0,1,1,25,NULL,NULL,'2026-06-26 19:34:24'),
(38,27,'','','2026-06-18','294',5,'Khammam',37850,37000,100,750,0,0,34000,32000,2000,100,750,0,0,1,1,25,NULL,NULL,'2026-06-26 19:41:36'),
(39,4,'','','2026-06-18','295',5,'Coimbatore',31100,31000,100,0,0,0,28000,25000,3000,100,0,0,0,1,1,25,NULL,NULL,'2026-06-26 19:44:11'),
(40,20,'','','2026-06-19','296297',5,'Ranipet/Vellore',12820,10000,200,0,2620,0,9000,8000,1000,100,2620,0,0,1,1,25,NULL,NULL,'2026-06-26 19:48:59'),
(41,7,'','','2026-06-19','267',4,'Oragadam',10550,10000,50,500,0,0,9000,9000,0,500,0,0,0,1,1,25,NULL,NULL,'2026-06-26 19:49:44'),
(42,19,'','','2026-06-20','268',4,'Gulbarga',28765,26000,50,300,2415,0,23000,22000,1000,322,2000,0,0,1,1,25,NULL,NULL,'2026-06-26 19:51:18'),
(43,4,'','','2026-06-22','298',5,'Coimbatore',25100,25000,100,0,0,0,22000,20000,2000,100,0,0,0,1,1,25,NULL,NULL,'2026-06-26 19:53:10'),
(44,5,'','','2026-06-22','299',5,'Cochin',35100,35000,100,0,0,0,32000,30000,2000,100,0,0,0,1,1,25,NULL,NULL,'2026-06-26 19:54:10'),
(45,28,'TN19AR8356','8667548642','2026-06-26','301,302,303',5,'Pondy/Karaikal',20809,18500,300,0,1309,700,17000,0,0,100,1309,0,700,1,1,25,NULL,NULL,'2026-06-26 20:09:30'),
(46,10,'TN10AF1199','9940325749','2026-06-26','300',5,'Cuddalore',16208,14000,100,0,2108,0,12000,0,0,100,2108,0,0,1,1,25,NULL,NULL,'2026-06-26 20:10:30'),
(47,8,'AP39TQ3369','9793153666','2026-06-26','0270',9,'Vizag to Chennai',98000,90000,0,0,0,8000,80000,0,80000,0,0,0,8000,1,1,25,NULL,NULL,'2026-06-26 20:15:15'),
(48,29,'KA02AL0907','7548801613','2026-06-27','271',4,'Bangalore',17747,14500,50,800,2397,0,11500,10800,700,820,2397,0,0,1,1,25,NULL,NULL,'2026-06-29 19:59:34'),
(49,30,'','','2026-06-27','330',5,'Pondy to Chennai',6100,6000,100,0,0,0,5500,5000,500,100,0,0,0,1,1,25,NULL,NULL,'2026-06-29 20:01:19'),
(50,31,'TN16L2482','8883191289','2026-06-29','304305306',5,'Vilupuram/Pondy',14358,12000,300,0,2058,0,10500,9500,1000,100,2058,0,0,1,1,25,NULL,NULL,'2026-06-29 20:04:46'),
(51,2,'TN18BH3623','8110084875','2026-06-29','272',4,'Vijayawada',26160,24000,50,1600,510,0,23000,21000,2000,1720,510,0,0,1,1,25,NULL,NULL,'2026-06-29 20:06:04'),
(52,29,'TN73AH7796','6379603001','2026-06-29','10',14,'Bangalore',9000,9000,0,0,0,0,8000,7000,1000,0,0,0,0,1,1,25,NULL,NULL,'2026-06-29 20:09:24'),
(53,14,'','','2026-06-30','273',4,'Nagapatinam',11250,11000,50,0,200,0,9500,8500,1000,0,200,0,0,1,1,25,NULL,NULL,'2026-07-02 12:06:08'),
(54,32,'','','2026-06-30','274',4,'Repalle',21300,19500,50,1750,0,0,16000,15000,1000,1760,0,0,0,1,1,25,NULL,NULL,'2026-07-02 12:07:24'),
(55,32,'','','2026-06-30','275',4,'Koduru',17800,17000,50,750,0,0,14000,13000,1000,792,0,0,0,1,1,25,NULL,NULL,'2026-07-02 12:08:11'),
(56,8,'','','2026-06-30','326',13,'Vizag',85000,85000,0,0,0,0,72000,62000,10000,0,0,0,0,1,1,25,NULL,NULL,'2026-07-02 12:09:00'),
(57,7,'','','2026-06-30','11',6,'Chennai Local',6000,6000,0,0,0,0,5500,5500,0,0,0,0,0,1,1,25,NULL,NULL,'2026-07-02 12:09:34'),
(58,8,'','','2026-07-01','327',7,'Vizag',80000,80000,0,0,0,0,70000,62000,8000,0,0,0,0,1,1,25,NULL,NULL,'2026-07-03 15:42:06'),
(59,6,'','','2026-07-01','307\r\n308',5,'Vellore',11050,9500,200,0,1350,0,8500,7500,1000,100,1350,0,0,1,1,25,NULL,NULL,'2026-07-04 21:48:52'),
(60,6,'','','2026-07-02','309310',5,'Kanchipuram',14298,11000,200,0,3098,0,9750,8750,1000,100,3098,0,0,1,1,25,NULL,NULL,'2026-07-04 21:49:57'),
(61,33,'','','2026-07-02','311\r\n312',5,'Pondy/Cuddalore',11300,10000,200,0,1100,0,8500,7500,1000,100,1100,0,0,1,1,25,NULL,NULL,'2026-07-04 21:51:37'),
(62,1,'','','2026-07-03','328',4,'Oragadam',6050,6000,50,0,0,0,5000,5000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-07-04 21:52:34'),
(63,21,'','','2026-07-04','329',4,'Vijayawada',26470,24500,50,1450,470,0,23000,21500,1500,1460,470,0,0,1,1,25,NULL,NULL,'2026-07-04 21:53:24'),
(64,16,'','','2026-06-23','001',5,'Return charges',1000,1000,0,0,0,0,2000,1000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-07-05 14:00:34'),
(65,10,'','','2026-06-29','002',5,'Return charges',1000,1000,0,0,0,0,1000,1000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-07-05 14:01:09'),
(66,10,'','','2026-07-06','313,314',5,'Vilupuram/Pondy',18144,15000,200,0,2944,0,13700,12700,1000,100,2944,0,0,1,1,25,NULL,NULL,'2026-07-10 18:58:53'),
(67,6,'','','2026-07-06','315\r\n316\r\n317\r\n318',5,'Kanchipuram/Vellore',18143,15000,400,0,2743,0,13100,12100,1000,100,2743,0,0,1,1,25,NULL,NULL,'2026-07-10 18:59:51'),
(68,28,'','','2026-07-07','319\r\n320',5,'Pondy/Cuddalore',12540,11000,200,0,1340,0,9000,8000,1000,100,1340,0,0,1,1,25,NULL,NULL,'2026-07-10 19:00:47'),
(69,1,'','','2026-07-09','250',12,'Gummidipoondi',8000,8000,0,0,0,0,5500,5500,0,1250,0,0,0,1,1,25,NULL,NULL,'2026-07-10 19:01:41'),
(70,1,'','','2026-07-10','5',4,'Ennore to Adyar',4000,4000,0,0,0,0,3500,0,0,0,0,0,0,1,1,25,NULL,NULL,'2026-07-10 19:10:39'),
(71,1,'','','2026-07-14','351',19,'Bangalore',16560,13500,50,500,2510,0,11500,10500,1000,500,2510,0,0,1,1,25,NULL,NULL,'2026-07-18 14:18:56'),
(72,19,'','','2026-07-15','352',19,'Kalaburagi',42550,32000,50,1500,9000,0,28000,26500,1500,1550,8000,0,0,1,1,25,NULL,NULL,'2026-07-18 14:20:19'),
(73,9,'','','2026-07-15','353',17,'Coimbatore',21600,21500,100,0,0,0,19000,17000,2000,0,0,0,0,1,1,25,NULL,NULL,'2026-07-18 18:54:24'),
(74,17,'','','2026-07-15','321',5,'Mayiladuturai',17650,16000,100,0,1550,0,15000,14000,1000,100,1550,0,0,1,1,25,NULL,NULL,'2026-07-18 18:55:26'),
(75,2,'','','2026-07-16','354',4,'Vijayawada',27580,24000,50,2780,750,0,22000,20000,2000,2780,750,0,0,1,1,25,NULL,NULL,'2026-07-18 18:56:38'),
(76,19,'','','2026-07-16','355',17,'Goa',34100,34000,100,0,0,0,30000,28000,2000,0,0,0,0,1,1,25,NULL,NULL,'2026-07-18 18:57:43'),
(77,34,'','','2026-07-16','359',5,'Vellore to Chennai',8100,8000,100,0,0,0,7500,6000,1500,100,0,0,0,1,1,25,NULL,NULL,'2026-07-18 18:59:22'),
(78,20,'','','2026-07-16','13478',5,'Vellore',9300,8000,0,0,1300,0,7000,6500,500,100,1300,0,0,1,1,25,NULL,NULL,'2026-07-18 19:00:25'),
(79,1,'','','2026-07-17','356',4,'TONDIARPET TO ENNORE',10050,10000,50,0,0,0,8500,8500,0,0,0,0,0,1,1,25,NULL,NULL,'2026-07-18 19:01:23'),
(80,24,'','','2026-07-17','357',4,'Bangalore',22266,16000,50,1750,4466,0,16000,15000,1000,1760,4466,0,0,1,1,25,NULL,NULL,'2026-07-18 19:02:20'),
(81,29,'','','2026-07-23','5003',14,'Bangalore',9000,9000,0,0,0,0,7500,6500,1000,0,0,0,0,1,1,25,NULL,NULL,'2026-07-24 10:55:19'),
(82,35,'','','2026-07-22','358',17,'Faridabad',77100,77000,100,0,0,0,70000,66000,4000,0,0,0,0,1,1,25,NULL,NULL,'2026-07-28 10:11:35'),
(83,2,'','','2026-07-23','5005\r\n5006',6,'Bangalore/Goa',43500,43500,0,0,0,0,38000,36000,2000,0,0,0,0,1,1,25,NULL,NULL,'2026-07-28 10:14:12'),
(84,1,'','','2026-07-23','5007',6,'Chennai Local Services',7500,7500,0,0,0,0,7000,7000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-07-28 10:14:54'),
(85,1,'','','2026-07-27','5009',6,'Chennai Local Services',6000,6000,0,0,0,0,5500,5500,0,0,0,0,0,1,1,25,NULL,NULL,'2026-07-28 10:15:27'),
(86,1,'','','2026-07-24','5002',4,'Tondiarpet to Airport',2550,2500,50,0,0,0,1600,1600,0,0,0,0,0,1,1,25,NULL,NULL,'2026-07-31 21:16:22'),
(87,1,'','','2026-07-24','5004',4,'Oragadam',6050,6000,50,0,0,0,5000,5000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-07-31 21:17:17'),
(88,25,'','','2026-07-25','360',4,'Vijayawada',25840,24000,50,1300,490,0,21500,20000,1500,1310,490,0,0,1,1,25,NULL,NULL,'2026-07-31 21:18:21'),
(89,3,'','','2026-07-27','4325',5,'Cheyyar',10500,9000,0,0,0,1500,9000,7000,2000,100,0,0,0,1,1,25,NULL,NULL,'2026-07-31 21:19:50'),
(90,36,'','','2026-07-27','5008',9,'Vizag to Mumbai',110000,110000,0,0,0,0,90000,82000,8000,0,0,0,0,1,1,25,NULL,NULL,'2026-07-31 21:21:53'),
(91,26,'','','2026-07-28','325',5,'Cuddalore',15700,13500,100,0,2100,0,12000,10000,2000,100,2100,0,0,1,1,25,NULL,NULL,'2026-07-31 21:23:14'),
(92,1,'','','2026-07-29','50091',12,'Gummidipoondi',6000,6000,0,0,0,0,4800,4800,0,350,0,0,0,1,1,25,NULL,NULL,'2026-07-31 21:23:59'),
(93,1,'','','2026-07-30','361',4,'Vijayawada',25350,24000,50,1000,300,0,21500,20000,1500,1078,300,0,0,1,1,25,NULL,NULL,'2026-07-31 21:25:40'),
(94,33,'','','2026-07-30','362',4,'Oragadam',10050,10000,50,0,0,0,9000,8500,500,0,0,0,0,1,1,25,NULL,NULL,'2026-07-31 21:26:26'),
(95,37,'','','2026-07-30','363',17,'Delhi',77100,77000,100,0,0,0,70000,65000,5000,0,0,0,0,1,1,25,NULL,NULL,'2026-07-31 21:28:46'),
(96,18,'','','2026-07-18','322',5,'Coimbatore',29900,25000,100,4800,0,0,24640,21640,3000,100,4800,0,0,1,1,25,NULL,NULL,'2026-07-31 21:37:05'),
(97,1,'','','2026-07-20','1500',4,'TRIWAY TO TONDIARPET',2500,2500,0,0,0,0,1500,1500,0,0,0,0,0,1,1,25,NULL,NULL,'2026-07-31 21:38:00'),
(98,20,'','','2026-07-21','323',5,'Vellore',12780,10000,100,0,2680,0,8800,7800,1000,100,2680,0,0,1,1,25,NULL,NULL,'2026-07-31 21:39:36'),
(99,1,'','','2026-07-22','331\r\n332',5,'Kanchipuram/Vellore',13350,10500,200,0,2650,0,9000,9000,0,100,2650,0,0,1,1,25,NULL,NULL,'2026-07-31 21:42:15'),
(100,20,'','','2026-07-23','324',5,'Kanchipuram',11789,9000,100,0,2689,0,8000,7500,500,100,2689,0,0,1,1,25,NULL,NULL,'2026-07-31 21:44:38'),
(101,13,'','','2026-07-23','5001',19,'Nagapatinam',11420,11000,50,170,200,0,9500,8500,1000,177,200,0,0,1,1,25,NULL,NULL,'2026-07-31 21:45:55'),
(102,4,'','','2026-07-31','333',5,'Thanjavur',29320,26500,100,0,2720,0,24000,22000,2000,100,2720,0,0,1,1,25,NULL,NULL,'2026-08-03 13:11:47'),
(103,1,'','','2026-07-31','01',15,'Sriram',10000,10000,0,0,0,0,10000,10000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-08-04 23:28:40'),
(104,1,'','','2026-07-31','02',15,'Sriram',10000,10000,0,0,0,0,10000,10000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-08-04 23:29:18'),
(105,19,'','','2026-08-02','366',17,'Goa',35100,34000,100,0,0,1000,31000,28500,2500,0,0,0,0,1,1,25,NULL,NULL,'2026-08-06 08:52:05'),
(106,36,'','','2026-08-02','5010',9,'Mumbai to Vizag',110000,110000,0,0,0,0,95000,92000,3000,0,0,0,0,1,1,25,NULL,NULL,'2026-08-06 12:04:19'),
(107,19,'','','2026-08-06','368\r\n369',20,'Pune/Khalapur',44200,44000,200,0,0,0,40000,38000,2000,0,0,0,0,1,1,25,NULL,NULL,'2026-08-07 12:13:58'),
(108,38,'','','2026-08-02','364\r\n365',17,'Surat/Ahmedabad',80200,80000,200,0,0,0,73000,60000,13000,500,0,0,0,1,1,25,NULL,NULL,'2026-08-10 11:27:42'),
(109,10,'','','2026-08-03','334',5,'Pondy',11100,11000,100,0,0,0,9500,8500,1000,100,0,0,0,1,1,25,NULL,NULL,'2026-08-10 11:28:55'),
(110,1,'','','2026-08-04','5011',22,'Ranipet (up&down)',13050,13000,50,0,0,0,9000,9000,0,200,0,2000,0,1,1,25,NULL,NULL,'2026-08-10 11:39:38'),
(111,28,'','','2026-08-05','2236',5,'Pondy',11500,11500,0,0,0,0,11000,10000,1000,100,0,0,0,1,1,25,NULL,NULL,'2026-08-10 11:40:32'),
(112,33,'','','2026-08-06','335\r\n336',5,'Vilupuram/Pondy',16098,13000,200,0,2898,0,11500,10500,1000,100,2898,0,0,1,1,25,NULL,NULL,'2026-08-10 11:48:25'),
(113,24,'','','2026-08-06','367',17,'Nagpur',60100,60000,100,0,0,0,54000,51000,3000,0,0,0,0,1,1,25,NULL,NULL,'2026-08-10 11:51:08'),
(114,1,'','','2026-08-07','5012',21,'Madurai',26050,26000,50,0,0,0,17500,17500,0,150,0,2000,0,1,1,25,NULL,NULL,'2026-08-10 11:52:19'),
(115,19,'','','2026-08-08','5013',17,'Goa',34100,34000,100,0,0,0,31000,29500,1500,0,0,0,0,1,1,25,NULL,NULL,'2026-08-10 11:54:07'),
(116,19,'','','2026-08-08','5014\r\n5015',17,'Goa',36200,36000,200,0,0,0,33000,31500,1500,0,0,0,0,1,1,25,NULL,NULL,'2026-08-10 11:54:49'),
(117,19,'','','2026-08-10','5016',23,'Pune',38000,38000,0,0,0,0,34500,32500,2000,0,0,0,0,1,1,25,NULL,NULL,'2026-08-12 11:03:04'),
(118,1,'','','2026-08-11','5017',12,'Thervoy Kandigai',7000,7000,0,0,0,0,4500,4500,0,650,0,0,0,1,1,25,NULL,NULL,'2026-08-13 19:48:30'),
(119,1,'','','2026-08-12','5018',12,'Thervoy Kandigai',5000,5000,0,0,0,0,3500,3500,0,650,0,0,0,1,1,25,NULL,NULL,'2026-08-13 19:49:11'),
(120,8,'','','2026-08-14','373',13,'Vizag',85000,85000,0,0,0,0,72000,67000,5000,0,0,0,0,1,1,25,NULL,NULL,'2026-08-18 10:46:47'),
(121,1,'','','2026-08-05','123',6,'Chennai Local Services',7000,7000,0,0,0,0,6500,6500,0,0,0,0,0,1,1,25,NULL,NULL,'2026-08-18 10:59:19'),
(122,38,'','','2026-08-22','403',17,'Pune',46100,46000,100,0,0,0,40000,38000,2000,0,0,0,0,1,1,25,NULL,NULL,'2026-08-28 13:15:42'),
(123,9,'','','2026-08-25','404\r\n405',17,'Thirupur',21200,21000,200,0,0,0,18500,17500,1000,0,0,0,0,1,1,25,NULL,NULL,'2026-08-28 13:21:47'),
(124,39,'','','2026-08-16','5021\r\n5022',9,'Vizag to Delhi (Up and Down)',442000,442000,0,0,0,0,350000,272000,78000,10000,19000,0,0,1,1,25,NULL,NULL,'2026-08-28 20:13:43'),
(125,17,'','','2026-08-10','337\r\n338',5,'Cuddalore/Mayilauturai',19440,17500,200,0,1740,0,16000,15000,1000,100,1740,0,0,1,1,25,NULL,NULL,'2026-09-04 11:47:22'),
(126,26,'','','2026-08-17','339\r\n340',5,'Pondy',12860,11000,200,0,1660,0,10000,10000,0,100,1660,0,0,1,1,25,NULL,NULL,'2026-09-04 11:48:28'),
(127,10,'','','2026-08-25','376\r\n377',5,'Pondy/Cuddalore',18704,18000,200,504,0,0,16000,15000,1000,100,504,0,0,1,1,25,NULL,NULL,'2026-09-04 11:49:42'),
(128,9,'','','2026-08-27','341',5,'Pondy',9100,9000,100,0,0,0,8300,7500,800,100,0,0,0,1,1,25,NULL,NULL,'2026-09-04 11:50:46'),
(129,26,'','','2026-08-27','342\r\n343',5,'Cuddalore/Mayilauturai',19017,16500,200,0,2317,0,15000,14000,1000,100,2317,0,0,1,1,25,NULL,NULL,'2026-09-04 11:51:56'),
(130,18,'','','2026-08-27','344\r\n345\r\n346',5,'Trichy/Pudukottai',22970,21000,300,0,1670,0,19000,17000,2000,100,1670,0,0,1,1,25,NULL,NULL,'2026-09-04 11:53:25'),
(131,28,'','','2026-08-27','347',5,'Pondy',10100,10000,100,0,0,0,9000,8000,1000,100,0,0,0,1,1,25,NULL,NULL,'2026-09-04 11:54:08'),
(132,1,'','','2026-08-31','348\r\n349',5,'Vellore',11830,10000,200,0,1630,0,9000,8000,1000,100,1630,0,0,1,1,25,NULL,NULL,'2026-09-04 11:55:25'),
(133,34,'','','2026-08-31','350\r\n378\r\n379',5,'Vellore/Hosur',15853,13500,300,0,1053,1000,12800,11000,1800,100,1053,0,0,1,1,25,NULL,NULL,'2026-09-04 11:56:58'),
(134,1,'','','2026-08-11','370\r\n371',19,'Bangalore',26160,17500,100,1800,6760,0,14000,13000,1000,1890,6260,0,0,1,1,25,NULL,NULL,'2026-09-04 12:04:13'),
(135,1,'','','2026-08-12','5019',4,'THIRURANI CFS TO TONDIARPET',2500,2500,0,0,0,0,1900,1900,0,0,0,0,0,1,1,25,NULL,NULL,'2026-09-04 12:04:58'),
(136,2,'','','2026-08-12','372',4,'BHUBANESHWAR',62072,57000,50,2200,2822,0,52000,49000,3000,2240,2822,0,0,1,1,25,NULL,NULL,'2026-09-04 12:11:34'),
(137,30,'','','2026-08-13','5020',4,'Oragadam',9250,8500,50,700,0,0,7700,7200,500,750,0,0,0,1,1,25,NULL,NULL,'2026-09-04 12:12:42'),
(138,1,'','','2026-08-17','374',4,'Vijayawada',26600,24000,50,2000,550,0,21500,20000,1500,2030,550,0,0,1,1,25,NULL,NULL,'2026-09-04 12:13:42'),
(139,2,'','','2026-08-19','375',4,'Vijayawada',27100,23500,50,2500,1050,0,22000,21000,1000,2507,1050,0,0,1,1,25,NULL,NULL,'2026-09-04 12:15:09'),
(140,2,'','','2026-08-20','401',4,'BHUBANESHWAR',61429,56000,50,1900,3479,0,52000,49000,3000,1927,3479,0,0,1,1,25,NULL,NULL,'2026-09-04 12:17:56'),
(141,1,'','','2026-08-20','402',4,'Oragadam',10750,10000,50,700,0,0,9000,9000,0,700,0,0,0,1,1,25,NULL,NULL,'2026-09-04 12:19:02'),
(142,1,'','','2026-08-21','121',4,'THIRURANI CFS TO TONDIARPET',4500,4500,0,0,0,0,4000,4000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-09-04 12:20:37'),
(143,1,'','','2026-08-22','406',4,'Vijayawada',26590,24000,50,1800,740,0,22000,20500,1500,1806,740,0,0,1,1,25,NULL,NULL,'2026-09-04 12:23:18'),
(144,1,'','','2026-08-26','407',4,'Oragadam',10750,10000,50,700,0,0,9000,9000,0,750,0,0,0,1,1,25,NULL,NULL,'2026-09-04 12:24:58'),
(145,1,'','','2026-08-31','408',4,'Vijayawada',25730,24000,50,1250,430,0,21500,20000,1500,1270,430,0,0,1,1,25,NULL,NULL,'2026-09-04 12:27:02'),
(146,36,'','','2026-08-31','409\r\n410',17,'Pune',60000,60000,0,0,0,0,55000,52000,3000,0,0,0,0,0,1,25,NULL,NULL,'2026-09-04 12:30:29'),
(147,1,'','','2026-08-31','10000',15,'Insurance',1000,1000,0,0,0,0,1000,1000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-09-04 12:36:04'),
(148,1,'','','2026-08-31','10001',15,'Insurance',1000,1000,0,0,0,0,1000,1000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-09-04 12:36:43'),
(149,11,'','','2026-09-02','5023',8,'Wellington',28000,28000,0,0,0,0,24000,23000,1000,0,0,0,0,1,1,25,NULL,NULL,'2026-09-04 13:04:39'),
(150,38,'','','2026-09-01','411\r\n412',17,'Surat/Ahmedabad',72200,72000,200,0,0,0,65000,61000,4000,0,0,0,0,1,1,25,NULL,NULL,'2026-09-07 20:09:26'),
(151,27,'','','2026-09-04','5024',17,'Secundrabad',32100,32000,100,0,0,0,28000,26000,2000,0,0,0,0,1,1,25,NULL,NULL,'2026-09-07 20:10:23'),
(152,9,'','','2026-09-04','5025',17,'Perambalur',19100,19000,100,0,0,0,17000,16000,1000,0,0,0,0,1,1,25,NULL,NULL,'2026-09-07 20:11:04'),
(153,2,'','','2026-09-05','415',17,'Secundrabad',32100,32000,100,0,0,0,28000,27000,1000,0,0,0,0,1,1,25,NULL,NULL,'2026-09-07 20:11:48'),
(154,1,'','','2026-09-10','95',4,'TRIWAY CFS, NAPPALAYAM TO TONDIARPET FACTORY',2500,2500,0,0,0,0,2000,2000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-09-10 19:04:07'),
(155,40,'','','2026-09-16','417',17,'Gao',57100,57000,100,0,0,0,51000,51000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-09-21 13:26:26'),
(156,40,'','','2026-09-16','418\r\n419',17,'Goa',57200,57000,200,0,0,0,51000,51000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-09-21 13:28:16'),
(157,19,'','','2026-09-17','420421',27,'Pune',20000,20000,0,0,0,0,18000,17000,1000,0,0,0,0,1,1,25,NULL,NULL,'2026-09-21 13:30:37'),
(158,19,'','','2026-09-17','422',25,'Pune',20000,20000,0,0,0,0,18000,17000,1000,0,0,0,0,1,1,25,NULL,NULL,'2026-09-21 13:33:18'),
(159,29,'','','2026-09-19','5033\r\n5034',26,'Bangalore',8500,8500,0,0,0,0,7500,7000,500,0,0,0,0,1,1,25,NULL,NULL,'2026-09-21 13:46:54'),
(160,1,'','','2026-09-11','5029',6,'Bangalore',17000,17000,0,0,0,0,15000,13000,2000,0,0,0,0,1,1,25,NULL,NULL,'2026-09-21 13:52:25'),
(161,1,'','','2026-09-12','5035',6,'Bangalore',16000,16000,0,0,0,0,13000,12000,1000,0,0,0,0,1,1,25,NULL,NULL,'2026-09-21 13:54:36'),
(162,1,'','','2026-09-15','NA',6,'Airport',4000,4000,0,0,0,0,3500,3500,0,0,0,0,0,1,1,25,NULL,NULL,'2026-09-21 13:55:17'),
(163,1,'','','2026-09-15','NO',6,'Local',6000,6000,0,0,0,0,5500,5500,0,0,0,0,0,1,1,25,NULL,NULL,'2026-09-21 13:56:21'),
(164,29,'','','2026-09-11','5026',21,'Bangalore',10500,10500,0,0,0,0,8000,7500,500,200,0,1000,0,1,1,25,NULL,NULL,'2026-09-28 13:06:22'),
(165,36,'','','2026-09-23','5036',6,'Mumbai to Bangalore',28000,28000,0,0,0,0,25000,25000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-10-04 19:37:18'),
(166,1,'','','2026-10-28','N',6,'Manpower',7500,7500,0,0,0,0,6500,6500,0,0,0,0,0,1,1,25,NULL,NULL,'2026-10-04 19:43:53'),
(167,29,'','','2026-09-29','NW',14,'Bangalore',9000,9000,0,0,0,0,8000,7500,500,0,0,0,0,1,1,25,NULL,NULL,'2026-10-04 19:51:53'),
(168,1,'','','2026-09-30','IN',15,'Insurance',10000,10000,0,0,0,0,10000,10000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-10-04 19:57:57'),
(169,1,'','','2026-09-30','INS',15,'Insurance',10000,10000,0,0,0,0,10000,10000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-10-04 19:58:30'),
(170,29,'','','2026-10-01','NEE',14,'Bangalore',9500,9500,0,0,0,0,8500,8000,500,0,0,0,0,1,1,25,NULL,NULL,'2026-10-04 20:49:37'),
(171,26,'','','2026-10-05','443',28,'Pondicherry',12000,12000,0,0,0,0,10000,9000,1000,0,0,0,0,1,1,25,NULL,NULL,'2026-10-06 09:46:19'),
(172,1,'','','2026-09-01','13816',5,'Kanchipuram to Chennai',5000,5000,0,0,0,0,4000,4000,0,100,0,0,0,1,1,25,NULL,NULL,'2026-10-07 19:32:24'),
(173,20,'','','2026-09-01','380\r\n381',5,'Kanchipuram/Vellore',15477,12000,200,0,3277,0,10200,9200,1000,100,3277,0,0,1,1,25,NULL,NULL,'2026-10-07 19:34:14'),
(174,10,'','','2026-09-08','382',5,'Pondy',11100,11000,100,0,0,0,10000,9000,1000,100,0,0,0,1,1,25,NULL,NULL,'2026-10-07 19:36:26'),
(175,31,'','','2026-09-08','383\r\n384',5,'Pondy',13828,12000,200,0,1628,0,10500,9000,1500,100,1628,0,0,1,1,25,NULL,NULL,'2026-10-07 19:38:01'),
(176,28,'','','2026-09-09','385\r\n386',5,'Tindivanam/Vilupuram',11630,9500,200,0,1930,0,8500,7500,1000,100,1930,0,0,1,1,25,NULL,NULL,'2026-10-07 19:39:10'),
(177,33,'','','2026-09-11','387\r\n388',5,'Cuddalore/Pondy',13576,11500,200,0,1876,0,10000,9000,1000,100,1876,0,0,1,1,25,NULL,NULL,'2026-10-07 19:40:29'),
(178,6,'','','2026-09-16','389',5,'Kanchipuram',11234,9000,100,0,2134,0,8000,7000,1000,100,2134,0,0,1,1,25,NULL,NULL,'2026-10-07 19:41:35'),
(179,12,'','','2026-09-21','390\r\n391\r\n392',5,'Ulundurpet/Trichy',18989,17500,300,0,1189,0,16000,15000,1000,100,1189,0,0,1,1,25,NULL,NULL,'2026-10-07 19:42:52'),
(180,1,'','','2026-09-23','393',5,'Kanchipuram',12100,9500,100,0,2500,0,8000,7000,1000,100,2500,0,0,1,1,25,NULL,NULL,'2026-10-07 19:44:06'),
(181,1,'','','2026-09-25','394\r\n395\r\n396',5,'Kanchipuram/Vellore',13165,10500,300,2365,0,0,9000,8000,1000,100,2365,0,0,1,1,25,NULL,NULL,'2026-10-07 19:45:27'),
(182,13,'','','2026-09-26','397',5,'Pondy',12100,12000,100,0,0,0,11000,9000,2000,100,0,0,0,1,1,25,NULL,NULL,'2026-10-07 19:46:52'),
(183,26,'','','2026-09-26','398\r\n',5,'Pondy',12100,12000,100,0,0,0,11000,9000,2000,100,0,0,0,1,1,25,NULL,NULL,'2026-10-07 19:47:33'),
(184,24,'','','2026-09-26','399',5,'Cuddalore',22120,18500,100,0,3520,0,16900,15900,1000,100,3520,0,0,1,1,25,NULL,NULL,'2026-10-07 19:48:52'),
(185,26,'','','2026-09-28','426\r\n427\r\n427',5,'Pondy/Cuddalore',15854,13500,300,0,2054,0,12000,11000,1000,100,2054,0,0,1,1,25,NULL,NULL,'2026-10-07 19:49:55'),
(186,4,'','','2026-09-30','434-435-436-\r\n437-438',5,'Erode/Salem/Coimbatore',32735,30000,500,0,2235,0,28000,26000,2000,100,2235,0,0,1,1,25,NULL,NULL,'2026-10-07 19:52:17'),
(187,24,'','','2026-09-29','430',17,'Bellary',31100,31000,100,0,0,0,28000,26000,2000,0,0,0,0,1,1,25,NULL,NULL,'2026-10-07 20:06:03'),
(188,8,'','','2026-10-03','440',9,'Vizag to Chennai',82000,82000,0,0,0,0,73500,68500,5000,0,0,0,0,1,1,25,NULL,NULL,'2026-10-07 20:11:38'),
(189,33,'','','2026-09-11','5027',4,'Pondy',14750,10000,50,4100,600,0,9000,8500,500,4112,600,0,0,1,1,25,NULL,NULL,'2026-10-08 17:35:49'),
(190,1,'','','2026-09-11','5028',4,'Oragadam',6050,6000,50,0,0,0,5000,5000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-10-08 17:36:35'),
(191,2,'','','2026-09-15','416',24,'Vijayawada',26260,24000,50,1750,460,0,22000,21000,1000,1780,460,0,0,1,1,25,NULL,NULL,'2026-10-08 17:37:53'),
(192,7,'','','2026-09-18','5030',4,'TONDIARPET TO ENNORE',5050,5000,50,0,0,0,4500,4500,0,0,0,0,0,1,1,25,NULL,NULL,'2026-10-08 17:39:41'),
(193,32,'','','2026-09-18','5031',24,'MAILIKIPURAM',16400,16000,50,350,0,0,13500,12500,1000,360,0,0,0,1,1,25,NULL,NULL,'2026-10-08 17:49:05'),
(194,1,'','','2026-09-18','5032',4,'Bangalore',17187,13000,50,1050,3087,0,12000,11000,1000,1074,3087,0,0,1,1,25,NULL,NULL,'2026-10-08 17:52:46'),
(195,1,'','','2026-09-23','423',4,'Vijayawada',26160,24000,50,1500,610,0,21500,20000,1500,1516,610,0,0,1,1,25,NULL,NULL,'2026-10-08 17:54:03'),
(196,1,'','','2026-09-24','5037',24,'TONDIARPET TO NAPALAYAM',4550,4500,50,0,0,0,4000,4000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-10-08 17:55:39'),
(197,1,'','','2026-09-28','5038',4,'Tondiarpet to Airport',3550,3500,50,0,0,0,3000,3000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-10-08 17:56:19'),
(198,28,'','','2026-09-28','424',4,'Pondy',10050,10000,50,0,0,0,8700,7700,1000,100,0,0,0,1,1,25,NULL,NULL,'2026-10-08 17:58:08'),
(199,2,'','','2026-09-28','425',24,'Vijayawada',26010,24000,50,1550,410,0,22000,21000,1000,1574,410,0,0,1,1,25,NULL,NULL,'2026-10-08 17:59:52'),
(200,41,'','','2026-09-29','431432',4,'Pondy',10350,9000,100,850,400,0,8000,7500,500,894,400,0,0,1,1,25,NULL,NULL,'2026-10-08 18:02:00'),
(201,1,'','','2026-09-30','433',4,'Oragadam',6050,6000,50,0,0,0,5000,5000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-10-08 18:03:08'),
(202,7,'','','2026-09-30','439',4,'Oragadam',10050,10000,50,0,0,0,9000,9000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-10-08 18:03:49'),
(203,1,'','','2026-09-28','LO',6,'Chennai Local Services',7500,7500,0,0,0,0,6500,6500,0,0,0,0,0,1,1,25,NULL,NULL,'2026-10-08 18:20:23'),
(204,19,'','','2026-09-01','413-414',17,'VIJAYAPURA/SATARA',42000,42000,0,0,0,0,38000,36000,2000,0,0,0,0,0,1,25,NULL,NULL,'2026-10-08 18:31:15'),
(205,37,'','','2026-10-05','442',6,'Kolkata',72000,72000,0,0,0,0,64500,61500,3000,200,0,0,0,1,1,25,NULL,NULL,'2026-10-13 09:47:18'),
(206,1,'','','2026-10-09','naa',6,'Chennai Local Services',6000,6000,0,0,0,0,5500,5500,0,0,0,0,0,1,1,25,NULL,NULL,'2026-10-13 09:48:01'),
(207,1,'','','2026-10-09','NE',12,'Gummidipoondi',8000,8000,0,0,0,0,5600,5600,0,900,0,0,0,1,1,25,NULL,NULL,'2026-10-13 09:49:43'),
(208,19,'','','2026-10-12','448',22,'Sricity to Daman',51000,51000,0,0,0,0,43000,41000,2000,200,0,3000,0,1,1,25,NULL,NULL,'2026-10-15 10:14:00'),
(209,1,'','','2026-10-12','-',22,'Sricity (up& down)',16000,16000,0,0,0,0,13000,13000,0,200,0,1000,0,1,1,25,NULL,NULL,'2026-10-15 10:15:12'),
(210,19,'','','2026-10-13','449',29,'Pune',38000,38000,0,0,0,0,34500,32500,2000,0,0,0,0,1,1,25,NULL,NULL,'2026-10-15 10:26:09'),
(211,19,'','','2026-10-12','447',17,'Pune',38100,38000,100,0,0,0,34500,32500,2000,0,0,0,0,1,1,25,NULL,NULL,'2026-10-15 10:31:13'),
(212,19,'','','2026-10-18','502',17,'Vadodara',53100,53100,0,0,0,0,48000,46000,2000,0,0,0,0,1,1,25,NULL,NULL,'2026-10-19 13:54:41'),
(213,38,'','','2026-10-09','444\r\n445',17,'Surat/Ahmedabad',76200,76000,200,0,0,0,68000,64000,4000,0,0,0,0,1,1,25,NULL,NULL,'2026-10-23 00:36:37'),
(214,42,'','','2026-10-20','Man',6,'Chennai Local Services',15500,15500,0,0,0,0,14000,14000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-10-27 13:34:25'),
(215,42,'','','2026-10-22','Local',6,'Chennai Local Services',4500,4500,0,0,0,0,4000,4000,0,0,0,0,0,1,1,25,NULL,NULL,'2026-10-27 13:34:58'),
(216,7,'','','2026-10-23','5042',12,'Gummidipoondi',8500,8500,0,0,0,0,6500,6500,0,900,0,0,0,1,1,25,NULL,NULL,'2026-10-27 13:35:55'),
(217,43,'','','2026-10-24','513',17,'Goa',57100,57000,100,0,0,0,51000,46000,5000,0,0,0,0,1,1,25,NULL,NULL,'2026-10-29 09:53:15'),
(218,43,'','','2026-10-22','5040',13,'Vizag to Mumbai',150000,150000,0,0,0,0,110000,102500,7500,5100,0,0,8000,1,1,25,NULL,NULL,'2026-10-29 12:53:54'),
(219,43,'','','2026-10-24','514',7,'Vadodara',130000,130000,0,0,0,0,103000,94500,8500,6206,0,0,0,1,1,25,NULL,NULL,'2026-10-29 12:55:04'),
(220,4,'1111','111111','2026-11-04','1010',1,'qqq',300,100,100,100,0,0,100,100,0,100,0,0,0,0,0,1,1,'2026-11-04 11:06:34','2026-11-04 11:04:58'),
(221,35,'111','11222','2026-11-04','1010',1,'qq',400,300,100,0,0,0,300,0,300,0,0,0,0,1,1,1,NULL,NULL,'2026-11-04 11:07:17');

/*Table structure for table `transport_bill_payment` */

DROP TABLE IF EXISTS `transport_bill_payment`;

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
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `transport_bill_payment` */

insert  into `transport_bill_payment`(`id`,`bill_id`,`payment_type`,`payment_mode`,`paid_amount`,`tax_amount`,`notes`,`entry_user`,`entry_date_time`,`entry_date`) values 
(1,1,1,0,0,0,NULL,25,'2026-06-23 19:28:50','2026-06-23 19:28:50'),
(2,2,1,0,0,0,NULL,25,'2026-06-25 19:23:09','2026-06-25 19:23:09'),
(3,3,2,1,0,0,NULL,25,'2026-07-02 11:06:42','2026-07-02 11:06:42'),
(4,4,2,1,0,0,NULL,25,'2026-07-02 12:16:46','2026-07-02 12:16:46'),
(5,5,2,1,0,0,NULL,25,'2026-07-02 12:26:06','2026-07-02 12:26:06'),
(6,6,1,0,0,0,NULL,25,'2026-07-02 12:29:44','2026-07-02 12:29:44'),
(7,7,2,1,0,0,NULL,25,'2026-07-03 15:44:50','2026-07-03 15:44:50'),
(8,8,2,1,0,0,NULL,25,'2026-07-03 15:48:03','2026-07-03 15:48:03'),
(9,9,2,1,0,0,NULL,25,'2026-07-05 14:17:27','2026-07-05 14:17:27'),
(10,10,2,1,0,0,NULL,25,'2026-07-05 14:17:52','2026-07-05 14:17:52'),
(11,11,2,1,0,0,NULL,25,'2026-07-05 14:18:34','2026-07-05 14:18:34'),
(12,12,2,1,0,0,NULL,25,'2026-07-05 14:18:59','2026-07-05 14:18:59'),
(13,13,2,1,0,0,NULL,25,'2026-07-05 14:19:20','2026-07-05 14:19:20'),
(14,14,2,1,0,0,NULL,25,'2026-07-05 14:19:50','2026-07-05 14:19:50'),
(15,15,2,1,0,0,NULL,25,'2026-07-05 14:20:14','2026-07-05 14:20:14'),
(16,16,2,1,0,0,NULL,25,'2026-07-05 14:21:13','2026-07-05 14:21:13'),
(17,17,2,1,0,0,NULL,25,'2026-07-05 14:21:41','2026-07-05 14:21:41'),
(18,18,2,1,0,0,NULL,25,'2026-07-05 14:24:28','2026-07-05 14:24:28'),
(19,19,2,1,0,0,NULL,25,'2026-07-05 14:24:44','2026-07-05 14:24:44'),
(20,20,2,1,0,0,NULL,25,'2026-07-10 19:04:52','2026-07-10 19:04:52'),
(21,21,2,1,0,0,NULL,25,'2026-07-10 19:41:29','2026-07-10 19:41:29'),
(22,22,2,1,0,0,NULL,25,'2026-07-10 19:56:45','2026-07-10 19:56:45'),
(23,23,2,1,0,0,NULL,25,'2026-07-10 20:09:19','2026-07-10 20:09:19'),
(24,24,2,1,0,0,NULL,25,'2026-07-12 19:08:36','2026-07-12 19:08:36'),
(25,25,2,1,0,0,NULL,25,'2026-07-16 12:15:16','2026-07-16 12:15:16'),
(26,26,2,1,0,0,NULL,25,'2026-07-18 19:05:03','2026-07-18 19:05:03'),
(27,27,2,1,0,0,NULL,25,'2026-07-18 19:07:43','2026-07-18 19:07:43'),
(28,28,2,1,0,0,NULL,25,'2026-07-24 10:48:06','2026-07-24 10:48:06'),
(29,29,2,1,0,0,NULL,25,'2026-07-24 10:49:41','2026-07-24 10:49:41'),
(30,30,2,1,0,0,NULL,25,'2026-07-24 10:50:08','2026-07-24 10:50:08'),
(31,31,2,1,0,0,NULL,25,'2026-07-24 10:51:21','2026-07-24 10:51:21'),
(32,32,2,1,0,0,NULL,25,'2026-07-24 10:51:46','2026-07-24 10:51:46'),
(33,33,2,1,0,0,NULL,25,'2026-07-24 10:52:11','2026-07-24 10:52:11'),
(34,34,2,1,0,0,NULL,25,'2026-07-24 10:52:43','2026-07-24 10:52:43'),
(35,35,2,1,0,0,NULL,25,'2026-07-24 11:00:44','2026-07-24 11:00:44'),
(36,36,2,1,0,0,NULL,25,'2026-07-28 10:18:52','2026-07-28 10:18:52'),
(37,37,2,1,0,0,NULL,25,'2026-07-28 10:24:32','2026-07-28 10:24:32'),
(38,38,2,1,0,0,NULL,25,'2026-07-28 10:28:04','2026-07-28 10:28:04'),
(39,39,2,1,0,0,NULL,25,'2026-07-28 10:31:01','2026-07-28 10:31:01'),
(40,40,2,1,0,0,NULL,25,'2026-07-31 22:00:46','2026-07-31 22:00:46'),
(41,41,2,1,0,0,NULL,25,'2026-08-04 23:29:54','2026-08-04 23:29:54'),
(42,42,2,1,0,0,NULL,25,'2026-08-04 23:30:19','2026-08-04 23:30:19'),
(43,43,2,1,0,0,NULL,25,'2026-08-05 08:43:16','2026-08-05 08:43:16'),
(44,44,2,1,0,0,NULL,25,'2026-08-05 08:58:40','2026-08-05 08:58:40'),
(45,45,2,1,0,0,NULL,25,'2026-08-05 09:08:20','2026-08-05 09:08:20'),
(46,46,2,1,0,0,NULL,25,'2026-08-05 09:13:30','2026-08-05 09:13:30'),
(47,47,2,1,0,0,NULL,25,'2026-08-06 08:40:52','2026-08-06 08:40:52'),
(48,48,2,1,0,0,NULL,25,'2026-08-06 08:42:38','2026-08-06 08:42:38'),
(49,49,2,1,0,0,NULL,25,'2026-08-06 08:43:08','2026-08-06 08:43:08'),
(50,50,2,1,0,0,NULL,25,'2026-08-06 08:43:33','2026-08-06 08:43:33'),
(51,51,2,1,0,0,NULL,25,'2026-08-06 08:43:55','2026-08-06 08:43:55'),
(52,52,2,1,0,0,NULL,25,'2026-08-06 08:44:30','2026-08-06 08:44:30'),
(53,53,2,1,0,0,NULL,25,'2026-08-06 08:44:56','2026-08-06 08:44:56'),
(54,54,2,1,0,0,NULL,25,'2026-08-06 08:45:17','2026-08-06 08:45:17'),
(55,55,2,1,0,0,NULL,25,'2026-08-06 08:45:37','2026-08-06 08:45:37'),
(56,56,2,1,0,0,NULL,25,'2026-08-06 08:45:56','2026-08-06 08:45:56'),
(57,57,2,1,0,0,NULL,25,'2026-08-06 08:56:01','2026-08-06 08:56:01'),
(58,58,2,1,0,0,NULL,25,'2026-08-06 08:58:05','2026-08-06 08:58:05'),
(59,59,2,1,0,0,NULL,25,'2026-08-06 12:11:34','2026-08-06 12:11:34'),
(60,60,2,1,0,0,NULL,25,'2026-08-07 12:16:33','2026-08-07 12:16:33'),
(61,61,2,1,0,0,NULL,25,'2026-08-10 12:00:00','2026-08-10 12:00:00'),
(62,62,2,1,0,0,NULL,25,'2026-08-10 12:02:37','2026-08-10 12:02:37'),
(63,63,2,1,0,0,NULL,25,'2026-08-11 08:56:20','2026-08-11 08:56:20'),
(64,64,2,1,0,0,NULL,25,'2026-08-11 08:59:41','2026-08-11 08:59:41'),
(65,65,2,1,0,0,NULL,25,'2026-08-11 09:01:26','2026-08-11 09:01:26'),
(66,66,2,1,0,0,NULL,25,'2026-08-11 09:04:00','2026-08-11 09:04:00'),
(67,67,2,1,0,0,NULL,25,'2026-08-12 11:04:49','2026-08-12 11:04:49'),
(68,68,2,1,0,0,NULL,25,'2026-08-13 19:51:27','2026-08-13 19:51:27'),
(69,69,2,1,0,0,NULL,25,'2026-08-13 19:53:04','2026-08-13 19:53:04'),
(70,70,2,1,0,0,NULL,25,'2026-08-18 10:50:09','2026-08-18 10:50:09'),
(71,71,2,1,0,0,NULL,25,'2026-08-18 11:01:26','2026-08-18 11:01:26'),
(72,72,2,1,0,0,NULL,25,'2026-08-28 13:23:55','2026-08-28 13:23:55'),
(73,73,2,1,0,0,NULL,25,'2026-08-28 13:28:04','2026-08-28 13:28:04'),
(74,74,2,1,0,0,NULL,25,'2026-08-28 20:17:01','2026-08-28 20:17:01'),
(75,75,2,1,0,0,NULL,25,'2026-09-04 12:37:11','2026-09-04 12:37:11'),
(76,76,2,1,0,0,NULL,25,'2026-09-04 12:39:04','2026-09-04 12:39:04'),
(77,77,2,1,0,0,NULL,25,'2026-09-04 12:45:46','2026-09-04 12:45:46'),
(78,78,2,1,0,0,NULL,25,'2026-09-04 12:46:09','2026-09-04 12:46:09'),
(79,79,2,1,0,0,NULL,25,'2026-09-04 12:46:29','2026-09-04 12:46:29'),
(80,80,2,1,0,0,NULL,25,'2026-09-04 12:46:54','2026-09-04 12:46:54'),
(81,81,2,1,0,0,NULL,25,'2026-09-04 12:47:15','2026-09-04 12:47:15'),
(82,82,2,1,0,0,NULL,25,'2026-09-04 12:47:35','2026-09-04 12:47:35'),
(83,83,2,1,0,0,NULL,25,'2026-09-04 12:47:52','2026-09-04 12:47:52'),
(84,84,2,1,0,0,NULL,25,'2026-09-04 12:48:12','2026-09-04 12:48:12'),
(85,85,2,1,0,0,NULL,25,'2026-09-04 12:49:38','2026-09-04 12:49:38'),
(86,86,2,1,0,0,NULL,25,'2026-09-04 12:49:58','2026-09-04 12:49:58'),
(87,87,2,1,0,0,NULL,25,'2026-09-04 12:51:37','2026-09-04 12:51:37'),
(88,88,2,1,0,0,NULL,25,'2026-09-04 12:52:22','2026-09-04 12:52:22'),
(89,89,2,1,0,0,NULL,25,'2026-09-04 13:10:08','2026-09-04 13:10:08'),
(90,90,2,1,0,0,NULL,25,'2026-09-07 20:17:00','2026-09-07 20:17:00'),
(91,91,2,1,0,0,NULL,25,'2026-09-07 20:20:22','2026-09-07 20:20:22'),
(92,92,2,1,0,0,NULL,25,'2026-09-07 20:22:12','2026-09-07 20:22:12'),
(93,93,2,1,0,0,NULL,25,'2026-09-07 20:24:23','2026-09-07 20:24:23'),
(94,94,2,1,0,0,NULL,25,'2026-09-10 18:43:20','2026-09-10 18:43:20'),
(95,95,2,1,0,0,NULL,25,'2026-09-10 18:55:07','2026-09-10 18:55:07'),
(96,96,2,1,0,0,NULL,25,'2026-09-10 19:08:14','2026-09-10 19:08:14'),
(97,97,2,1,0,0,NULL,25,'2026-09-10 19:34:05','2026-09-10 19:34:05'),
(98,98,2,1,0,0,NULL,25,'2026-09-21 13:35:13','2026-09-21 13:35:13'),
(99,99,2,1,0,0,NULL,25,'2026-09-21 13:39:47','2026-09-21 13:39:47'),
(100,100,2,1,0,0,NULL,25,'2026-09-21 13:42:15','2026-09-21 13:42:15'),
(101,101,2,1,0,0,NULL,25,'2026-09-21 13:48:40','2026-09-21 13:48:40'),
(102,102,2,1,0,0,NULL,25,'2026-09-21 13:59:57','2026-09-21 13:59:57'),
(103,103,2,1,0,0,NULL,25,'2026-09-21 14:02:51','2026-09-21 14:02:51'),
(104,104,2,1,0,0,NULL,25,'2026-09-21 14:05:51','2026-09-21 14:05:51'),
(105,105,2,1,0,0,NULL,25,'2026-09-21 14:12:26','2026-09-21 14:12:26'),
(106,106,2,1,0,0,NULL,25,'2026-09-22 11:00:24','2026-09-22 11:00:24'),
(107,107,2,1,0,0,NULL,25,'2026-09-28 13:08:32','2026-09-28 13:08:32'),
(108,108,2,1,0,0,NULL,25,'2026-10-04 19:41:04','2026-10-04 19:41:04'),
(109,109,1,0,0,0,NULL,25,'2026-10-04 19:46:31','2026-10-04 19:46:31'),
(110,110,2,1,0,0,NULL,25,'2026-10-04 19:54:12','2026-10-04 19:54:12'),
(111,111,1,0,0,0,NULL,25,'2026-10-04 19:58:59','2026-10-04 19:58:59'),
(112,112,1,0,0,0,NULL,25,'2026-10-04 19:59:19','2026-10-04 19:59:19'),
(113,113,2,1,0,0,NULL,25,'2026-10-04 20:51:48','2026-10-04 20:51:48'),
(114,114,2,1,0,0,NULL,25,'2026-10-06 09:47:52','2026-10-06 09:47:52'),
(115,115,1,0,0,0,NULL,25,'2026-10-07 19:55:55','2026-10-07 19:55:55'),
(116,116,1,0,0,0,NULL,25,'2026-10-07 19:56:15','2026-10-07 19:56:15'),
(117,117,2,1,0,0,NULL,25,'2026-10-07 19:56:43','2026-10-07 19:56:43'),
(118,118,1,0,0,0,NULL,25,'2026-10-07 19:57:05','2026-10-07 19:57:05'),
(119,119,2,1,0,0,NULL,25,'2026-10-07 19:57:23','2026-10-07 19:57:23'),
(120,120,1,0,0,0,NULL,25,'2026-10-07 19:57:40','2026-10-07 19:57:40'),
(121,121,1,0,0,0,NULL,25,'2026-10-07 19:58:02','2026-10-07 19:58:02'),
(122,122,2,1,0,0,NULL,25,'2026-10-07 19:58:28','2026-10-07 19:58:28'),
(123,123,1,0,0,0,NULL,25,'2026-10-07 19:58:44','2026-10-07 19:58:44'),
(124,124,1,0,0,0,NULL,25,'2026-10-07 19:59:05','2026-10-07 19:59:05'),
(125,125,2,1,0,0,NULL,25,'2026-10-07 19:59:31','2026-10-07 19:59:31'),
(126,126,1,0,0,0,NULL,25,'2026-10-07 19:59:51','2026-10-07 19:59:51'),
(127,127,2,1,0,0,NULL,25,'2026-10-07 20:00:10','2026-10-07 20:00:10'),
(128,128,2,1,0,0,NULL,25,'2026-10-07 20:00:29','2026-10-07 20:00:29'),
(129,129,2,1,0,0,NULL,25,'2026-10-07 20:00:50','2026-10-07 20:00:50'),
(130,130,2,1,0,0,NULL,25,'2026-10-07 20:09:51','2026-10-07 20:09:51'),
(131,131,2,1,0,0,NULL,25,'2026-10-07 20:14:16','2026-10-07 20:14:16'),
(132,132,2,1,0,0,NULL,25,'2026-10-08 18:43:38','2026-10-08 18:43:38'),
(133,133,2,1,0,0,NULL,25,'2026-10-08 18:51:55','2026-10-08 18:51:55'),
(134,134,2,1,0,0,NULL,25,'2026-10-08 19:07:08','2026-10-08 19:07:08'),
(135,135,2,1,0,0,NULL,25,'2026-10-08 19:09:56','2026-10-08 19:09:56'),
(136,136,2,1,0,0,NULL,25,'2026-10-08 19:19:41','2026-10-08 19:19:41'),
(137,137,2,1,0,0,NULL,25,'2026-10-08 19:35:33','2026-10-08 19:35:33'),
(138,138,2,1,0,0,NULL,25,'2026-10-08 19:40:01','2026-10-08 19:40:01'),
(139,139,2,1,0,0,NULL,25,'2026-10-13 09:53:21','2026-10-13 09:53:21'),
(140,140,2,1,0,0,NULL,25,'2026-10-13 09:57:26','2026-10-13 09:57:26'),
(141,141,2,1,0,0,NULL,25,'2026-10-13 10:00:01','2026-10-13 10:00:01'),
(142,142,2,1,0,0,NULL,25,'2026-10-13 10:12:05','2026-10-13 10:12:05'),
(143,143,2,1,0,0,NULL,25,'2026-10-15 10:19:57','2026-10-15 10:19:57'),
(144,144,2,1,0,0,NULL,25,'2026-10-15 10:21:58','2026-10-15 10:21:58'),
(145,145,2,1,0,0,NULL,25,'2026-10-15 10:27:33','2026-10-15 10:27:33'),
(146,146,2,1,0,0,NULL,25,'2026-10-23 00:07:03','2026-10-23 00:07:03'),
(147,147,2,1,0,0,NULL,25,'2026-10-23 00:09:40','2026-10-23 00:09:40'),
(148,148,2,1,0,0,NULL,25,'2026-10-23 00:43:22','2026-10-23 00:43:22'),
(149,149,2,1,0,0,NULL,25,'2026-10-23 00:46:38','2026-10-23 00:46:38'),
(150,150,2,1,0,0,NULL,25,'2026-10-23 00:50:20','2026-10-23 00:50:20'),
(151,151,2,1,0,0,NULL,25,'2026-10-27 13:39:06','2026-10-27 13:39:06'),
(152,152,2,1,0,0,NULL,25,'2026-10-27 13:42:46','2026-10-27 13:42:46'),
(153,153,2,1,0,0,NULL,25,'2026-10-27 13:47:17','2026-10-27 13:47:17'),
(154,154,2,1,0,0,NULL,25,'2026-10-29 09:56:14','2026-10-29 09:56:14'),
(155,155,2,1,0,0,NULL,25,'2026-10-29 12:59:54','2026-10-29 12:59:54'),
(156,156,2,1,0,0,NULL,25,'2026-10-29 13:03:18','2026-10-29 13:03:18'),
(157,157,1,0,200,0,NULL,1,'2026-11-04 11:05:57','2026-11-04 11:05:57'),
(158,158,1,0,0,0,NULL,1,'2026-11-04 11:07:30','2026-11-04 11:07:30');

/*Table structure for table `transport_lr_copy` */

DROP TABLE IF EXISTS `transport_lr_copy`;

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
  `no_of_articles` text,
  `description_text` text,
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
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `transport_lr_copy` */

insert  into `transport_lr_copy`(`id`,`lr_no`,`customer_id`,`customer_name`,`phone_number`,`lr_date`,`truck_no`,`from_location`,`to_location`,`consignee_name`,`no_of_articles`,`description_text`,`weight_mt`,`mode_payment1`,`freight_amount`,`to_pay_amount`,`paid_amount`,`amount_in_words`,`dc_no`,`inv_date`,`inv_no`,`inv_date2`,`declared_value_rs`,`pnl_seal_no`,`material_received_date`,`pnl_no`,`driver_name`,`vehicle_type`,`deliver_in`,`entry_user`,`entry_date_time`,`entry_date`,`is_cancelled`,`cancel_uid`,`cancel_date_time`) values 
(1,'5001',0,'M/s.Tablets India Limited.,KVT Garden, Phase-2, Plot No. 5/6/17, VS Mani Street,VS Mani Nagar,100 Feet Road, Madavaram,Chennai-600060','','2026-07-23','TN99AB2710','Chennai','Nagapatinam','M/s.Amritha Enterprises,#6, Rajathi Complex, Opp. E B Sub Station, TVR Main Road, Nagapatinam-611001','59','AQUA PRODUCTS','F T L','To be billed in Chennai','','','','','','2026-07-23','DCH2627/E0500039,DCH2627/E0500,DCH2627/E0500038040,','2026-07-23','19411\r\n177903\r\n243764','','2026-07-23','6189/30 - Coimbatore','M Murugan','Dost Open Vehicle','Unloaded by party',25,'2026-07-23 15:06:57','2026-07-23',0,NULL,NULL),
(2,'5002',0,'M/s.Tablets India Limited., No.179, T H Road, Tondiarpet, Chennai-600081','','2026-07-24','TN03AE5173','Tondiarpet','Chennai Airport','M/s.Medinova Pharmaceutical, Drop at Chennai Airport','167','MEDICINES','F T L','To be billed in Chennai','','','','','','2026-07-22','FCF2627/EXB00027','2026-07-22','As per Invoice','','2026-07-24','2698/26','Vasantha Kumar','Tate Ace Closed','Unloaded by party',25,'2026-07-24 10:41:08','2026-07-24',0,NULL,NULL),
(3,'5003',14,'KV Movers','','2026-07-23','TN18AT3957','Chennai','Bangalore','M/s.Writer Relocations., A/c.Mr.Anikesh Ravichandran, Hoskote, Bangalore','14','USED HOUSEHOLD GOODS','F T L','To be billed in Chennai','','','','','','2026-07-23','NOT FOR SALE','2026-07-23','NO COMMERCIAL VALUE','','2026-07-23','2698/26 - Ranipet','Vasanth','Dost Container','Unloaded by party',25,'2026-07-24 10:58:58','2026-07-23',0,NULL,NULL),
(4,'5004',0,'M/s.Tablets India Limited., No.179, T H Road, Tondiarpet, Chennai-600081','','2026-07-24','TN02BY0927','Tondiarpet','Oragadam','M/s.Tablets India Limited., 242, Oragadam Village Road,Oragadam,Thiruporur (TK)Chengalpattu,Kanchipuram-603109','112','MEDICINES  ','F T L','To be billed in Chennai','','','','','','2026-07-24','FCF2627/TDC00246-0247','2026-07-24','172422.95\r\n10688.08','','2026-07-24','0467/38-Chennai','T Prakash','Dost Closed Container','Unloaded by party',25,'2026-07-24 19:39:04','2026-07-24',0,NULL,NULL),
(5,'5005',6,'M/s.Crown Worldwide Private Ltd.,','','2026-07-27','TN34AD3479','Chennai','Bangalore','M/s.Elite Relocations, Bangalore','As per List','Used Household Goods','F T L','To be billed in Chennai','','','','','','2026-07-23','','2026-07-23','NOT COMMERCIAL VALUE','','2026-07-23','11064/29','Basha','20 Feet Container','Unloaded by party',25,'2026-07-27 19:24:49','2026-07-27',0,NULL,NULL),
(6,'5006',6,'M/s.Crown Worldwide Private Ltd.,','','2026-07-23','TN34AD3479','Chennai','Goa','M/s.Elite Relocations, Goa','As per List','Used Household Goods','F T L','To be billed in Chennai','','','','','','2026-07-23','NOT FOR SALE','2026-07-23','NO COMMERCIAL VALUE','','2026-07-23','11064/29','Basha','20 Feet Container','Unloaded by party',25,'2026-07-27 19:28:16','2026-07-23',0,NULL,NULL),
(7,'5007',6,'M/s.Crown Worldwide Private Ltd.,','','2026-07-23','TN02BY0927','Periyapalayam','Ennore','Mr.John Lund, Triway CFS, Ennore','As per List','Used Household Goods','F T L','To be billed in Chennai','','','','','','2026-07-23','NOT FOR SALE','2026-07-23','NO COMMERCIAL VALUE','','2026-07-23','0467/38-Chennai','T Prakash','24 FEET OPEN','Unloaded by party',25,'2026-07-27 19:43:48','2026-07-23',0,NULL,NULL),
(8,'5008',0,'M/s.Time Medical International Ventures (India) Pvt Ltd.,AMTZ Campus, Pragati Maidan, VM Steel project S.O, Visakhapatnam.  ','','2026-07-27','MH23AU6834','Visakhapatnam','Mumbai','M/s.The Hotel Rejis.,462, Senapati Bapat Marg, Lower Parel,. Mumbai, Maharashtra 400013','01','PICA 0.35T MRI Dummy model','F T L','To be billed in Chennai','','','','','TMIV/2627/07-002','2026-07-27','','2026-07-27','2000000                                                         ','','2026-07-27','08321/28-Talwada','Haridas Shambhaji','32 Feet Open Truck','Unloaded by party',25,'2026-07-27 19:51:56','2026-07-27',0,NULL,NULL),
(9,'5009',0,'M/s.Tablets India Limited., No.555/32, T H Road,Tondiarpet, Chennai-600081','','2026-07-29','TN03AE5173','Tondiarpet','Thervoy Kandigai','Sheng Long Bio-Tech (India) Pvt. LTD., Plot No.A-11/1,PART-A,SIPCOT INDUSTRIAL PARK,CHENNAI-1-601202 ','100','ANIMAL FEED','F T L','To be billed in Chennai','','','','','','2026-07-29','FAF2627/I1900016','2026-07-29','215250','','2026-07-29','2698/26-Chennai','Vasanthakumar','Tata Ace Closed','Unloaded by party',25,'2026-07-29 11:11:40','2026-07-29',0,NULL,NULL),
(10,'5010',0,'M/s.The Hotel Rejis,462, Senapati Bapat Marg, Lower Parel,.Mumbai, Maharashtra 400013','','2026-08-02','MH23AU6834','Mumbai','Visakhapatnam','Time Medical International Ventures (India) Pvt Ltd.,AMTZ Campus, Pragati Maidan, VM Steel project S.O, Visakhapatnam.    ','01','PICA 0.35T MRI Dummy model','F T L','To be billed in Chennai','','','','','TMIV/2627/07-004','2026-08-02','NOT FOR SALE','2026-08-02','2000000                                                               ','','2026-08-02','08321/28-Beed','Garje Haridas Sambhaji','32 Feet Open Truck','Unloaded by party',25,'2026-08-02 20:44:18','2026-08-02',0,NULL,NULL),
(11,'5011',0,'M/s.FSL Interem Relocations Pvt. Ltd.,P-10, 1st Avenue, Mahindra world City, Chennai','','2026-08-04','TN18AW2000','Chennai','Ranipet (Up and Down)','M/s.Abbot Health Care Pvt. Ltd., Ranipet','As Per List','MACHINER/PACKING MATERIAL ','F T L','To be billed in Chennai','','','','','','2026-08-04','NOT FOR SALE','2026-08-04','NCV','','2026-08-04','2698/26-Chennai','Ramesh','Dost Closed Container','Unloaded by party',25,'2026-08-07 23:45:55','2026-08-04',0,NULL,NULL),
(12,'5012',0,'M/s.Freight Systems India Pvt. Ltd.,Sivagami Dodown, Thiruvotriyur,Chennai','','2026-08-07','TN82Z9555','Chennai','Madurai','Mr.Mohamed Rasool Dastagir Manzil 31/9 Ansari Nagar  Second west street  Mahaboob Palayam  Madurai - 625016','90','Used Household Goods','F T L','To be billed in Chennai','','','','','','2026-08-07','NOT FOR SALE','2026-08-07','NCV','','2026-08-07','0863/30-Karur','Sekaran','20 Feet Container','Unloaded by party',25,'2026-08-07 23:53:46','2026-08-07',0,NULL,NULL),
(13,'5013',0,'M/s.UKL INTRUMENTS PVT. LTD., No.62/5,62/3&61/1b,61/1C,Padur Medu, Poonamalle Taluk,Thiruvallur Dist-602105','','2026-08-08','MH43BP4572','Chennai','Goa','M/s.ION EXCHANGE INDIA LIMITED., Goa Verna, Goa-403722','40','ROMH','F T L','To be billed in Chennai','','','','','','2026-08-08','UKL-26-27-3140','2026-08-08','1179935','','2026-08-08','13019/29-Sangli','Nikhil Chavan','20 Feet Open','Unloaded by party',25,'2026-08-08 14:06:08','2026-08-08',0,NULL,NULL),
(14,'5014',0,'M/s.UKL INTRUMENTS PVT. LTD., No.62/5,62/3&61/1b,61/1C,Padur Medu, Poonamalle Taluk,Thiruvallur Dist-602105','','2026-08-08','MH09GJ9574','Chennai','Goa','M/s.ION EXCHANGE INDIA LIMITED, Goa Verna, Goa-403722','12','ROMH','F T L','To be billed in Chennai','','','','','','2026-08-08','UKL-26-27-3141','2026-08-08','516000','','2026-08-08','59861/30-Kolhapur','Digambar Patil','22 Feet Open','Unloaded by party',25,'2026-08-08 14:09:27','2026-08-08',0,NULL,NULL),
(15,'5015',0,'M/s.UKL INTRUMENTS PVT. LTD., No.62/5,62/3&61/1b,61/1C,Padur Medu, Poonamalle Taluk,Thiruvallur Dist-602105','','2026-08-08','MH09GJ9574','Chennai','Goa','M/s.ION EXCHANGE INDIA LIMITED., Plot No. L-48&49,Verna Electronic City Phase-2, Verna Salc,30, Goa-403722','27','ROMH','F T L','To be billed in Chennai','','','','','','2026-08-08','UKL-26-27-3142','2026-08-08','672300','','2026-08-08',' 59861/30-Kolhapur','Digambar Patil','22 Feet Open','Unloaded by party',25,'2026-08-08 19:45:11','2026-08-08',0,NULL,NULL),
(16,'5016',0,'M/s.UKL INTRUMENTS PVT. LTD., No.62/5,62/3&61/1b,61/1C,Padur Medu, Poonamalle Taluk,Thiruvallur Dist-602105','','2026-08-10','MH11DD7167','Chennai','Pune','M/S.UWS ENVIRO - TECH PVT. LTD., Gate No. 1569, Shelar Vasti, Dehu-Alandi Road, Chikhali, PCMC, Pune','13','ROMH','F T L','To be billed in Chennai','','','','','','2026-08-10','UKL-26-27-3152, 3182','2026-08-10','483000+33820','','2026-08-10','7417/26-Satara','Sandeep Veer','22 Feet Open','Unloaded by party',25,'2026-08-10 18:29:20','2026-08-10',0,NULL,NULL),
(17,'5017',0,'M/s.Tablets India Limited., No.555/32, T H Road,Tondiarpet, Chennai-600081','','2026-08-11','TN03AE5173','Tondiarpet','Thervoy Kandigai','M/s.Sheng Long Bio-Tech (India) Pvt. LTD., Plot No.A-11/1,PART-A,SIPCOT INDUSTRIAL PARK,CHENNAI-1-601202','200','ANIMAL FEEDS','F T L','To be billed in Chennai','','','','','','2026-08-11','FAF2627/E1900012','2026-08-11','537500','','2026-08-11','0467/38-Chennai','Vasanthakumar','Tata ACE','Unloaded by party',25,'2026-08-13 19:32:18','2026-08-11',0,NULL,NULL),
(18,'5018',0,'M/s.Tablets India Limited., No.555/32, T H Road,Tondiarpet, Chennai-600081','','2026-08-12','TN03AE5173','Tondiarpet','Thervoy Kandigai','M/s.Sheng Long Bio-Tech (India) Pvt. LTD., Plot No.A-11/1,PART-A,SIPCOT INDUSTRIAL PARK,CHENNAI-1-601202','200','ANIMAL FEEDS','F T L','To be billed in Chennai','','','','','','2026-08-12','','2026-08-12','','','2026-08-12','0467/38-Chennai','Vasantha Kumar','Tata Ace','Unloaded by party',25,'2026-08-13 19:34:43','2026-08-12',0,NULL,NULL),
(19,'5019',0,'M/s.THIRURANI CFS, MADHAVARAM,CHENNAI','','2026-08-12','TN02BP1046','MADHAVARAM','TONDIARPET','M/s.Tablets India Limited., No.179, T H Road, Tondiarpet, Chennai-600081','01 PALLET','MEDICINES','F T L','To be billed in Chennai','','','','','','2026-08-12','','2026-08-12','AS PER INVOICE','','2026-08-12','11064/29','T Prakash','TATA ACE CLOSED','Unloaded by party',25,'2026-08-13 19:45:51','2026-08-12',0,NULL,NULL),
(20,'5020',0,'M/s.Tablets India Limited., No.179, T H Road, Tondiarpet, Chennai-600081','','2026-08-13','TN32T0149','Tondiarpet','Oragadam','M/s.Tablets India Limited., 242, Oragadam Village Road,Oragadam,Thiruporur (TK)Chengalpattu,Kanchipuram-603109','145','EMPTY DRUM & MEDICINES','F T L','To be billed in Chennai','','','','','','2026-08-13','FF2627/TDC00297-0298-0299-0300-0301','2026-08-13','AS PER INVOICE','','2026-08-13','411/31-TV MALAI','JAYAVEL','17 FEET','Unloaded by party',25,'2026-08-13 23:23:38','2026-08-13',0,NULL,NULL),
(21,'5021',0,'M/s.Time Medical International Ventures (India) Pvt., Ltd.,AMTZ Campus, Pragati Maidan, VM Steel project S.O, Visakhapatnam. ','','2026-08-16','AP39WP9779','Visakhapatnam',' New Delhi ','India Health Exhibition, Bharath Mandapam,Mathura Road, New Delhi - 110001','13','CT SCAN & MRI ACCESSORIES','F T L','To be billed in Chennai','','','','','TMIV/2627/08-002','2026-08-16','NOT FOR SALE','2026-08-16','1500000                                                         ','','2026-08-16','72006/26-Vijayawada','Naresh Ayinampudi','40 Feet Open Trailer','Unloaded by party',25,'2026-08-16 18:42:36','2026-08-16',0,NULL,NULL),
(22,'5022',0,'M/s.India Health Exhibition,Bharath Mandapam Mathura Road, New Delhi - 110001          ','','2026-08-23','AP39WP9779','Delhi','Visakhapatnam','M/s.Time Medical International Ventures (India) Pvt Ltd.,AMTZ Campus, Pragati Maidan, VM Steel project S.O, Visakhapatnam.  ','13','CT SCAN @ MRI ACCESSORIES','F T L','To be billed in Chennai','','','','','TMIV/2627/08-005','2026-08-23','NOT FOR SALE','2026-08-23','1500000','','2026-08-23','7047/31-Narspatnam','Naresh','40 Feet Open Trailer','Unloaded by party',25,'2026-08-25 21:20:30','2026-08-23',0,NULL,NULL),
(23,'5023',0,'M/s.Star Worldwide Group,Lokesh Nagar, Old No#1/10, New No#1/10A1, Koladi Road, Periya Koladi, Thiruverkadu, Chennai - 600 077, Tamil Nadu, India','','2026-09-02','TN66AV1499','Chennai','Wellington','Mr.Michael King, A/c. M/s.Star Worldwide Group., 24/4, Gorkha Hill DSSC Quaters, Wellington-643231','41','Used Household Goods                                    (Packed in One Lift Van)','F T L','To be billed in Chennai','','','','','','2026-09-02','NOT FOR SALE','2026-09-02','NOT COMMERCIAL VALUE','','2026-09-02','1214/27-Tutucorin','Muthu Ganesha Perumal','20 Feet Container','Unloaded by party',25,'2026-09-02 11:55:48','2026-09-02',0,NULL,NULL),
(24,'5024',0,'M/s.UKL INTRUMENTS PVT. LTD., No.62/5,62/3&61/1b,61/1C,Padur Medu, Poonamalle Taluk,Thiruvallur Dist-602105','','2026-09-04','TN56S2121','CHENNAI','SECUNDERABAD ','M/s.AQUAPOT RO TECHNOLOGIES.,Godown: 1-5, Surya No.92, SECUNDERABAD Kompally, Secunderabad -500003','170','ROMH & FRP TANK ','F T L','To be billed in Chennai','','','','','','2026-09-03','UKL-26-27-3672','2026-09-03','585000','','2026-09-04','2466/27','Selvaraj P','22 Feet Container','Unloaded by party',25,'2026-09-04 11:22:22','2026-09-04',0,NULL,NULL),
(25,'5025',0,'M/s.Thermax Limited., Bhosari,,,Pune, Dispatched from M/s.UKL Instruments Pvt. Ltd.,Chennai-602105','','2026-09-04','TN48BW8131','CHENNAI','PERAMBALUR','M/s,MRF LIMITED., TRICHI (BIAS),NARANAMANGALAM   PERAMBALUR,621109','02','PRESSURE TUBES ','F T L','To be billed in Chennai','','','','','','2026-09-04','271700044956','2026-09-04','115710','','2026-09-04','0840/27','Vijay s','22 Feet Open','Unloaded by party',25,'2026-09-04 18:50:32','2026-09-04',0,NULL,NULL),
(26,'5026',0,'M/s.Freight Systems India Pvt. Ltd.,P-10, 1st Avenue, Mahindra world City, Chennai','','2026-09-11','TN73D6566','CHENNAI','BANGALORE','Mr.Sukhdeep Singh Johar, A/c.M/s.Freight Systems India Pvt. Ltd., 57073,7th Floor, Tower 7, Meridian Park in Prestige City, Sarjapur, Bangalore','46','Used Household Goods','F T L','To be billed in Chennai','','','','','','2026-09-11','NOT FOR SALE','2026-09-11','NCV','','2026-09-11','0323/31-Cheyyar','Dilli Ganesh','Bada Dost Container','Unloaded by party',25,'2026-09-11 18:50:38','2026-09-11',0,NULL,NULL),
(27,'5027',0,'M/s.Tablets India Limited., No.179, T H Road, Tondiarpet, Chennai-600081','','2026-09-11','TN22DV2668','CHENNAI','PUDUCHERRY','M/s.Tablets India Limited.,P.No.3, 1 Cross Street,Ravichandran Nagar, Thiruvandarkoil, Puducherry-605102','1669','H L MEDICINES','F T L','To be billed in Chennai','','','','','','2026-09-11','WOS2627/TTX00466,0465','2026-09-11','6702234','','2026-09-11','2668/30-MP','Damodaran','20 Feet Container','Unloaded by party',25,'2026-09-11 19:30:51','2026-09-11',0,NULL,NULL),
(28,'5028',0,'M/s.Tablets India Limited., No.179, T H Road, Tondiarpet, Chennai-600081','','2026-09-11','TN18AW2000','Tondiarpet','Oragadam','M/s.Tablets India Limited., 242, Oragadam Village Road,Oragadam,Thiruporur (TK)Chengalpattu,Kanchipuram-603109','43','MEDICINE RAW MATERIAL','F T L','To be billed in Chennai','','','','','','2026-09-11','FCF2627/TDC00371-0372-0373-0374-0375','2026-09-11','AS PER INVOICE','','2026-09-11','0467/38-Chennai','Ramesh','Dost Closed Container','Unloaded by party',25,'2026-09-11 19:34:50','2026-09-11',0,NULL,NULL),
(29,'5029',0,'M/s.Crown Worldwide Private Ltd.,A/c.Mr.Viswas Sarpa Bhushana, Dispatch from Chennai Fort','','2026-09-11','TN99AF3834','Chennai','Bangalore','M/s.Crown Worldwide Private Ltd.,A/c.Mr.Viswas Sarpa Bhushana., Whitefeild,Bangalore','As per List','Used Household Goods','F T L','To be billed in Chennai','','','','','','2026-09-11','NOT FOR SALE','2026-09-11','NCV','','2026-09-11','6494/27-Dindugal','Andisamy C','20 Feet Container','Unloaded by party',25,'2026-09-11 19:48:54','2026-09-11',0,NULL,NULL),
(30,'5030',0,'M/s.Tablets India Limited., No.179, T H Road, Tondiarpet, Chennai-600081','','2026-09-18','TN12AR5837','Tondiarpet','Ennore','M/s.Sanco Container Freight Station,No.592 Ennore Express High Road, Chennai, Tamil Nadu 600057','140','MEDICINES - 08 PALLETS','F T L','To be billed in Chennai','','','','','','2026-09-18','TML/EXPORT/26-27/8','2026-09-02','AS PER INVOICE','','2026-09-18','2687/26','SURIYA','20 Feet Container','Unloaded by party',25,'2026-09-18 13:33:29','2026-09-18',0,NULL,NULL),
(31,'5031',0,'M/s.Tablets India Limited.,KVT Garden, Phase-2, Plot No. 5/6/17, VS Mani Street,VS Mani Nagar,100 Feet Road, Madavaram,Chennai-600060','','2026-09-18','AP39 WF 8767','Chennai','Malikipuram','M/s.Vijetha Aqua Agencies, 3-157,Malikipuram Main Road,Malikipuram, East Godavari-533253','120','AQUA PRODUCTS','F T L','To be billed in Chennai','','','','','','2026-09-18','DCA2627/E0500004','2026-09-18','123377','','2026-09-18','10813/33','Venkatesh Vusa','Dost Open Vehicle','Door delivery',25,'2026-09-18 13:40:14','2026-09-18',0,NULL,NULL),
(32,'5032',0,'M/s.Tablets India Limited., No.179, T H Road, Tondiarpet, Chennai-600081','','2026-09-18','TN59DV5038','Chennai','Bangalore','M/s.Rajatha Pharma, No.19, 4th Cross Road, Avalahalli Main Road,Mysore Road, Bangalore','441','H L MEDICINES','F T L','To be billed in Chennai','','','','','','2026-09-18','FFD/11300065,0075,0142,FCF/1010061,0136,0182,WOS/10100199,0128,0162,SDN127','2026-09-18','ASPER INVOICE','','2026-09-18','00934/30','Suresh S','17 Feet Container','Unloaded by party',25,'2026-09-18 13:54:14','2026-09-18',0,NULL,NULL),
(33,'5033',0,'M/s.FLYNNCARE HEALTH INNOVATIONS PRIVATE LIMITED 8/1A, Manjambakkam Road, Manjambakkam, Mathur, Chennai, Tamil Nadu 600060','','2026-09-19','KA51 AC 6549','Chennai','Bangalore','M/s,Sri Sri Ayurveda Hospital. Survey No. 189, Kanakapura Main Rd, South, Udayapura Post, O.B Chudanahalli, Bengaluru, Karnataka 560082','01','Kiosk Fabrication Body','F T L','To be billed in Chennai','','','','','FLCH09-002/26-27','2026-09-19','','2026-09-19','45000','','2026-09-19','8247/31-Gudiyatham','Karunamoorthy','Bolero Container','Unloaded by party',25,'2026-09-19 17:42:07','2026-09-19',0,NULL,NULL),
(34,'5034',0,'M/s.FLYNNCARE HEALTH INNOVATIONS PRIVATE LIMITED 8/1A, Manjambakkam Road, Manjambakkam, Mathur, Chennai, Tamil Nadu 600060','','2026-09-19','KA51 AC 6549','Chennai','Bangalore','M/s.Medha Welltech Solutions Pvt Ltd.                          90/2,Guddanahalli Village, Anekal to Hosur Main Road Samandur, Bangalore, Anekal, Karnataka - 562106','01','Kiosk Fabrication Body','F T L','To be billed in Chennai','','','','','FLCH09-001/26-27','2026-09-19','','2026-09-19','45000','','2026-09-19','8247/31-Gudiyatham','Karunamoorthy','Bolero Container','Unloaded by party',25,'2026-09-19 17:45:35','2026-09-19',0,NULL,NULL),
(35,'5035',6,'M/s.Crown Worldwide Private Ltd.,','','2026-09-19','TN70AF1813','Chennai','Bangalore','Mr.Samba Siva Rao Jasti- Bangalore','61','Used Household Goods','F T L','To be billed in Chennai','','','','','','2026-09-19','','2026-09-19','NCV','','2026-09-19','0467/38-Chennai','T Prakash','20 Feet Container','Unloaded by party',25,'2026-09-19 20:28:39','2026-09-19',0,NULL,NULL),
(36,'5036',0,'M/s.Agarwal Packers and Mover Ltd, APML Manivali Vill,Khalapur, Chowk,Near HPCL Pump on Old Mum-Pune Highway,410206.','','2026-09-23','KA22AA9457','Mumbai','Bangalore','Ms.Divya  Gupta,A/c.M/s.Crown Worldwide Movers Pvt Ltds.,Villa No. 414 Adarsh Palm Retreat, Marathahalli - Sarjapur Outer Ring Road, Bellandur Post, behind Gear international school road Bangalore 560103( Landmark Dr BR Ambedkar statue)','62','Used Household Goods','F T L','To be billed in Chennai','','','','','','2026-09-23','','2026-09-23','NCV','','2026-09-23','10222/28-Belgaum','Abdul Razaq','Bada Dost Closed Container','Unloaded by party',25,'2026-09-23 19:56:55','2026-09-23',0,NULL,NULL),
(37,'5037',24,'M/S.TABLETS (INDIA) LIMITED - Aquatic Feed Division ','','2026-09-24','TN04AB0765','Tondiarpet','Nappalayam','M/s.Triway Container Freight Station., 148, Ponneri High Road, Edayanchavadi, New Nappalayam, Vallur, Post, Chennai, Tamil Nadu 600103','127','AQUA PRODUCTS','F T L','To be billed in Chennai','','','','','','2026-09-24','FCA2627/B0200001','2026-09-22','AS PER INVOICE','','2026-09-24','0467/38-Chennai','Stephen','17 Feet Container','Unloaded by party',25,'2026-09-24 11:55:03','2026-09-24',0,NULL,NULL),
(38,'5038',0,'M/s.Tablets India Limited., No.179, T H Road, Tondiarpet, Chennai-600081','','2026-09-28','TN18AW2000','Tondiarpet','Meenambakkam','M/s.Air Cargo Complex, Mennambakkam,Chennai-600016','25','MEDICINES','F T L','To be billed in Chennai','','','','','','2026-09-28','FCF2627/I4100009','2026-09-28','76652','','2026-09-28','0467/38-Chennai','Ramesh','Bada Dost Container','Unloaded by party',25,'2026-09-28 13:02:08','2026-09-28',0,NULL,NULL),
(39,'5039',0,'M/s.Tablets India Limited.,KVT Garden, Phase-2, Plot No. 5/6/17, VS Mani Street,VS Mani Nagar,100 Feet Road, Madavaram,Chennai-600060','','2026-10-22','TN32BE3748','CHENNAI','NAGAPATINAM','M/s.Amritha Enterprises, #6, Rajathi Complex, Opp. E.B Sub Station, TVR Main Road,Nagapatinam','52','AQUA PRODUCTS','F T L','To be billed in Chennai','','','','','','2026-10-22','DCA2627/E0500013,I0500008,0007','2026-10-22','517203','','2026-10-22','2331/26-Vlipuram','Kirubanithi','Dost Closed Container','Unloaded by party',25,'2026-10-22 15:53:37','2026-10-22',0,NULL,NULL),
(40,'5040',0,'M/s.Time Medical International Ventures (India) Pvt Ltd., Dispatch from Factory : Nadupuru Village Survey No. 480/2 Pedagantyada Mandal,Visakhapatnam,A P-530032','','2026-10-22','MH46DC4633','VISHAKAPATNAM','MUMBAI','M/s.GEMED S.R.L Florencio Varela, Argentina- DELIVERY AT  Budget CFS Terminals Private Limited CWC CFS- DRONAGIRI NODE- INNSA1CWC2 Navi Mumbai-400707.','08','0.35T PICA - Whole Body MRI System','F T L','To be billed in Chennai','','','','','','2026-10-22','AP/26-27/INV006','2026-10-22','31674456.00','','2026-10-22','09893/31-MH-414203','Vishal Navnath Andhale','40 Feet Open Trailer','Unloaded by party',25,'2026-10-22 17:57:49','2026-10-22',0,NULL,NULL),
(41,'5041',0,'M/s.Tablets India Limited., No.179, T H Road, Tondiarpet, Chennai-600081','','2026-10-23','TN57CV6892','Chennai','Vijayawada','M/s.Tablets India Limited.,Door No. 76-1-5/2, Dargha Backside Road, Bhavanipuram, Vijayawada','754','H L MEDICINES','F T L','To be billed in Chennai','','','','','','2026-10-23','WOS2627/TTX00572-WOS2627/TTX00568-WOS2627/TTX00573-FFD2627/TTX00211-FCF2627/TTX00602','2026-10-23','AS PER INVOICE','','2026-10-23','11752/26-Salem','Murugan R','20 Feet Container','Unloaded by party',25,'2026-10-23 18:13:22','2026-10-23',0,NULL,NULL),
(42,'5042',0,'M/s.Tablets India Limited., No.555/32, T H Road,Tondiarpet, Chennai-600081','','2026-10-23','TN 20 AL 7971','Tondiarpet','Gummidipoondi',' M/s.Sheng Long Bio-Tech (India) Pvt. LTD., Plot No.A-11/1,PART-A,SIPCOT INDUSTRIAL PARK,CHENNAI-1-601202','300','AQUA PRODUCTS','F T L','To be billed in Chennai','','','','','','2026-10-23','ATTACHED','2026-10-23','AS PER INVOICE','','2026-10-23','0467/38-Chennai','Prabhakaran','407 Container','Unloaded by party',25,'2026-10-23 18:54:55','2026-10-23',0,NULL,NULL),
(43,'5043',0,'M/S.CSP TECHNOLOGIES-Dispatch from ALL CARGO TERMINALS LIMITED CFS NO 913 THIRUVOTTIYUR HIGH ROAD ERNAVUR CHENNAI,TAMIL NADU-600057','','2026-10-23','TN63BF1607','Chennai','Pondy','M/S.ALLIANZ BIOSCIENCES PRIVATE LIMITED.,R.S.NO. 55/1,2,3  ALLIANZ BIOS WHIRLPOOL ROAD, MANNADIPET COMMUNETHIRUVANDARKOIL Puducherry,PUDUCHERRY-605102','07 - PALLETS','VIALS- 48ML','F T L','To be billed in Chennai','','','','','','2026-10-10','4329967','2026-10-10','3530839.97','','2026-10-23','3988/30-Cuddalore','Lakshmanan','20 Feet Container','Unloaded by party',25,'2026-10-23 19:52:43','2026-10-23',0,NULL,NULL),
(44,'5044',0,'M/s.Tablets India Limited., No.179, T H Road, Tondiarpet, Chennai-600081(Dispatch from ALL CARGO CFS)','','2026-10-26','TN32BK1791 ','Chennai','Pondy','M/s.Tablets India Limited., Plot No.3,1st Cross Street, Ravichandren Nagar,Thiruvandarkoil, Puducherry','11 Pallets','ISOMALT DC 101 IMP','F T L','To be billed in Chennai','','','','','','2026-10-26','FCC2627/TTX00021','2026-10-26','3073558','','2026-10-26','11064/29','Vinayagam','20 Feet Container','Unloaded by party',25,'2026-10-26 20:09:20','2026-10-26',0,NULL,NULL),
(45,'5045',0,'M/s.Tablets India Limited.,KVT Garden, Phase-2, Plot No. 5/6/17, VS Mani Street,VS Mani Nagar,100 Feet Road, Madavaram,Chennai-600060','','2026-10-26','MH04HD2484','Chennai','Hubli','THE MEDICAL SUPERINTENDENT - HUBLI, HBL Regional Stores, ESI Hospital, Karwar Road, Hubli-580024','171','H L MEDICINES','F T L','To be billed in Chennai','','','','','','2026-10-26','DCH2627/I1400946,I1400914,I1400927,I1400901,I1400907,I1400941,I1500034,I1400921,I1400933','2026-10-26','1182187','','2026-10-26','2923/28-Pune','Pradeep','14 Feet','Unloaded by party',25,'2026-10-26 20:16:00','2026-10-26',0,NULL,NULL),
(46,'5046',0,'M/s.Tablets India Limited.,KVT Garden, Phase-2, Plot No. 5/6/17, VS Mani Street,VS Mani Nagar,100 Feet Road, Madavaram,Chennai-600060','','2026-10-27','TN66V6322 ','Chennai','Bangalore','THE DEPUTY DIRECTOR, RNR REGIONAL STORES, Directorate of ESIS(Medical) Services Rajaji Nagar, Bangalore-560010','86','H L MEDICINES','F T L','To be billed in Chennai','','','','','','2026-10-27','DCH2627/I1400949,I1400964,I1400943,I1400923,I1400903,I1400931,I1400910,I1400937','2026-10-27','930816','','2026-10-27','TN34-2888/27','Prakash M','14 FEET CONTAINER','Door delivery',25,'2026-10-27 15:02:42','2026-10-27',0,NULL,NULL),
(47,'5047',0,'M/s.Tablets India Limited.,KVT Garden, Phase-2, Plot No. 5/6/17, VS Mani Street,VS Mani Nagar,100 Feet Road, Madavaram,Chennai-600060','','2026-10-27','TN66V6322 ','Chennai','Bangalore','THE MEDICAL SUPERINTENDENT -INDIRA NAGAR, INR REGIONAL STORES, ESI Hospital, Indiranagar,Bangalore-560038','192','H L MEDICINES','F T L','To be billed in Chennai','','','','','','2026-10-27','DCH2627/I1400934,I1400938,I1400911,I1400963,I1400918,I1400950,I1400904,I1400944,I1400965,I1400924','2026-10-27','1563226','','2026-10-27','TN34-2888/27','Prakash M','14 FEET CONTAINER','Door delivery',25,'2026-10-27 15:12:17','2026-10-27',0,NULL,NULL),
(48,'5048',0,'M/s.Tablets India Limited., No.179, T H Road, Tondiarpet, Chennai-600081','','2026-10-28','TN03AH5530','Tondiarpet','Ennore','TABLETS MEDOPHARM PRIVATE LIMITED,CONTAINER FREIGHT STATION NO 144,CHENNAI,600120 - DELIVERY AT Ennore Cargo Container Terminal Pvt Ltd','177','MEDICINES','F T L','To be billed in Chennai','','','','','','2026-10-28','FCF2627/I4100011','2026-10-28','AS PER INVOICE','','2026-10-28','0467/38-Chennai','Bala','407 Closed','Unloaded by party',25,'2026-10-28 11:53:16','2026-10-28',0,NULL,NULL),
(49,'5049',0,'M/s.Tablets India Limited., No.555/32, T H Road,Tondiarpet, Chennai-600081','','2026-10-28','TN64U5108','Chennai','Vijayawada','M/s.Tablets India Limited.,Door No. 76-1-5/2, Dargha Backside Road, Bhavanipuram, Vijayawada','305','AQUA PRODUCTS','','To be billed in Chennai','','','','','','2026-10-28','FCA2627/TBS00020-TTX00017','2026-10-28','AS PER INVOICE','','2026-10-28','4532/30-Dindugal','R Balamurugan','20 Feet Container','Unloaded by party',25,'2026-10-28 20:57:41','2026-10-28',0,NULL,NULL),
(50,'5050',0,'M/s.Tablets India Limited., No.179, T H Road, Tondiarpet, Chennai-600081','','2026-10-28','TN64U5108','Chennai','Vijayawada','M/s.Tablets India Limited.,Door No. 76-1-5/2, Dargha Backside Road, Bhavanipuram, Vijayawada','176','H L MEDICINES','F T L','To be billed in Chennai','','','','','','2026-10-28','FCF2627/TTX00619,WOS2627/TTX00582,FFD2627/TTX00216,FHB2627/TTX00088,FCF2627/TTX00617','2026-10-28','AS PER INVOICE','','2026-10-28','4532/30-Dindugal','R Balamurugan','20 Feet Container','Unloaded by party',25,'2026-10-28 21:00:31','2026-10-28',0,NULL,NULL),
(51,'5051',1,'JASWA VIJAY','9597451419','2026-11-04','TRUCK','from','to','SBS WATER & INFRA PROJECTS PVT LTD.,','10','sdsdsdsdsd','100','','10','100','1233','qasddd','12','2026-11-04','212121','2026-11-04','aasas','122121','2026-11-04','212121','asasas','assa','Door delivery',1,'2026-11-04 10:43:09','2026-11-04',0,NULL,NULL),
(52,'5052',0,'Checking for LR report is ok or not should hgidlssk','3434343434','2026-11-04','dssdds','32sds','dsds','Checking for LR report is ok or not should hgidlssk ddssdds','sasasa\r\ndsdsds\r\ndsds\r\n','sddsdsdsdsdsdsds\r\ndsdsds\r\ndsds','10','','1','1','1','ssdsd','2wqwq','2026-11-04','ssd','2026-11-04','dssdds','33223','2026-11-24','sdsd','ds','ds','By transporter',1,'2026-11-04 10:48:13','2026-11-04',0,NULL,NULL);

/*Table structure for table `transport_supplier_payment` */

DROP TABLE IF EXISTS `transport_supplier_payment`;

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
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `transport_supplier_payment` */

insert  into `transport_supplier_payment`(`id`,`lr_id`,`payment_type`,`payment_mode`,`paid_amount`,`notes`,`entry_user`,`entry_date_time`) values 
(1,1,2,1,5000,NULL,25,'2026-06-23 19:25:29'),
(2,2,2,1,12500,NULL,25,'2026-06-24 19:33:42'),
(3,3,2,1,5000,NULL,25,'2026-06-24 19:35:55'),
(4,4,2,1,13000,NULL,25,'2026-06-24 19:43:57'),
(5,5,2,1,50000,NULL,25,'2026-06-24 19:45:51'),
(6,6,2,1,5500,NULL,25,'2026-06-24 19:46:23'),
(7,7,2,1,30000,NULL,25,'2026-06-24 19:47:35'),
(8,8,2,1,36000,NULL,25,'2026-06-24 19:49:43'),
(9,9,1,0,26000,NULL,25,'2026-06-24 19:51:34'),
(10,10,2,1,5500,NULL,25,'2026-06-24 19:52:36'),
(11,11,2,1,1800,NULL,25,'2026-06-24 19:55:09'),
(12,12,2,1,7500,NULL,25,'2026-06-24 19:56:40'),
(13,13,2,1,6500,NULL,25,'2026-06-24 19:58:33'),
(14,14,2,1,9000,NULL,25,'2026-06-24 20:00:49'),
(15,15,2,1,12000,NULL,25,'2026-06-24 20:01:56'),
(16,16,2,1,62000,NULL,25,'2026-06-24 20:06:00'),
(17,17,2,1,7000,NULL,25,'2026-06-24 20:07:05'),
(18,18,2,1,8500,NULL,25,'2026-06-24 20:09:48'),
(19,19,2,1,2800,NULL,25,'2026-06-25 19:17:41'),
(20,20,2,1,12000,NULL,25,'2026-06-25 19:19:26'),
(21,21,2,1,22500,NULL,25,'2026-06-25 21:02:31'),
(22,22,2,1,22200,NULL,25,'2026-06-25 21:04:33'),
(23,23,2,1,7500,NULL,25,'2026-06-25 21:05:54'),
(24,24,2,1,7000,NULL,25,'2026-06-25 21:06:47'),
(25,25,2,1,60000,NULL,25,'2026-06-25 21:10:07'),
(26,26,2,1,36000,NULL,25,'2026-06-25 21:14:46'),
(27,27,2,1,36000,NULL,25,'2026-06-25 21:19:13'),
(28,28,2,1,8100,NULL,25,'2026-06-25 21:20:59'),
(29,29,1,0,7500,NULL,25,'2026-06-25 21:22:34'),
(30,30,1,0,5000,NULL,25,'2026-06-26 19:20:23'),
(31,31,1,0,11000,NULL,25,'2026-06-26 19:21:33'),
(32,32,1,0,9000,NULL,25,'2026-06-26 19:22:49'),
(33,33,2,1,8000,NULL,25,'2026-06-26 19:24:06'),
(34,34,2,1,8500,NULL,25,'2026-06-26 19:25:09'),
(35,35,2,1,22000,NULL,25,'2026-06-26 19:32:06'),
(36,36,2,1,4000,NULL,25,'2026-06-26 19:32:57'),
(37,37,2,1,13000,NULL,25,'2026-06-26 19:34:24'),
(38,38,2,1,32000,NULL,25,'2026-06-26 19:41:36'),
(39,39,2,1,25000,NULL,25,'2026-06-26 19:44:11'),
(40,40,2,1,8000,NULL,25,'2026-06-26 19:48:59'),
(41,41,2,1,9000,NULL,25,'2026-06-26 19:49:44'),
(42,42,2,1,22000,NULL,25,'2026-06-26 19:51:18'),
(43,43,2,1,20000,NULL,25,'2026-06-26 19:53:10'),
(44,44,2,1,30000,NULL,25,'2026-06-26 19:54:10'),
(45,48,2,1,10800,NULL,25,'2026-06-29 19:59:34'),
(46,49,2,1,5000,NULL,25,'2026-06-29 20:01:19'),
(47,50,2,1,9500,NULL,25,'2026-06-29 20:04:46'),
(48,51,2,1,21000,NULL,25,'2026-06-29 20:06:04'),
(49,52,2,1,7000,NULL,25,'2026-06-29 20:09:24'),
(50,53,2,1,8500,NULL,25,'2026-07-02 12:06:08'),
(51,54,2,1,15000,NULL,25,'2026-07-02 12:07:24'),
(52,55,2,1,13000,NULL,25,'2026-07-02 12:08:11'),
(53,56,2,1,62000,NULL,25,'2026-07-02 12:09:00'),
(54,57,2,1,5500,NULL,25,'2026-07-02 12:09:34'),
(55,58,2,1,62000,NULL,25,'2026-07-03 15:42:06'),
(56,59,2,1,7500,NULL,25,'2026-07-04 21:48:52'),
(57,60,2,1,8750,NULL,25,'2026-07-04 21:49:57'),
(58,61,2,1,7500,NULL,25,'2026-07-04 21:51:37'),
(59,62,2,1,5000,NULL,25,'2026-07-04 21:52:34'),
(60,63,2,1,21500,NULL,25,'2026-07-04 21:53:24'),
(61,64,2,1,1000,NULL,25,'2026-07-05 14:00:34'),
(62,65,2,1,1000,NULL,25,'2026-07-05 14:01:09'),
(63,66,2,1,12700,NULL,25,'2026-07-10 18:58:53'),
(64,67,2,1,12100,NULL,25,'2026-07-10 18:59:51'),
(65,68,2,1,8000,NULL,25,'2026-07-10 19:00:47'),
(66,69,2,1,5500,NULL,25,'2026-07-10 19:01:41'),
(67,71,2,1,10500,NULL,25,'2026-07-18 14:18:56'),
(68,72,2,1,26500,NULL,25,'2026-07-18 14:20:19'),
(69,73,2,1,17000,NULL,25,'2026-07-18 18:54:24'),
(70,74,2,1,14000,NULL,25,'2026-07-18 18:55:26'),
(71,75,2,1,20000,NULL,25,'2026-07-18 18:56:38'),
(72,76,2,1,28000,NULL,25,'2026-07-18 18:57:43'),
(73,77,2,1,6000,NULL,25,'2026-07-18 18:59:22'),
(74,78,2,1,6500,NULL,25,'2026-07-18 19:00:25'),
(75,79,2,1,8500,NULL,25,'2026-07-18 19:01:23'),
(76,80,2,1,15000,NULL,25,'2026-07-18 19:02:20'),
(77,81,2,1,6500,NULL,25,'2026-07-24 10:55:19'),
(78,82,2,1,66000,NULL,25,'2026-07-28 10:11:35'),
(79,83,2,1,36000,NULL,25,'2026-07-28 10:14:12'),
(80,84,2,1,7000,NULL,25,'2026-07-28 10:14:54'),
(81,85,2,1,5500,NULL,25,'2026-07-28 10:15:27'),
(82,86,2,1,1600,NULL,25,'2026-07-31 21:16:22'),
(83,87,2,1,5000,NULL,25,'2026-07-31 21:17:17'),
(84,88,2,1,20000,NULL,25,'2026-07-31 21:18:21'),
(85,89,2,1,7000,NULL,25,'2026-07-31 21:19:50'),
(86,90,2,1,82000,NULL,25,'2026-07-31 21:21:53'),
(87,91,2,1,10000,NULL,25,'2026-07-31 21:23:14'),
(88,93,2,1,20000,NULL,25,'2026-07-31 21:25:40'),
(89,94,2,1,8500,NULL,25,'2026-07-31 21:26:26'),
(90,95,2,1,65000,NULL,25,'2026-07-31 21:28:46'),
(91,96,2,1,21640,NULL,25,'2026-07-31 21:37:05'),
(92,97,2,1,1500,NULL,25,'2026-07-31 21:38:00'),
(93,98,2,1,7800,NULL,25,'2026-07-31 21:39:36'),
(94,99,2,1,9000,NULL,25,'2026-07-31 21:42:15'),
(95,100,2,1,7500,NULL,25,'2026-07-31 21:44:38'),
(96,101,2,1,8500,NULL,25,'2026-07-31 21:45:55'),
(97,92,2,1,4800,NULL,25,'2026-07-31 21:51:16'),
(98,102,2,1,22000,NULL,25,'2026-08-03 13:11:47'),
(99,103,2,1,10000,NULL,25,'2026-08-04 23:28:40'),
(100,104,2,1,10000,NULL,25,'2026-08-04 23:29:18'),
(101,105,2,1,28500,NULL,25,'2026-08-06 08:52:05'),
(102,106,2,1,92000,NULL,25,'2026-08-06 12:04:19'),
(103,107,2,1,38000,NULL,25,'2026-08-07 12:13:58'),
(104,108,2,1,60000,NULL,25,'2026-08-10 11:27:42'),
(105,109,2,1,8500,NULL,25,'2026-08-10 11:28:55'),
(106,110,2,1,9000,NULL,25,'2026-08-10 11:39:38'),
(107,111,2,1,10000,NULL,25,'2026-08-10 11:40:32'),
(108,112,2,1,10500,NULL,25,'2026-08-10 11:48:25'),
(109,113,2,1,51000,NULL,25,'2026-08-10 11:51:08'),
(110,114,2,1,17500,NULL,25,'2026-08-10 11:52:19'),
(111,115,2,1,29500,NULL,25,'2026-08-10 11:54:07'),
(112,116,2,1,31500,NULL,25,'2026-08-10 11:54:49'),
(113,117,2,1,32500,NULL,25,'2026-08-12 11:03:04'),
(114,118,2,1,4500,NULL,25,'2026-08-13 19:48:30'),
(115,119,2,1,3500,NULL,25,'2026-08-13 19:49:11'),
(116,120,2,1,67000,NULL,25,'2026-08-18 10:46:48'),
(117,121,2,1,6500,NULL,25,'2026-08-18 10:59:19'),
(118,122,2,1,38000,NULL,25,'2026-08-28 13:15:42'),
(119,123,2,1,17500,NULL,25,'2026-08-28 13:21:47'),
(120,124,2,1,272000,NULL,25,'2026-08-28 20:13:43'),
(121,125,2,1,15000,NULL,25,'2026-09-04 11:47:22'),
(122,126,2,1,10000,NULL,25,'2026-09-04 11:48:28'),
(123,127,2,1,15000,NULL,25,'2026-09-04 11:49:42'),
(124,128,2,1,7500,NULL,25,'2026-09-04 11:50:46'),
(125,129,2,1,14000,NULL,25,'2026-09-04 11:51:56'),
(126,130,2,1,17000,NULL,25,'2026-09-04 11:53:25'),
(127,131,2,1,8000,NULL,25,'2026-09-04 11:54:08'),
(128,132,2,1,8000,NULL,25,'2026-09-04 11:55:25'),
(129,133,2,1,11000,NULL,25,'2026-09-04 11:56:58'),
(130,134,2,1,13000,NULL,25,'2026-09-04 12:04:13'),
(131,135,2,1,1900,NULL,25,'2026-09-04 12:04:58'),
(132,136,2,1,49000,NULL,25,'2026-09-04 12:11:34'),
(133,137,2,1,7200,NULL,25,'2026-09-04 12:12:42'),
(134,138,2,1,20000,NULL,25,'2026-09-04 12:13:42'),
(135,139,2,1,21000,NULL,25,'2026-09-04 12:15:09'),
(136,140,2,1,49000,NULL,25,'2026-09-04 12:17:56'),
(137,141,2,1,9000,NULL,25,'2026-09-04 12:19:02'),
(138,142,2,1,4000,NULL,25,'2026-09-04 12:20:37'),
(139,143,2,1,20500,NULL,25,'2026-09-04 12:23:18'),
(140,144,2,1,9000,NULL,25,'2026-09-04 12:24:58'),
(141,145,1,0,20000,NULL,25,'2026-09-04 12:27:02'),
(142,146,2,1,52000,NULL,25,'2026-09-04 12:30:29'),
(143,147,2,1,1000,NULL,25,'2026-09-04 12:36:04'),
(144,148,2,1,1000,NULL,25,'2026-09-04 12:36:43'),
(145,149,2,1,23000,NULL,25,'2026-09-04 13:04:39'),
(146,150,2,1,61000,NULL,25,'2026-09-07 20:09:26'),
(147,151,2,1,26000,NULL,25,'2026-09-07 20:10:23'),
(148,152,2,1,16000,NULL,25,'2026-09-07 20:11:04'),
(149,153,2,1,27000,NULL,25,'2026-09-07 20:11:48'),
(150,154,2,1,2000,NULL,25,'2026-09-10 19:04:07'),
(151,155,2,1,51000,NULL,25,'2026-09-21 13:26:26'),
(152,156,2,1,51000,NULL,25,'2026-09-21 13:28:16'),
(153,157,1,0,17000,NULL,25,'2026-09-21 13:30:38'),
(154,158,2,1,17000,NULL,25,'2026-09-21 13:33:18'),
(155,159,2,1,7000,NULL,25,'2026-09-21 13:46:54'),
(156,160,2,1,13000,NULL,25,'2026-09-21 13:52:25'),
(157,161,1,0,12000,NULL,25,'2026-09-21 13:54:36'),
(158,162,2,1,3500,NULL,25,'2026-09-21 13:55:17'),
(159,163,2,1,5500,NULL,25,'2026-09-21 13:56:21'),
(160,164,2,1,7500,NULL,25,'2026-09-28 13:06:22'),
(161,165,2,1,25000,NULL,25,'2026-10-04 19:37:18'),
(162,166,2,1,6500,NULL,25,'2026-10-04 19:43:53'),
(163,167,2,1,7500,NULL,25,'2026-10-04 19:51:53'),
(164,168,2,1,10000,NULL,25,'2026-10-04 19:57:57'),
(165,169,2,1,10000,NULL,25,'2026-10-04 19:58:30'),
(166,170,2,1,8000,NULL,25,'2026-10-04 20:49:37'),
(167,171,2,1,9000,NULL,25,'2026-10-06 09:46:19'),
(168,172,2,1,4000,NULL,25,'2026-10-07 19:32:24'),
(169,173,2,1,9200,NULL,25,'2026-10-07 19:34:14'),
(170,174,2,1,9000,NULL,25,'2026-10-07 19:36:26'),
(171,175,2,1,9000,NULL,25,'2026-10-07 19:38:01'),
(172,176,2,1,7500,NULL,25,'2026-10-07 19:39:10'),
(173,177,2,1,9000,NULL,25,'2026-10-07 19:40:29'),
(174,178,2,1,7000,NULL,25,'2026-10-07 19:41:35'),
(175,179,2,1,15000,NULL,25,'2026-10-07 19:42:52'),
(176,180,2,1,7000,NULL,25,'2026-10-07 19:44:06'),
(177,181,2,1,8000,NULL,25,'2026-10-07 19:45:27'),
(178,182,2,1,9000,NULL,25,'2026-10-07 19:46:52'),
(179,183,2,1,9000,NULL,25,'2026-10-07 19:47:33'),
(180,184,2,1,15900,NULL,25,'2026-10-07 19:48:52'),
(181,185,2,1,11000,NULL,25,'2026-10-07 19:49:55'),
(182,186,2,1,26000,NULL,25,'2026-10-07 19:52:17'),
(183,187,2,1,26000,NULL,25,'2026-10-07 20:06:03'),
(184,188,2,1,68500,NULL,25,'2026-10-07 20:11:38'),
(185,189,2,1,8500,NULL,25,'2026-10-08 17:35:49'),
(186,190,2,1,5000,NULL,25,'2026-10-08 17:36:35'),
(187,191,2,1,21000,NULL,25,'2026-10-08 17:37:53'),
(188,192,2,1,4500,NULL,25,'2026-10-08 17:39:41'),
(189,193,2,1,12500,NULL,25,'2026-10-08 17:49:05'),
(190,194,2,1,11000,NULL,25,'2026-10-08 17:52:46'),
(191,195,2,1,20000,NULL,25,'2026-10-08 17:54:03'),
(192,196,2,1,4000,NULL,25,'2026-10-08 17:55:39'),
(193,197,2,1,3000,NULL,25,'2026-10-08 17:56:19'),
(194,198,2,1,7700,NULL,25,'2026-10-08 17:58:08'),
(195,199,2,1,21000,NULL,25,'2026-10-08 17:59:52'),
(196,200,2,1,7500,NULL,25,'2026-10-08 18:02:00'),
(197,201,2,1,5000,NULL,25,'2026-10-08 18:03:08'),
(198,202,2,1,9000,NULL,25,'2026-10-08 18:03:49'),
(199,203,2,1,6500,NULL,25,'2026-10-08 18:20:23'),
(200,204,2,1,36000,NULL,25,'2026-10-08 18:31:15'),
(201,205,2,1,61500,NULL,25,'2026-10-13 09:47:18'),
(202,206,2,1,5500,NULL,25,'2026-10-13 09:48:01'),
(203,207,2,1,5600,NULL,25,'2026-10-13 09:49:43'),
(204,208,2,1,41000,NULL,25,'2026-10-15 10:14:00'),
(205,209,2,1,13000,NULL,25,'2026-10-15 10:15:12'),
(206,210,2,1,32500,NULL,25,'2026-10-15 10:26:09'),
(207,211,2,1,32500,NULL,25,'2026-10-15 10:31:13'),
(208,212,2,1,46000,NULL,25,'2026-10-19 13:54:41'),
(209,213,2,1,64000,NULL,25,'2026-10-23 00:36:37'),
(210,214,2,1,14000,NULL,25,'2026-10-27 13:34:25'),
(211,215,2,1,4000,NULL,25,'2026-10-27 13:34:58'),
(212,216,2,1,6500,NULL,25,'2026-10-27 13:35:55'),
(213,217,2,1,46000,NULL,25,'2026-10-29 09:53:15'),
(214,218,2,1,102500,NULL,25,'2026-10-29 12:53:54'),
(215,219,2,1,94500,NULL,25,'2026-10-29 12:55:04'),
(216,220,1,0,100,NULL,1,'2026-11-04 11:04:58');

/*Table structure for table `user_modules` */

DROP TABLE IF EXISTS `user_modules`;

CREATE TABLE `user_modules` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `module_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

/*Data for the table `user_modules` */

insert  into `user_modules`(`id`,`module_name`) values 
(1,'LR Order'),
(2,'LR Order List'),
(3,'Transportation Bill'),
(4,'Balance Collection'),
(5,'Supplier collection'),
(6,'Collection Report'),
(7,'Supplier collection Report'),
(8,'Profit Report'),
(9,'Master'),
(10,'Admin'),
(12,'LR Copy');

/*Table structure for table `user_permission` */

DROP TABLE IF EXISTS `user_permission`;

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

/*Data for the table `user_permission` */

insert  into `user_permission`(`id`,`module_id`,`uid`,`date`,`time`) values 
(133,1,25,'2026-07-11','15:46:17'),
(134,2,25,'2026-07-11','15:46:17'),
(135,3,25,'2026-07-11','15:46:17'),
(136,4,25,'2026-07-11','15:46:17'),
(137,5,25,'2026-07-11','15:46:17'),
(138,6,25,'2026-07-11','15:46:17'),
(139,7,25,'2026-07-11','15:46:17'),
(140,8,25,'2026-07-11','15:46:17'),
(141,9,25,'2026-07-11','15:46:17'),
(142,10,25,'2026-07-11','15:46:17'),
(143,12,25,'2026-07-11','15:46:17'),
(144,1,1,'2026-07-11','15:46:49'),
(145,2,1,'2026-07-11','15:46:49'),
(146,3,1,'2026-07-11','15:46:49'),
(147,4,1,'2026-07-11','15:46:49'),
(148,5,1,'2026-07-11','15:46:49'),
(149,6,1,'2026-07-11','15:46:49'),
(150,7,1,'2026-07-11','15:46:49'),
(151,8,1,'2026-07-11','15:46:49'),
(152,9,1,'2026-07-11','15:46:49'),
(153,10,1,'2026-07-11','15:46:49'),
(154,12,1,'2026-07-11','15:46:49');

/*Table structure for table `user_special_permission` */

DROP TABLE IF EXISTS `user_special_permission`;

CREATE TABLE `user_special_permission` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `content_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `user_special_permission` */

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `is_active` int DEFAULT '1',
  `fullName` varchar(255) DEFAULT NULL,
  `disc_per` int DEFAULT '100',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`id`,`user_name`,`password`,`is_active`,`fullName`,`disc_per`) values 
(1,'admin','aecbf9a63cec1e93327dfc212f31acdb31c4f5d10bedccf8fbb8b042a6f0f39155797bdd04517905ae5d98b69fdc452cdb61b018e10939740ec96f36e133d639',1,'admin',50),
(25,'mahesh','3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2',1,'Mahesh',100);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

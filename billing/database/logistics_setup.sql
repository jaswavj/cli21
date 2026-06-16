-- ============================================================
-- Logistics Order Table Setup
-- ============================================================

CREATE TABLE IF NOT EXISTS `transport_bill_order` (
  `id`              INT(11)      NOT NULL AUTO_INCREMENT,
  `supplier_id`     INT(11)      NOT NULL,
  `lr_date`         DATE         NOT NULL,
  `lr_no`           TEXT         NOT NULL,
  `customer_id`     INT(11)      NOT NULL,
  `destination`     VARCHAR(255) NOT NULL,
  `dpf`             DOUBLE       NOT NULL DEFAULT 0,
  `lh`              DOUBLE       NOT NULL DEFAULT 0,
  `load_amt`        DOUBLE       NOT NULL DEFAULT 0,
  `ul`              DOUBLE       NOT NULL DEFAULT 0,
  `hoting`          DOUBLE       NOT NULL DEFAULT 0,
  `lc`              DOUBLE       NOT NULL DEFAULT 0,
  `is_billed`       TINYINT(1)   NOT NULL DEFAULT 1,
  `is_active`       TINYINT(1)   NOT NULL DEFAULT 1,
  `entry_user`      INT(11)      NOT NULL,
  `entry_date_time` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_supplier_id` (`supplier_id`),
  KEY `idx_customer_id` (`customer_id`),
  KEY `idx_lr_date`     (`lr_date`),
  CONSTRAINT `fk_tbo_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `prod_supplier` (`id`),
  CONSTRAINT `fk_tbo_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers`     (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

-- Add LC column (run if table already exists)
ALTER TABLE `transport_bill_order` ADD COLUMN `lc` DOUBLE NOT NULL DEFAULT 0 AFTER `ul`;

-- Add cancel tracking columns (run if table already exists)
ALTER TABLE `transport_bill_order` ADD COLUMN `cancel_uid` INT NULL DEFAULT NULL AFTER `entry_user`;
ALTER TABLE `transport_bill_order` ADD COLUMN `cancel_date_time` DATETIME NULL DEFAULT NULL AFTER `cancel_uid`;

-- Add cancel tracking to transport_bill (run if table already exists)
ALTER TABLE `transport_bill` ADD COLUMN `cancel_uid` INT NULL DEFAULT NULL AFTER `is_cancelled`;
ALTER TABLE `transport_bill` ADD COLUMN `cancel_date_time` DATETIME NULL DEFAULT NULL AFTER `cancel_uid`;

-- Add entry_date_time to transport_bill_payment (run if not present)
ALTER TABLE `transport_bill_payment` ADD COLUMN `entry_date_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `entry_user`;

-- ============================================================
-- Logistics Order Table Setup
-- ============================================================

CREATE TABLE IF NOT EXISTS `logistics` (
  `id`              INT(11)      NOT NULL AUTO_INCREMENT,
  `supplier_id`     INT(11)      NOT NULL,
  `lr_date`         DATE         NOT NULL,
  `lr_no`           VARCHAR(100) NOT NULL,
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
  CONSTRAINT `fk_logistics_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `prod_supplier` (`id`),
  CONSTRAINT `fk_logistics_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers`     (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

-- Add LC column (run if table already exists)
ALTER TABLE `logistics` ADD COLUMN `lc` DOUBLE NOT NULL DEFAULT 0 AFTER `ul`;

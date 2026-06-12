-- ============================================================
-- Transport Bill Tables Setup
-- Run once to create tables and extend company_details
-- ============================================================

-- ─── 1. Transport Bill Header ────────────────────────────────
CREATE TABLE IF NOT EXISTS `transport_bill` (
  `id`            INT(11)      NOT NULL AUTO_INCREMENT,
  `invoice_no`    VARCHAR(20)  NOT NULL,
  `bill_date`     DATE         NOT NULL,
  `customer_id`   INT(11)      NOT NULL,
  `po_no`         VARCHAR(100) DEFAULT NULL,
  `sac_code`      VARCHAR(50)  DEFAULT NULL,
  `grand_total`   DOUBLE       NOT NULL DEFAULT 0,
  `paid_amount`   DOUBLE       NOT NULL DEFAULT 0,
  `balance`       DOUBLE       NOT NULL DEFAULT 0,
  `payment_mode`  VARCHAR(50)  NOT NULL DEFAULT 'Credit',
  `credit_days`   INT          DEFAULT NULL,
  `due_date`      DATE         DEFAULT NULL,
  `is_cancelled`  TINYINT(1)   NOT NULL DEFAULT 0,
  `entry_user`    INT(11)      NOT NULL,
  `entry_date`    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_tb_customer` (`customer_id`),
  KEY `idx_tb_date`     (`bill_date`),
  KEY `idx_tb_invoice`  (`invoice_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ─── 2. Transport Bill — LR Level (one row per LR per bill) ──
CREATE TABLE IF NOT EXISTS `transport_bill_lr` (
  `id`           INT(11)  NOT NULL AUTO_INCREMENT,
  `bill_id`      INT(11)  NOT NULL,
  `logistics_id` INT(11)  NOT NULL,
  `lr_total`     DOUBLE   NOT NULL DEFAULT 0,
  `notes`        TEXT     DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_tblr_bill`  (`bill_id`),
  KEY `idx_tblr_lr`    (`logistics_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ─── 3. Transport Bill Details (one row per particular) ───────
CREATE TABLE IF NOT EXISTS `transport_bill_details` (
  `id`           INT(11)      NOT NULL AUTO_INCREMENT,
  `bill_id`      INT(11)      NOT NULL,
  `bill_lr_id`   INT(11)      NOT NULL,
  `logistics_id` INT(11)      NOT NULL,
  `particular`   VARCHAR(255) NOT NULL,
  `qty`          VARCHAR(50)  DEFAULT NULL,
  `rate_wt`      VARCHAR(100) DEFAULT NULL,
  `amount`       DOUBLE       NOT NULL DEFAULT 0,
  `sort_order`   INT(11)      NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_tbd_bill`    (`bill_id`),
  KEY `idx_tbd_bill_lr` (`bill_lr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ─── 4. Transport Bill Balance — Credit Collection Tracker ───
--  When payment_mode = 'Credit', a balance record is created.
--  When the customer pays later, update collected_amount / is_collected.
CREATE TABLE IF NOT EXISTS `transport_bill_balance` (
  `id`               INT(11)     NOT NULL AUTO_INCREMENT,
  `bill_id`          INT(11)     NOT NULL,
  `balance_amount`   DOUBLE      NOT NULL DEFAULT 0,
  `due_date`         DATE        NOT NULL,
  `collected_amount` DOUBLE      NOT NULL DEFAULT 0,
  `collected_date`   DATE        DEFAULT NULL,
  `collected_mode`   VARCHAR(50) DEFAULT NULL,
  `is_collected`     TINYINT(1)  NOT NULL DEFAULT 0,
  `notes`            TEXT        DEFAULT NULL,
  `entry_date`       DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_tbb_bill`      (`bill_id`),
  KEY `idx_tbb_due`       (`due_date`),
  KEY `idx_tbb_collected` (`is_collected`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ─── 5. (No schema changes to company_details required)
--  Bank details are read directly from the existing company_details.bank_details column.

-- ─── 6. Add payment_type column to transport_bill (run once) ─
ALTER TABLE `transport_bill`
    ADD COLUMN IF NOT EXISTS `payment_type` TINYINT NOT NULL DEFAULT 1
    COMMENT '1=Cash 2=Bank 3=Mixed' AFTER `payment_mode`;

-- ─── 7. Transport Bill Payment Records ───────────────────────
--  One row per bill at time of save. Tracks type, mode, amount.
CREATE TABLE IF NOT EXISTS `transport_bill_payment` (
  `id`            INT(11)      NOT NULL AUTO_INCREMENT,
  `bill_id`       INT(11)      NOT NULL,
  `payment_type`  TINYINT      NOT NULL DEFAULT 1 COMMENT '1=Cash 2=Bank 3=Mixed',
  `payment_mode`  TINYINT      NOT NULL DEFAULT 0 COMMENT '0=None 1=UPI 2=Cheque 3=CreditCard 4=DebitCard 5=NEFT 6=IMPS',
  `paid_amount`   DOUBLE       NOT NULL DEFAULT 0,
  `notes`         VARCHAR(255) DEFAULT NULL,
  `entry_user`    INT(11)      DEFAULT NULL,
  `entry_date`    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_tbp_bill` (`bill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

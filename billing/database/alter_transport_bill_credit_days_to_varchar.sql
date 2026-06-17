-- Convert transport_bill.credit_days from INT to VARCHAR
-- Run this once on existing databases.

ALTER TABLE `transport_bill`
    MODIFY COLUMN `credit_days` VARCHAR(50) DEFAULT NULL;

ALTER TABLE `transport_bill_details`
    ADD COLUMN IF NOT EXISTS `lr_no` VARCHAR(100) DEFAULT NULL AFTER `logistics_id`;

ALTER TABLE `transport_bill_lr`
    DROP COLUMN IF EXISTS `lr_no`;

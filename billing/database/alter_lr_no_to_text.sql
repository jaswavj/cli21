-- Convert LR No column from VARCHAR to TEXT for longer/multi-line values.
ALTER TABLE `transport_bill_order`
MODIFY COLUMN `lr_no` TEXT NOT NULL;

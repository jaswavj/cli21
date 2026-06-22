-- ============================================================
-- Add LR Date column to transport_bill_details
-- Run this once to add lr_date column
-- ============================================================

-- Add lr_date column after lr_no
ALTER TABLE `transport_bill_details`
ADD COLUMN `lr_date` DATE DEFAULT NULL AFTER `lr_no`;

-- Note: qty is already VARCHAR(50) in transport_bill_details, no conversion needed

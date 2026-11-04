-- Prepare LR: allow long / multiline No of Articles and Description
ALTER TABLE `transport_lr_copy`
    MODIFY COLUMN `no_of_articles` TEXT DEFAULT NULL,
    MODIFY COLUMN `description_text` TEXT DEFAULT NULL;

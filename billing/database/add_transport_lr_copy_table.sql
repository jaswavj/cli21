-- LR Copy table for Logistics > Prepare LR
CREATE TABLE IF NOT EXISTS transport_lr_copy (
    id INT NOT NULL AUTO_INCREMENT,
    lr_no VARCHAR(20) NOT NULL,
    customer_id INT DEFAULT 0,
    customer_name VARCHAR(255) DEFAULT NULL,
    phone_number VARCHAR(30) DEFAULT NULL,
    lr_date DATE DEFAULT NULL,
    truck_no VARCHAR(100) DEFAULT NULL,
    from_location VARCHAR(255) DEFAULT NULL,
    to_location VARCHAR(255) DEFAULT NULL,
    consignee_name VARCHAR(255) DEFAULT NULL,

    no_of_articles VARCHAR(100) DEFAULT NULL,
    description_text VARCHAR(255) DEFAULT NULL,
    weight_mt VARCHAR(100) DEFAULT NULL,

    mode_payment1 VARCHAR(255) DEFAULT NULL,
    freight_amount VARCHAR(100) DEFAULT NULL,
    to_pay_amount VARCHAR(100) DEFAULT NULL,
    paid_amount VARCHAR(100) DEFAULT NULL,

    amount_in_words VARCHAR(500) DEFAULT NULL,
    dc_no VARCHAR(100) DEFAULT NULL,
    inv_date DATE DEFAULT NULL,
    inv_no VARCHAR(100) DEFAULT NULL,
    inv_date2 DATE DEFAULT NULL,
    declared_value_rs VARCHAR(100) DEFAULT NULL,
    pnl_seal_no VARCHAR(100) DEFAULT NULL,
    material_received_date DATE DEFAULT NULL,
    pnl_no VARCHAR(100) DEFAULT NULL,
    driver_name VARCHAR(255) DEFAULT NULL,
    vehicle_type VARCHAR(100) DEFAULT NULL,
    deliver_in VARCHAR(50) DEFAULT NULL,

    entry_user INT NOT NULL,
    entry_date_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    entry_date DATE DEFAULT NULL,

    is_cancelled TINYINT(1) NOT NULL DEFAULT 0,
    cancel_uid INT DEFAULT NULL,
    cancel_date_time DATETIME DEFAULT NULL,

    PRIMARY KEY (id),
    KEY idx_lr_copy_lr_no (lr_no),
    KEY idx_lr_copy_entry_date (entry_date),
    KEY idx_lr_copy_customer_id (customer_id),
    KEY idx_lr_copy_cancelled (is_cancelled)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

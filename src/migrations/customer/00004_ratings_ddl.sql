CREATE DATABASE IF NOT EXISTS ratings;

CREATE TABLE IF NOT EXISTS ratings.feedback (
    id BIGINT AUTO_INCREMENT,
    customer_id BINARY(16),
    product_id MEDIUMINT,
    title VARCHAR(100),
    rating TINYINT,
    summary TEXT,
    helpful MEDIUMINT,
    active BOOLEAN DEFAULT TRUE,
    created_on     DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id, customer_id, product_id)
);

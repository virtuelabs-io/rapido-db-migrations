CREATE DATABASE IF NOT EXISTS ratings;

CREATE TABLE IF NOT EXISTS ratings.feedback (
    id BIGINT AUTO_INCREMENT,
    customer_id BINARY(16),
    product_id MEDIUMINT,
    rating TINYINT,
    summary TEXT,
    helpful MEDIUMINT,
    active BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (id)
);

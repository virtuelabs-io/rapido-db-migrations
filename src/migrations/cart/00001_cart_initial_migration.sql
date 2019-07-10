CREATE DATABASE IF NOT EXISTS cart;

CREATE TABLE IF NOT EXISTS cart.items (
    customer_id BINARY(16),
    product_id MEDIUMINT,
    quantity DECIMAL(9,2),
    in_cart BOOLEAN DEFAULT TRUE,
    created_on     DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (customer_id, product_id)
);

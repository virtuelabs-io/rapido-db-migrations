CREATE DATABASE IF NOT EXISTS orders;

CREATE TABLE IF NOT EXISTS orders.order_status (
    id TINYINT,
    status VARCHAR(100),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS orders.header (
    id BIGINT AUTO_INCREMENT,
    customer_id BINARY(16),
    order_price DECIMAL(11,2),
    order_status_id TINYINT,
    charge_id VARCHAR(100),
    created_on     DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (order_status_id) REFERENCES orders.order_status(id)
);

CREATE TABLE IF NOT EXISTS orders.item (
    id BIGINT AUTO_INCREMENT,
    order_id BIGINT,
    customer_id BINARY(16),
    product_id MEDIUMINT,
    unit_price DECIMAL(11,2),
    quantity DECIMAL(9,2),
    PRIMARY KEY (id),
    FOREIGN KEY (order_id) REFERENCES orders.header(id)
);

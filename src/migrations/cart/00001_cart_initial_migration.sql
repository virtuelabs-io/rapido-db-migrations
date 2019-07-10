CREATE DATABASE IF NOT EXISTS customer;

CREATE TABLE IF NOT EXISTS customer.address_type (
    id TINYINT,
    kind VARCHAR(100),
    PRIMARY KEY (id)
);
-- Contains PII information
CREATE TABLE IF NOT EXISTS customer.address (
    id MEDIUMINT AUTO_INCREMENT,
    customer_id BINARY(16),
    full_name VARCHAR(255),
    address_type_id TINYINT,
    addr_1 VARCHAR(255),
    addr_2 VARCHAR(255),
    city VARCHAR(255),
    county VARCHAR(255),
    country VARCHAR(100),
    postcode VARCHAR(10),
    PRIMARY KEY (id),
    FOREIGN KEY (address_type_id) REFERENCES customer.address_type(id)
);
-- Contains PII information
CREATE TABLE IF NOT EXISTS customer.company (
    customer_id BINARY(16),
    company_name VARCHAR(255),
    addr_1 VARCHAR(255),
    addr_2 VARCHAR(255),
    city VARCHAR(255),
    county VARCHAR(255),
    country VARCHAR(100),
    postcode VARCHAR(10),
    PRIMARY KEY (customer_id)
);

CREATE DATABASE IF NOT EXISTS cart;

CREATE TABLE IF NOT EXISTS cart.items (
    id BIGINT AUTO_INCREMENT,
    customer_id BINARY(16),
    product_id MEDIUMINT,
    quantity DECIMAL(9,2),
    in_cart BOOLEAN DEFAULT TRUE,
    created_on     DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id, customer_id, product_id)
);

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

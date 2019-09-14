CREATE DATABASE IF NOT EXISTS guests;

CREATE TABLE IF NOT EXISTS guests.order_status (
    id TINYINT,
    status VARCHAR(100),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS guests.country (
    id TINYINT,
    country VARCHAR(100),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS guests.vat (
    country_id TINYINT,
    vat DECIMAL(5,2),
    PRIMARY KEY (country_id),
    FOREIGN KEY (country_id) REFERENCES guests.country(id)
);

CREATE TABLE IF NOT EXISTS guests.delivery_cost (
    id TINYINT,
    cost DECIMAL(9,2),
    description VARCHAR(100),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS guests.address_type (
    id TINYINT,
    kind VARCHAR(100),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS guests.products (
    id MEDIUMINT,
    unit_price DECIMAL(11,2),
    quantity_in_stock DECIMAL(9,2),
    active BOOLEAN DEFAULT TRUE,
    created_on     DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

-- Contains PII information
CREATE TABLE IF NOT EXISTS guests.address (
    session_id BINARY(16),
    full_name VARCHAR(255) NOT NULL,
    address_type_id TINYINT NOT NULL,
    addr_1 VARCHAR(255) NOT NULL,
    addr_2 VARCHAR(255) DEFAULT NULL,
    city VARCHAR(255) NOT NULL,
    county VARCHAR(255) NOT NULL,
    country VARCHAR(100) NOT NULL,
    postcode VARCHAR(10) NOT NULL,
    active BOOLEAN DEFAULT TRUE,
    email VARCHAR(100) NOT NULL,
    phone_no VARCHAR(13) NOT NULL,
    PRIMARY KEY (session_id),
    FOREIGN KEY (address_type_id) REFERENCES guests.address_type(id)
);

CREATE TABLE IF NOT EXISTS guests.header (
    id BIGINT AUTO_INCREMENT,
    session_id BINARY(16) NOT NULL,
    order_price DECIMAL(11,2),
    order_status_id TINYINT,
    charge_id VARCHAR(100),
    vat DECIMAL(11,2),
    delivery_cost DECIMAL(9,2),
    order_price_total DECIMAL(11,2),
    created_on     DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (order_status_id) REFERENCES guests.order_status(id)
) AUTO_INCREMENT=10000;

CREATE TABLE IF NOT EXISTS guests.item (
    id BIGINT AUTO_INCREMENT,
    order_id BIGINT NOT NULL,
    product_id MEDIUMINT,
    unit_price DECIMAL(11,2),
    quantity DECIMAL(9,2),
    total_price DECIMAL(11,2),
    item_vat DECIMAL(11,2),
    PRIMARY KEY (id),
    FOREIGN KEY (order_id) REFERENCES guests.header(id),
    FOREIGN KEY (product_id) REFERENCES guests.products(id)
);

CREATE TABLE IF NOT EXISTS guests.cart_items (
    session_id BINARY(16),
    product_id MEDIUMINT,
    quantity DECIMAL(9,2),
    in_cart BOOLEAN DEFAULT TRUE,
    created_on     DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (session_id, product_id)
);

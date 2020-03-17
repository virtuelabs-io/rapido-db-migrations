CREATE DATABASE IF NOT EXISTS orders;

CREATE TABLE IF NOT EXISTS orders.order_status (
    id TINYINT,
    status VARCHAR(100),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS orders.country (
    id TINYINT,
    country VARCHAR(100),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS orders.vat (
    country_id TINYINT,
    vat DECIMAL(5,2),
    PRIMARY KEY (country_id),
    FOREIGN KEY (country_id) REFERENCES orders.country(id)
);

CREATE TABLE IF NOT EXISTS orders.delivery_cost (
    id TINYINT,
    cost DECIMAL(9,2),
    description VARCHAR(100),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS orders.products (
    id MEDIUMINT,
    item_name VARCHAR(100),
    unit_price DECIMAL(11,2),
    active BOOLEAN DEFAULT TRUE,
    created_on     DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS orders.product_price_history (
    id BIGINT AUTO_INCREMENT,
    product_id MEDIUMINT,
    unit_price DECIMAL(11,2),
    created_on     DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES orders.products(id),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS orders.header (
    id BIGINT AUTO_INCREMENT,
    customer_id BINARY(16) NOT NULL,
    order_price DECIMAL(11,2),
    order_status_id TINYINT,
    charge_id VARCHAR(100),
    delivery_address_id MEDIUMINT,
    vat DECIMAL(11,2),
    delivery_cost DECIMAL(9,2),
    order_price_total DECIMAL(11,2),
    created_on     DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (order_status_id) REFERENCES orders.order_status(id),
    FOREIGN KEY (delivery_address_id) REFERENCES customer.address(id)
) AUTO_INCREMENT=1000000;

CREATE TABLE IF NOT EXISTS orders.item (
    id BIGINT AUTO_INCREMENT,
    order_id BIGINT NOT NULL,
    product_id MEDIUMINT,
    unit_price DECIMAL(11,2),
    quantity DECIMAL(9,2),
    total_price DECIMAL(11,2),
    item_vat DECIMAL(11,2),
    PRIMARY KEY (id),
    FOREIGN KEY (order_id) REFERENCES orders.header(id),
    FOREIGN KEY (product_id) REFERENCES orders.products(id)
);

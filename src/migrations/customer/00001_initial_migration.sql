CREATE DATABASE IF NOT EXISTS customer;
CREATE TABLE IF NOT EXISTS customer.payment_type (
    id TINYINT,
    kind VARCHAR(100),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS customer.address_type (
    id TINYINT,
    kind VARCHAR(100),
    PRIMARY KEY (id)
);

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

CREATE TABLE IF NOT EXISTS customer.company (
    customer_id BINARY(16),
    company_name VARCHAR(255),
    vat_number VARCHAR(30),
    address_id MEDIUMINT,
    PRIMARY KEY (customer_id),
    FOREIGN KEY (address_id) REFERENCES customer.address(id)
);

CREATE TABLE IF NOT EXISTS customer.payment (
    id INT AUTO_INCREMENT,
    customer_id BINARY(16),
    name_on_card VARCHAR(255),
    card_number CHAR(16),
    expirity_month CHAR(2),
    expirity_year CHAR(4),
    address_id MEDIUMINT,
    payment_type_id TINYINT,
    PRIMARY KEY (id),
    FOREIGN KEY (address_id) REFERENCES customer.address(id)
);

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

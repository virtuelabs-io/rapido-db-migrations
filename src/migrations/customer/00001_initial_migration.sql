CREATE TABLE payment_type (
    id SMALLINT PRIMARY KEY,
    kind VARCHAR(100)
);

CREATE TABLE address_type (
    id SMALLINT PRIMARY KEY,
    kind VARCHAR(100)
);

CREATE TABLE company (
    customer_id UUID PRIMARY KEY,
    company_name VARCHAR(255),
    vat_number VARCHAR(30),
    address_id SMALLINT
);

CREATE TABLE address (
    id serial PRIMARY KEY,
    customer_id UUID,
    full_name VARCHAR(255),
    address_type_id SMALLINT,
    addr_1 VARCHAR(255),
    addr_2 VARCHAR(255),
    city VARCHAR(255),
    county VARCHAR(255),
    country VARCHAR(100),
    postcode VARCHAR(10)
);

CREATE TABLE payment (
    id SMALLINT PRIMARY KEY,
    customer_id UUID,
    name_on_card VARCHAR(255),
    card_number CHAR(16),
    expirity_month CHAR(2),
    expirity_year CHAR(4),
    address_id SMALLINT
);
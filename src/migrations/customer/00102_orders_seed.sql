-- Order status types
INSERT INTO orders.order_status VALUES (1, 'Incomplete');
INSERT INTO orders.order_status VALUES (2, 'Payed');
INSERT INTO orders.order_status VALUES (3, 'Delivered');
INSERT INTO orders.order_status VALUES (4, 'Cancled');
INSERT INTO orders.order_status VALUES (5, 'Returned');
-- Countries
INSERT INTO orders.country VALUES (1, 'United Kingdom');
-- Vat
INSERT INTO orders.vat VALUES (1, 0.10);
-- Products
INSERT INTO orders.products (id, unit_price) VALUES (1, 222.99);
INSERT INTO orders.products (id, unit_price) VALUES (2, 219.00);
INSERT INTO orders.products (id, unit_price) VALUES (3, 229.17);
INSERT INTO orders.products (id, unit_price) VALUES (4, 79.00);
INSERT INTO orders.products (id, unit_price) VALUES (5, 49.00);
INSERT INTO orders.products (id, unit_price) VALUES (6, 253.00);
INSERT INTO orders.products (id, unit_price) VALUES (7, 49.00);
INSERT INTO orders.products (id, unit_price) VALUES (8, 269.41);
INSERT INTO orders.products (id, unit_price) VALUES (9, 49.99);
INSERT INTO orders.products (id, unit_price) VALUES (10, 14.00);

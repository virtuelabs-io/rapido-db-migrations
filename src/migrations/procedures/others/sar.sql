SET @customer_id = UUID_TO_BIN('1d942e39-49fd-4dbe-b046-d26922cc1eca'); -- update to the customer you are looking for
SET @session_id = UUID_TO_BIN('1d942e39-49fd-4dbe-b046-d26922cc1eca'); -- update to the customer you are looking for
SET @email = 'sample@gmail.com';

-- Address details
SELECT * FROM customer.address WHERE customer_id = @customer_id;

-- Company details
SELECT * FROM customer.company WHERE customer_id = @customer_id;

-- Header details
SELECT * FROM orders.header WHERE customer_id = @customer_id;

-- Item details
SELECT * FROM orders.item WHERE customer_id = @customer_id;

-- Ratings details
SELECT * FROM ratings.feedback WHERE customer_id = @customer_id;

-- Guest PII details
SELECT * FROM guests.header WHERE session_id = @session_id

-- Guest PII details
SELECT * FROM guests.item WHERE session_id = @session_id

-- Guest PII details
SELECT * FROM guests.address WHERE email = @email

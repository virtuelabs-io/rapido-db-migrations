DROP PROCEDURE IF EXISTS orders.get_twenty_latest_order;

DELIMITER $$

CREATE PROCEDURE orders.get_twenty_latest_order ( IN in_customer_id BINARY(16) )
BEGIN
	-- Latest Twenty Orders
	DROP TEMPORARY TABLE IF EXISTS tmp_orders;
	CREATE TEMPORARY TABLE tmp_orders engine=memory
    SELECT * from orders.header
    WHERE customer_id = in_customer_id
    ORDER BY created_on DESC
    LIMIT 20;
    -- Items for those 20 orders
    SELECT h.id,
           h.order_status_id,
           h.delivery_address_id,
           i.product_id,
           i.quantity,
           i.unit_price,
           i.total_price,
           h.order_price,
           h.created_on,
           a.full_name,
           a.address_type_id,
           a.addr_1,
           a.addr_2,
           a.city,
           a.county,
           a.country,
           a.postcode
    FROM orders.header AS h
    INNER JOIN orders.item AS i
		ON h.id = i.order_id
	LEFT JOIN customer.address AS a
		on h.delivery_address_id = a.id
    AND   h.customer_id = in_customer_id;
    -- Clean up
    DROP TEMPORARY TABLE IF EXISTS tmp_orders;
    
END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS orders.get_order;

DELIMITER $$

CREATE PROCEDURE orders.get_order ( IN in_customer_id BINARY(16) , IN in_order_id BIGINT)
BEGIN

    SELECT h.id,
           h.order_status_id,
           h.delivery_address_id,
           i.product_id,
           i.quantity,
           i.unit_price,
           i.total_price,
           i.item_vat,
           h.order_price,
           h.created_on,
           h.vat,
           h.delivery_cost,
           h.order_price_total,
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
	WHERE h.id = in_order_id
    AND   h.customer_id = in_customer_id;

END $$

DELIMITER ;

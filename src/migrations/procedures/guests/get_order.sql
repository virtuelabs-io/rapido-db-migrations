DROP PROCEDURE IF EXISTS guests.get_order;

DELIMITER $$

CREATE PROCEDURE guests.get_order ( IN in_session_id BINARY(16) , IN in_order_id BIGINT)
BEGIN

    SELECT h.id,
           h.order_status_id,
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
           a.postcode,
           a.email,
           a.phone_no
    FROM guests.header AS h
    INNER JOIN guests.item AS i
		ON h.id = i.order_id
	LEFT JOIN guests.address AS a
		on h.session_id = a.session_id
	WHERE h.id = in_order_id
    AND   h.session_id = in_session_id;

END $$

DELIMITER ;

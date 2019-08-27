DROP PROCEDURE IF EXISTS orders.check_product_purchase;

DELIMITER $$

CREATE PROCEDURE orders.check_product_purchase ( IN in_customer_id BINARY(16) , IN in_product_id MEDIUMINT )
BEGIN

	SELECT TRUE
    FROM orders.header AS h
    INNER JOIN orders.item AS i
		ON h.id = i.order_id
	WHERE h.customer_id = in_customer_id
    AND h.order_status_id in (3, 5)
    AND i.product_id = in_product_id
    LIMIT 1;

END $$

DELIMITER ;

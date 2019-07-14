DROP PROCEDURE IF EXISTS orders.create_order;

DELIMITER $$

CREATE PROCEDURE orders.create_order ( IN in_customer_id BINARY(16),  IN in_delivery_address_id MEDIUMINT )
BEGIN

	DECLARE var_order_total_price DECIMAL(13,2);

	DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
          ROLLBACK;
    END;
    
    START TRANSACTION;
    
		-- Deleting incomplete orders
		DELETE orders.item 
        FROM orders.header
        INNER JOIN orders.item
			on orders.header.id = orders.item.order_id
		WHERE orders.header.customer_id = in_customer_id
		AND   orders.header.order_status_id = 1;
        
        -- Deleting incomplete line items
        DELETE orders.header 
        FROM orders.header
		WHERE orders.header.customer_id = in_customer_id
		AND   orders.header.order_status_id = 1;
        
        -- Get cart details
        DROP TEMPORARY TABLE IF EXISTS tmp_cart_items;
        CREATE TEMPORARY TABLE tmp_cart_items engine=memory
        SELECT ci.product_id as t_product_id,
			   op.unit_price as t_unit_price,
			   ci.quantity as t_quantity,
               (ci.quantity * op.unit_price) as t_item_total_price
		FROM cart.items as ci
        INNER JOIN orders.products as op
			on ci.product_id = op.id
        WHERE ci.customer_id = in_customer_id
        AND   ci.in_cart = TRUE
        AND	  op.active = TRUE;
        
        -- Calculate total order value
        SELECT SUM(t_item_total_price) INTO var_order_total_price FROM tmp_cart_items;
		
        -- Creating a new order
		INSERT INTO orders.header (
			customer_id,
            order_price,
            order_status_id,
            charge_id,
            delivery_address_id
        )
        VALUES (
			in_customer_id,
			var_order_total_price,
			in_delivery_address_id,
            'ch_unknown',
            1 -- INCOMPLETE
        );
        
        -- Setting order id
        SET @var_order_id = LAST_INSERT_ID();
        
        -- Insert Order Items
        INSERT INTO orders.item (
			order_id,
            product_id,
            unit_price,
            quantity,
            total_price
        ) 
        SELECT @var_order_id,
			   tc.t_product_id,
               tc.t_unit_price,
               tc.t_quantity,
               tc.t_item_total_price
		FROM tmp_cart_items as tc;
        
		-- Clean up
		DROP TEMPORARY TABLE IF EXISTS tmp_cart_items;
    
	COMMIT;
    
    SELECT h.id,
           h.order_status_id,
           h.delivery_address_id,
           i.product_id,
           i.quantity,
           i.unit_price,
           i.total_price,
           h.order_price
    FROM orders.header AS h
    INNER JOIN orders.item AS i
		ON h.id = i.order_id
	WHERE h.id = @var_order_id;
    
END $$

DELIMITER ;

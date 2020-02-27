DROP PROCEDURE IF EXISTS guests.create_order;

DELIMITER $$

CREATE PROCEDURE guests.create_order ( IN in_session_id BINARY(16) , IN in_delivery_cost_id TINYINT )
BEGIN

	DECLARE var_order_total_price DECIMAL(13,2);
	DECLARE var_order_total_vat DECIMAL(13,2);
	DECLARE var_order_delivery_cost DECIMAL(9,2);
	DECLARE var_vat_percent DECIMAL(5,2);

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
          ROLLBACK;
    END;

    START TRANSACTION;

		-- Deleting incomplete guests
		DELETE guests.item
        FROM guests.header
        INNER JOIN guests.item
			on guests.header.id = guests.item.order_id
		WHERE guests.header.session_id = in_session_id
		AND   guests.header.order_status_id = 1;

        -- Deleting incomplete line items
        DELETE guests.header
        FROM guests.header
		WHERE guests.header.session_id = in_session_id
		AND   guests.header.order_status_id = 1;

        -- Get VAT percentage for UK
        SELECT vat INTO var_vat_percent FROM guests.vat WHERE country_id = 1;

        -- Get cart details
        DROP TEMPORARY TABLE IF EXISTS tmp_guest_cart_items;
        CREATE TEMPORARY TABLE tmp_guest_cart_items engine=memory
        SELECT ci.product_id as t_product_id,
			   op.unit_price as t_unit_price,
			   ci.quantity as t_quantity,
               ROUND((ci.quantity * op.unit_price), 2) as t_item_total_price,
               ROUND((ci.quantity * op.unit_price * var_vat_percent),2) as t_item_vat
		FROM guests.cart_items as ci
        INNER JOIN guests.products as op
			on ci.product_id = op.id
        WHERE ci.session_id = in_session_id
        AND   ci.in_cart = TRUE
        AND	  op.active = TRUE;

        -- Calculate total order value
        SELECT SUM(t_item_total_price) INTO var_order_total_price FROM tmp_guest_cart_items;

        -- Calculate total order vat
        SELECT SUM(t_item_vat) INTO var_order_total_vat FROM tmp_guest_cart_items;

        -- Calculate order delivery cost
        SELECT cost INTO var_order_delivery_cost FROM guests.delivery_cost WHERE id = in_delivery_cost_id;

        IF var_order_total_price < 300 THEN
           SET var_order_delivery_cost = var_order_delivery_cost + 30; -- adding min delivery price to the delivery option picked
        END IF;

        -- Creating a new order
		INSERT INTO guests.header (
			session_id,
            order_price,
            charge_id,
            order_status_id,
            vat,
            delivery_cost,
            order_price_total
        )
        VALUES (
			in_session_id,
			var_order_total_price,
            'ch_incomplete',
            1, -- INCOMPLETE
            var_order_total_vat,
            var_order_delivery_cost,
			(var_order_total_price + var_order_total_vat + var_order_delivery_cost)
        );

        -- Setting order id
        SET @var_order_id = LAST_INSERT_ID();

        -- Insert Order Items
        INSERT INTO guests.item (
			order_id,
            product_id,
            unit_price,
            quantity,
            total_price,
            item_vat
        )
        SELECT @var_order_id,
			   tc.t_product_id,
               tc.t_unit_price,
               tc.t_quantity,
               tc.t_item_total_price,
               tc.t_item_vat
		FROM tmp_guest_cart_items as tc;

		-- Clean up
		DROP TEMPORARY TABLE IF EXISTS tmp_guest_cart_items;

	COMMIT;

    CALL guests.get_order(in_session_id, @var_order_id);

END $$

DELIMITER ;

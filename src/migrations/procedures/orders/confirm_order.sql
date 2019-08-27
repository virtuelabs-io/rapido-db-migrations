DROP PROCEDURE IF EXISTS orders.confirm_order;

DELIMITER $$

CREATE PROCEDURE orders.confirm_order ( IN in_customer_id BINARY(16) , IN in_order_id BIGINT, IN in_charge_id VARCHAR(100))
BEGIN

	DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
          ROLLBACK;
    END;
    
    START TRANSACTION;
    
		-- Update order
        UPDATE orders.header
        SET order_status_id = 2, -- PAYED
			charge_id = in_charge_id
		WHERE id = in_order_id
        AND	  customer_id = in_customer_id;
    
		-- Deleting incomplete orderscreate_order
		DELETE FROM cart.items
		WHERE customer_id = in_customer_id
        AND   in_cart = TRUE;
    
	COMMIT;
    
    CALL orders.get_order(in_customer_id, in_order_id);
    
END $$

DELIMITER ;

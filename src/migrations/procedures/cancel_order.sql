DROP PROCEDURE IF EXISTS orders.cancel_order;

DELIMITER $$

CREATE PROCEDURE orders.cancel_order ( IN in_customer_id BINARY(16) , IN in_order_id BIGINT )
BEGIN

	DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
          ROLLBACK;
    END;
    
    START TRANSACTION;
    
		-- Cancelled order
        UPDATE orders.header
        SET order_status_id = 4 -- CANCELLED
		WHERE id = in_order_id
        AND	  customer_id = in_customer_id;
    
	COMMIT;
    
    SELECT TRUE;
    
END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS guests.confirm_order;

DELIMITER $$

CREATE PROCEDURE guests.confirm_order ( IN in_session_id BINARY(16) , IN in_order_id BIGINT, IN in_charge_id VARCHAR(100))
BEGIN

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
          ROLLBACK;
    END;

    START TRANSACTION;

		-- Update order
        UPDATE guests.header
        SET order_status_id = 2, -- PAYED
			charge_id = in_charge_id
		WHERE id = in_order_id
        AND	  session_id = in_session_id;

		-- Deleting incomplete guests_create_order
		DELETE FROM guests.cart_items
		WHERE session_id = in_session_id
        AND   in_cart = TRUE;

	COMMIT;

    CALL guests.get_order(in_session_id, in_order_id);

END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS guests.cancel_order;

DELIMITER $$

CREATE PROCEDURE guests.cancel_order ( IN in_session_id BINARY(16) , IN in_order_id BIGINT )
BEGIN

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
          ROLLBACK;
    END;

    START TRANSACTION;

		-- Cancelled order
        UPDATE guests.header
        SET order_status_id = 4 -- CANCELLED
		WHERE id = in_order_id
        AND	  session_id = in_session_id;

	COMMIT;

    SELECT TRUE;

END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS customer.erase_pii;

DELIMITER $$

CREATE PROCEDURE customer.erase_pii ( IN in_customer_id BINARY(16) )
BEGIN

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
          ROLLBACK;
    END;

    START TRANSACTION;

        -- Erase PII from address table
        UPDATE customer.address
        SET full_name = 'xox',
            addr_1 = 'xox',
            addr_2 = 'xox'
        WHERE customer_id = in_customer_id;

	COMMIT;

    SELECT TRUE;

END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS guests.erase_pii;

DELIMITER $$

CREATE PROCEDURE guests.erase_pii ( IN in_email VARCHAR(100) )
BEGIN

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
          ROLLBACK;
    END;

    START TRANSACTION;

        -- Erase PII from address table
        UPDATE guests.address
        SET full_name = 'xox',
            addr_1 = 'xox',
            addr_2 = 'xox',
            email = 'xox',
            phone_no = 'xox'
        WHERE email = in_email;

	COMMIT;

    SELECT TRUE;

END $$

DELIMITER ;

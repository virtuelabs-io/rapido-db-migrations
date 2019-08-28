DROP PROCEDURE IF EXISTS ratings.create_rating;

DELIMITER $$

CREATE PROCEDURE ratings.create_rating ( IN in_customer_id BINARY(16) , IN in_product_id MEDIUMINT,  IN in_title VARCHAR(100), IN in_rating TINYINT, IN in_summary TEXT )
BEGIN

	DECLARE var_order_total_price DECIMAL(13,2);

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
          ROLLBACK;
    END;

    START TRANSACTION;

        -- Creating a feedback
		INSERT INTO ratings.feedback (
                customer_id,
                product_id,
                title,
                rating,
                summary,
                helpful
        ) VALUES (
            in_customer_id,
            in_product_id,
            in_title,
            in_rating,
            in_summary,
            0
        );

        -- Setting feedback id
        SET @var_feedback_id = LAST_INSERT_ID();

	COMMIT;

    SELECT @var_feedback_id;

END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS ratings.update_rating;

DELIMITER $$

CREATE PROCEDURE ratings.update_rating ( IN in_customer_id BINARY(16) , IN in_feedback_id BIGINT,  IN in_title VARCHAR(100), IN in_rating TINYINT, IN in_summary TEXT )
BEGIN

	DECLARE var_order_total_price DECIMAL(13,2);

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
          ROLLBACK;
    END;

    START TRANSACTION;

        -- Update a feedback
		UPDATE ratings.feedback
        SET title = in_title,
            rating = in_rating,
            summary = in_summary
        WHERE id = in_feedback_id
        AND   customer_id = in_customer_id;

	COMMIT;

    SELECT in_feedback_id;

END $$

DELIMITER ;

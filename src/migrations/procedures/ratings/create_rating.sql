DROP PROCEDURE IF EXISTS ratings.create_rating;

DELIMITER $$

CREATE PROCEDURE ratings.create_rating ( IN in_customer_id BINARY(16) , IN in_product_id MEDIUMINT,  IN in_title VARCHAR(100), IN in_rating TINYINT, IN in_summary TEXT )
BEGIN

	DECLARE var_exists BOOL;
    DECLARE var_rating_id BIGINT;

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
          ROLLBACK;
    END;

    START TRANSACTION;
    
		SET @var_feedback_id = 0;
    
		SELECT EXISTS(
			SELECT id
			FROM ratings.feedback
			WHERE customer_id = in_customer_id
			AND   product_id = in_product_id
        ) INTO var_exists;
        
        IF var_exists THEN
        
			SELECT id INTO var_rating_id
            FROM ratings.feedback
            WHERE customer_id = in_customer_id
			AND   product_id = in_product_id;
            
            -- Update a feedback
			UPDATE ratings.feedback
			SET title = in_title,
				rating = in_rating,
				summary = in_summary
			WHERE id = var_rating_id
			AND   customer_id = in_customer_id
            AND   product_id = in_product_id;
            
			SET @var_feedback_id = var_rating_id;
        
        ELSE
        
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
        
        END IF;

	COMMIT;

    SELECT @var_feedback_id;

END $$

DELIMITER ;

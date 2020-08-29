# # # # # # # # # # # # # # # # # #
# WSR SCRIPTS Build
# # # # # # # # # # # # # # # # # #

DROP PROCEDURE IF EXISTS datedetail_build;

DELIMITER //
CREATE PROCEDURE `datedetail_build`(p_start_date DATE, p_end_date DATE)
BEGIN
    DECLARE v_full_date DATE;

#    DELETE FROM date_details;

    SET v_full_date = p_start_date;
    WHILE v_full_date < p_end_date DO

    IF DAYNAME(v_full_date) = 'Monday' THEN
      INSERT INTO date_details (
        fulldate ,
        dayname ,
        week,
        monthnumber,
        monthname,
        year
      ) VALUES (
        v_full_date,
        DAYNAME(v_full_date),
        WEEKOFYEAR(v_full_date),
        MONTH(v_full_date),
        MONTHNAME(v_full_date),
        YEAR(v_full_date)
      );
    END IF;
        
        SET v_full_date = DATE_ADD(v_full_date, INTERVAL 1 DAY);

    END WHILE;

END;

-- DELIMITER //
-- CALL `pyramid_wsr`.`datedetail_build`('2020-01-01','2025-12-31');








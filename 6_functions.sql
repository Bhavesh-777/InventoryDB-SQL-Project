-- Task 6: User-Defined Function (UDF)
-- Goal: Get Current Stock of a Product

DELIMITER //

CREATE FUNCTION GetCurrentStock(pid INT)
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE total INT;

  SELECT SUM(Quantity)
  INTO total
  FROM Stock
  WHERE ProductID = pid;

  RETURN IFNULL(total, 0);  -- return 0 if no record found
END;
//

DELIMITER ;

-- This will return total stock for product ID 3.

SELECT GetCurrentStock(3) AS StockForProduct3;



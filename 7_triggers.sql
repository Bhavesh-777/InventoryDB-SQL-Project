USE InventoryDB;

-- Trigger 1: Auto-Update Stock After New Purchase
-- Objective: When a new row is inserted into the Purchases table,
-- the corresponding stock quantity in the Stock table should increase automatically for that product in the related warehouse.

DELIMITER //

CREATE TRIGGER After_Purchase_Stock_Update
AFTER INSERT ON Purchases
FOR EACH ROW
BEGIN
  -- Update stock for the purchased product
  UPDATE Stock
  SET Quantity = Quantity + NEW.Quantity
  WHERE ProductID = NEW.ProductID
  LIMIT 1;  -- Update any one matching warehouse (assumption)
END;
//

DELIMITER ;

-- Insert a new purchase
INSERT INTO Purchases (ProductID, SupplierID, Quantity)
VALUES (1, 1, 20);

-- Check updated stock
SELECT * FROM Stock WHERE ProductID = 1;

-- Trigger 2: Log When Product is Returned
-- Objective: Whenever a new return is inserted into the Returns table, we want to:
-- Automatically log the return info into a new table: ReturnLog
--  This keeps a history we can query later 📊

DELIMITER // 

CREATE TRIGGER Log_Return_Insert
AFTER UPDATE ON RETURNS
FOR EACH ROW 
BEGIN 
INSERT INTO RETURNS(PRODUCTID, SOURCE, QUANTITY,RETURNDATE)
VALUES (NEW.PRODUCTID, NEW.SOURCE, NEW.QUANTITY, NEW.RETURNDATE);
END; 
//

DELIMITER ;

-- Insert a new return
INSERT INTO Returns (ProductID, Source, Quantity)
VALUES (3, 'Sale', 4);

-- Check the log
SELECT * FROM RETURNS;
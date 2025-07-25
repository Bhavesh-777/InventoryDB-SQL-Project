USE InventoryDB;

SELECT * FROM PRODUCTS;

-- View 1 Low Stock Alert

-- Write a query to create a view called LowStockProducts that shows all products
-- where the Quantity in stock is less than or equal to their ReorderLevel.

CREATE VIEW LowStockProducts AS
SELECT P.PRODUCTNAME, S.QUANTITY, P.REORDERLEVEL, W.LOCATION FROM PRODUCTS AS P
JOIN STOCK AS S ON P.PRODUCTID = S.PRODUCTID
JOIN WAREHOUSES AS W ON S.WAREHOUSEID = W.WAREHOUSEID
WHERE S.QUANTITY <= P.REORDERLEVEL;

select * from lowstockproducts;

-- View 2: Category-Wise Product Summary

-- Create a view named CategoryWiseProducts that shows the total number of products available in each category.

CREATE VIEW CategoryWiseProducts AS
SELECT CATEGORY, COUNT(CATEGORY) AS TOTAL_PRODUCTS FROM PRODUCTS
GROUP BY CATEGORY;

SELECT * FROM CategoryWiseProducts;

-- View 3️ Return History

-- Create a view named ReturnHistory that shows a log of all returned items, including:

CREATE VIEW ReturnHistory  AS
SELECT P.PRODUCTNAME, R.QUANTITY, R.SOURCE, P.CATEGORY FROM PRODUCTS AS P 
JOIN RETURNS AS R ON P.PRODUCTID = R.PRODUCTID
WHERE R.RETURNDATE IS NOT NULL;

SELECT * FROM ReturnHistory;

-- 
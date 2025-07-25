USE InventoryDB;

-- Task 1: Stored Procedure – Get Total Revenue by Date Range

DELIMITER //

CREATE PROCEDURE GetTotalRevenueByDate(IN STARTDATE DATE, IN ENDDATE DATE)  -- ENTER DYNAMICALLY DATE RANGE

BEGIN 

SELECT SUM(P.UNITPRICE * S.QUANTITY) AS TOTALREVENUE FROM PRODUCTS AS P 
JOIN SALES AS S ON P.PRODUCTID = S.PRODUCTID 
WHERE S.SALEDATE BETWEEN STARTDATE AND ENDDATE;				

END //

DELIMITER ;

CALL GETTOTALREVENUEBYDATE('2025-07-01', '2025-12-30');  -- MySQL expects 'YYYY-MM-DD' format WHEN ENTERS MANUAL DATE.


-- Task 2: Stored Procedure – Update Order Status by Order ID
-- NOTE : MySQL Safe Update Mode prevents UPDATEs or DELETEs if:
-- No indexed column (like a primary key) is used in the WHERE clause.

-- Temporarily disable Safe Mode for session

DELIMITER //

CREATE PROCEDURE UpdateOrderStatus(IN SALE_ID INT)  

BEGIN 
DECLARE ROWS_AFFECTED INT;

    UPDATE Sales 
    SET OrderStatus = 'SHIPPED'
    WHERE SALEID = SALE_ID;

    SET ROWS_AFFECTED = ROW_COUNT();

    IF ROWS_AFFECTED > 0 THEN
        SELECT '✅ Order status updated to Shipped.' AS Message;
    ELSE
        SELECT '⚠️ No record updated. Check SaleID or current status.' AS Message;
    END IF;
END //

DELIMITER ;

CALL UpdateOrderStatus(3);

SELECT * FROM SALES;

-- TASK 3 – Get Product Sales Report

DELIMITER //

CREATE PROCEDURE GetOrdersByCustomer()  

BEGIN 

SELECT P.PRODUCTNAME, SUM(S.QUANTITY) AS QUANTITYSOLD, SUM(S.QUANTITY * P.UNITPRICE) AS TOTALREVENUE FROM
PRODUCTS AS P JOIN SALES AS S 
ON P.PRODUCTID = S.PRODUCTID 
GROUP BY P.PRODUCTNAME
ORDER BY TOTALREVENUE DESC;

END //

DELIMITER ;

CALL GetOrdersByCustomer();


-- TASK 4 – Identify Low Stock Products 
-- List all products where stock is running low (e.g., Stock < 10) so inventory managers can reorder in time.


DELIMITER //

CREATE PROCEDURE GetLowStockProducts()  

BEGIN 

SELECT P.PRODUCTID, P.PRODUCTNAME, S.QUANTITY, P.REORDERLEVEL FROM
PRODUCTS AS P JOIN STOCK AS S 
ON P.PRODUCTID = S.PRODUCTID
WHERE S.QUANTITY < P.REORDERLEVEL

-- If the current quantity is less than the product's reorder level (a dynamic value set per product).  (( WHERE S.QUANTITY < P.REORDERLEVEL ))
-- Meaning: Each product might have a different ReorderLevel. This condition is smarter because it checks what is low for that particular product.

ORDER BY S.QUANTITY DESC;

END //

DELIMITER ;

CALL GetLowStockProducts();

SELECT * FROM PRODUCTS;

-- TASK 5 –  Identify the Top 5 Suppliers by Total Purchase Value
-- Find out which suppliers the business spends the most money with — based on the purchase quantity × unit cost.

DELIMITER //

CREATE PROCEDURE GetTopSuppliersByPurchaseValue()  

BEGIN 

SELECT SN.SUPPLIERNAME, SUM(S.QUANTITY * P.UNITPRICE) AS PURCHASEVALUE FROM PRODUCTS AS P 
JOIN STOCK AS S ON P.PRODUCTID = S.PRODUCTID
JOIN SUPPLIERS AS SN ON SN.SUPPLIERID = P.PRODUCTID
GROUP BY SN.SUPPLIERNAME
ORDER BY PURCHASEVALUE DESC
LIMIT 5;

END //

DELIMITER ;

CALL GetTopSuppliersByPurchaseValue();

SELECT * FROM PRODUCTS;

-- TASK 6 – Write a query to display the top 5 products that have the highest stock quantity in the inventory.

DELIMITER //

CREATE PROCEDURE GetHighStockProducts()  

BEGIN 

SELECT P.PRODUCTID, P.PRODUCTNAME, S.QUANTITY, P.REORDERLEVEL FROM
PRODUCTS AS P JOIN STOCK AS S 
ON P.PRODUCTID = S.PRODUCTID
WHERE S.QUANTITY > P.REORDERLEVEL
ORDER BY S.QUANTITY DESC
LIMIT 5;

END //

DELIMITER ;

CALL GetHighStockProducts();

SELECT * FROM PRODUCTS;

-- TASK 7 Stock Summary by Category
-- Get each category's total available quantity and average unit price of products.

DELIMITER //

CREATE PROCEDURE GetStockSummary()  

BEGIN 

SELECT P.CATEGORY AS CATEGORYNAME, SUM(S.QUANTITY) AS QUANTITY, ROUND(AVG(P.UNITPRICE),2) AS AVGPRICE FROM PRODUCTS AS P 
JOIN STOCK AS S ON P.PRODUCTID = S.PRODUCTID
GROUP BY P.CATEGORY
ORDER BY QUANTITY DESC;

END //

DELIMITER ;

CALL GetStockSummary();

SELECT * FROM PRODUCTS;
 
-- TASK 8 Create a stored procedure to get all stock details with product info
-- Create a stored procedure to display complete stock details with the corresponding product name, unit price, and category.

DELIMITER //

CREATE PROCEDURE GetFullStockDetails()  

BEGIN 

SELECT S.STOCKID, P.PRODUCTNAME, P.CATEGORY, P.UNITPRICE, S.QUANTITY, S.WAREHOUSEID  FROM PRODUCTS AS P 
JOIN STOCK AS S ON P.PRODUCTID = S.PRODUCTID;

END //

DELIMITER ;

CALL GetFullStockDetails();

SELECT * FROM PRODUCTS;






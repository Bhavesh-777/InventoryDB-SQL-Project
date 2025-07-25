
-- Task 8 – Analytical Queries

-- Query 1: Top 5 Best-Selling Products

SELECT P.PRODUCTNAME, SUM(S.QUANTITY) AS TOTALSOLD FROM PRODUCTS AS P
JOIN SALES AS S ON P.PRODUCTID = S.PRODUCTID
GROUP BY P.PRODUCTNAME 
ORDER BY TOTALSOLD DESC
LIMIT 5;

-- Query 2: Monthly Sales Trend
-- How much revenue did we earn in each month?

SELECT 
  DATE_FORMAT(S.SaleDate, '2025-07') AS SaleMonth,
  SUM(S.Quantity * P.UnitPrice) AS MonthlyRevenue
FROM Sales AS S
JOIN Products AS P ON S.ProductID = P.ProductID
GROUP BY SaleMonth
ORDER BY SaleMonth;

SELECT * FROM SALES;

-- Query 3: Category-Wise Revenue
-- Which product categories are making the most money?

SELECT 
  P.Category,
  SUM(S.Quantity * P.UnitPrice) AS CategoryRevenue
FROM Sales AS S
JOIN Products AS P ON S.ProductID = P.ProductID
GROUP BY P.Category
ORDER BY CategoryRevenue DESC;

-- Query 4: Warehouse with the Highest Total Stock
-- Which warehouse currently has the most inventory ? 

SELECT 
  W.Location,
  SUM(S.Quantity) AS TotalStock
FROM Stock AS S
JOIN Warehouses AS W ON S.WarehouseID = W.WarehouseID
GROUP BY W.Location
ORDER BY TotalStock DESC;








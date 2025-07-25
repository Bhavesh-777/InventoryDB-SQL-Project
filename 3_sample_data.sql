USE INVENTORYDB;

-- Insert product records (ProductName, Category, UnitPrice, ReorderLevel)

INSERT INTO Products (ProductName, Category, UnitPrice, ReorderLevel)
VALUES 
('USB Cable', 'Electronics', 150.00, 20),
('Bluetooth Speaker', 'Electronics', 1200.00, 10),
('Notebook', 'Stationery', 50.00, 100),
('Ball Pen', 'Stationery', 10.00, 200),
('Desk Lamp', 'Home & Office', 500.00, 15),
('LED Monitor 24"', 'Electronics', 8500.00, 5),
('Office Chair', 'Furniture', 4500.00, 8),
('Whiteboard', 'Furniture', 1100.00, 5),
('Smart Watch', 'Wearables', 2500.00, 7),
('Gaming Mouse', 'Electronics', 850.00, 10),
('Backpack', 'Bags', 900.00, 15),
('Stapler', 'Stationery', 120.00, 30),
('Extension Board', 'Electronics', 300.00, 20),
('Calculator', 'Stationery', 250.00, 25),
('Portable Hard Drive', 'Electronics', 4200.00, 6);

SELECT * FROM PRODUCTS;

-- Insert supplier records (SupplierName, ContactEmail, Country)

INSERT INTO Suppliers (SupplierName, ContactEmail, Country)
VALUES 
('Tech Supplies Ltd', 'techsupplies@example.com', 'India'),
('Global Stationers', 'stationery@example.com', 'USA'),
('Urban Gadgets', 'urbangadgets@example.com', 'India'),
('Nova Traders', 'nova@example.com', 'Germany'),
('Alpha Retailers', 'alpha@example.com', 'UK'),
('Smart Electronics', 'smart_elec@example.com', 'Japan'),
('Print & Paper Co', 'printpaper@example.com', 'USA'),
('Gadget Hub', 'gadgethub@example.com', 'India'),
('Comfort Furniture', 'comfort@example.com', 'China'),
('Office Depot India', 'officedepot@example.com', 'India');

SELECT * FROM SUPPLIERS;

-- Insert warehouse records (Location, Capacity)

INSERT INTO Warehouses (Location, Capacity)
VALUES 
('Mumbai Central', 5000),
('Delhi North', 4000),
('Bangalore Hub', 6000),
('Hyderabad South', 4500),
('Pune West', 3500);

SELECT * FROM Warehouses;

-- Insert stock records (ProductID, WarehouseID, Quantity)
-- Linking products to warehouses with available quantity

INSERT INTO Stock (ProductID, WarehouseID, Quantity)
VALUES 
(1, 1, 100),
(1, 2, 80),
(2, 1, 50),
(2, 3, 30),
(3, 2, 200),
(3, 4, 150),
(4, 1, 300),
(5, 5, 40),
(6, 3, 25),
(7, 1, 10),
(7, 2, 12),
(8, 4, 7),
(9, 3, 18),
(10, 1, 50),
(11, 5, 22),
(12, 2, 70),
(13, 3, 33),
(14, 2, 60),
(15, 4, 12),
(6, 5, 10),
(8, 2, 5),
(9, 4, 10),
(11, 1, 15),
(12, 3, 45),
(13, 4, 27),
(14, 5, 20),
(15, 1, 6),
(5, 2, 13),
(10, 3, 18),
(4, 4, 90);

SELECT * FROM STOCK;

-- Insert purchase records (ProductID, SupplierID, Quantity)
-- These represent items bought and added to stock

INSERT INTO Purchases (ProductID, SupplierID, Quantity)
VALUES 
(1, 1, 120),
(2, 3, 40),
(3, 2, 250),
(4, 2, 500),
(5, 4, 60),
(6, 6, 30),
(7, 5, 15),
(8, 5, 10),
(9, 3, 25),
(10, 1, 100),
(11, 9, 20),
(12, 7, 90),
(13, 1, 45),
(14, 2, 75),
(15, 3, 20),
(6, 6, 15),
(2, 1, 25),
(5, 4, 30),
(13, 7, 22),
(14, 8, 35),
(9, 3, 10),
(7, 5, 12),
(8, 6, 8),
(10, 1, 50),
(11, 4, 30),
(3, 2, 200),
(12, 9, 55),
(13, 7, 33),
(15, 10, 10),
(4, 2, 120),
(2, 1, 35),
(9, 6, 20),
(14, 2, 25),
(1, 1, 60),
(5, 4, 40),
(8, 6, 15),
(12, 7, 40),
(10, 3, 80),
(11, 4, 25),
(13, 1, 18);

SELECT * FROM PURCHASES;

-- Insert sales records (ProductID, Quantity, WarehouseID)
-- These simulate sales from stock to customers

INSERT INTO Sales (ProductID, Quantity, WarehouseID)
VALUES 
(1, 20, 1),
(2, 10, 1),
(3, 80, 2),
(4, 150, 1),
(5, 10, 5),
(6, 5, 3),
(7, 5, 2),
(8, 2, 4),
(9, 5, 3),
(10, 20, 1),
(11, 10, 5),
(12, 30, 2),
(13, 15, 3),
(14, 20, 2),
(15, 5, 4),
(6, 3, 5),
(8, 1, 2),
(9, 4, 4),
(11, 8, 1),
(12, 25, 3),
(13, 10, 4),
(14, 12, 5),
(15, 3, 1),
(5, 5, 2),
(10, 15, 3),
(4, 50, 4),
(3, 60, 2),
(2, 12, 1),
(1, 30, 2),
(9, 6, 4);

SELECT * FROM SALES;

-- Insert return records (ProductID, Source, Quantity)
-- Source: 'Purchase' = return to supplier, 'Sale' = return from customer

INSERT INTO Returns (ProductID, Source, Quantity)
VALUES 
(1, 'Purchase', 5),
(2, 'Sale', 2),
(3, 'Sale', 3),
(4, 'Purchase', 10),
(5, 'Sale', 1),
(6, 'Purchase', 4),
(7, 'Sale', 2),
(8, 'Purchase', 3),
(9, 'Sale', 1),
(10, 'Purchase', 2);

SELECT * FROM RETURNS;

-- Insert staff records (FullName, Role, Email)

INSERT INTO Staff (FullName, Role, Email)
VALUES 
('Amit Sharma', 'Inventory Manager', 'amit.sharma@inventory.com'),
('Priya Mehta', 'Purchase Executive', 'priya.mehta@inventory.com'),
('Rahul Desai', 'Sales Lead', 'rahul.desai@inventory.com'),
('Sneha Patil', 'Warehouse Officer', 'sneha.patil@inventory.com'),
('Karan Bhosale', 'Support Staff', 'karan.bhosale@inventory.com');

SELECT * FROM STAFF;

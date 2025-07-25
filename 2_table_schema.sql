-- 🔸 Table: Products

SHOW TABLES ;

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,  		-- Unique ID for each product
    ProductName VARCHAR(100) NOT NULL,         		-- Name of the product
    Category VARCHAR(50),                      		-- Product category (e.g., Electronics, Clothing)
    UnitPrice DECIMAL(10,2) CHECK (UnitPrice >= 0),  -- Price per unit, must be non-negative
    ReorderLevel INT DEFAULT 10 CHECK (ReorderLevel >= 0),  -- Min stock before reorder alert
    IsActive BOOLEAN DEFAULT TRUE              		-- Whether product is active in inventory
);

-- 🔸 Table: Suppliers

CREATE TABLE Suppliers (
    SupplierID INT AUTO_INCREMENT PRIMARY KEY,         -- Unique ID for supplier
    SupplierName VARCHAR(100) NOT NULL,                -- Name of supplier
    ContactEmail VARCHAR(100) UNIQUE,                  -- Supplier email (must be unique)
    Country VARCHAR(50)                                -- Country location
);

-- 🔸 Table: Warehouses

CREATE TABLE Warehouses (
    WarehouseID INT AUTO_INCREMENT PRIMARY KEY,        -- Unique ID for warehouse
    Location VARCHAR(100) NOT NULL,                    -- Location name/address
    Capacity INT CHECK (Capacity > 0)                  -- Capacity must be greater than 0
);

-- 🔸 Table: Stock ** A product in a warehouse must have only one current stock record."
CREATE TABLE Stock (
    StockID INT AUTO_INCREMENT PRIMARY KEY,            -- Unique ID for stock record
    ProductID INT,                                     -- FK to Products
    WarehouseID INT,                                   -- FK to Warehouses
    Quantity INT DEFAULT 0 CHECK (Quantity >= 0),      -- Current stock quantity
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID),
    UNIQUE (ProductID, WarehouseID)                    -- Prevent duplicate product per warehouse
);

-- 🔸 Table: Purchases
CREATE TABLE Purchases (
    PurchaseID INT AUTO_INCREMENT PRIMARY KEY,         -- Unique ID for purchase record
    ProductID INT,                                     -- FK to Products
    SupplierID INT,                                    -- FK to Suppliers
    Quantity INT CHECK (Quantity > 0),                 -- Quantity purchased
    PurchaseDate timestamp DEFAULT current_timestamp,            -- Date of purchase -- "MySQL doesn't allow DEFAULT CURRENT_DATE for DATE fields"
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- 🔸 Table: Sales
CREATE TABLE Sales (
    SaleID INT AUTO_INCREMENT PRIMARY KEY,             -- Unique ID for sale
    ProductID INT,                                     -- FK to Products
    Quantity INT CHECK (Quantity > 0),                 -- Quantity sold
    SaleDate timestamp DEFAULT current_timestamp,      -- Date of sale -- "MySQL doesn't allow DEFAULT CURRENT_DATE for DATE fields"
    WarehouseID INT,                                   -- Warehouse product sold from
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID)
);

-- 🔸 Table: Returns
CREATE TABLE Returns (
    ReturnID INT AUTO_INCREMENT PRIMARY KEY,           -- Unique ID for return
    ProductID INT,                                     -- FK to Products
    Source ENUM('Purchase', 'Sale'),                   -- Where return came from , PURCHASE- Return to supplier (input side), SALE - Return from customer (output side)
    Quantity INT CHECK (Quantity > 0),                 -- Quantity returned
    ReturnDate timestamp DEFAULT current_timestamp,    -- Date of return -- "MySQL doesn't allow DEFAULT CURRENT_DATE for DATE fields"
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- 🔸 Table: Staff
CREATE TABLE Staff (
    StaffID INT AUTO_INCREMENT PRIMARY KEY,            -- Unique staff ID
    FullName VARCHAR(100),                             -- Staff full name
    Role VARCHAR(50),                                  -- Role (e.g., Manager, Clerk)
    Email VARCHAR(100) UNIQUE                          -- Contact email
);

-- Adding some extra column as per requirement

-- Step 1: Add column to Sales table (only once)

ALTER TABLE Sales
ADD COLUMN OrderStatus VARCHAR(50) DEFAULT 'Pending';

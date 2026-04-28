CREATE DATABASE RetailDB;
USE RetailDB;

-- 1. Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    StockQuantity INT
);

-- 2. Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Email VARCHAR(100),
    JoinDate DATE
);

-- 3. Sales Table (The 'Fact' table)
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    ProductID INT,
    SaleDate DATE,
    Quantity INT,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Products VALUES 
(101, 'Laptop', 'Electronics', 75000, 10),
(102, 'Mouse', 'Electronics', 1500, 50),
(103, 'Desk Chair', 'Furniture', 12000, 5),
(104, 'Monitor', 'Electronics', 20000, 0); -- Out of stock item

INSERT INTO Customers VALUES 
(1, 'Samir Dhakal', 'samir@email.com', '2025-01-10'),
(2, 'Aditi Sharma', 'aditi@email.com', '2025-02-15'),
(3, 'John Doe', 'john@email.com', '2026-01-05');

INSERT INTO Sales (CustomerID, ProductID, SaleDate, Quantity, TotalAmount) VALUES 
(1, 101, '2026-03-01', 1, 75000),
(2, 102, '2026-03-02', 2, 3000),
(1, 103, '2026-03-05', 1, 12000);

-- Query A: Revenue by Category (The Business Insight)
SELECT p.Category, SUM(s.TotalAmount) AS TotalRevenue
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.Category;

-- Query B: Identify Out-of-Stock Products (Operational Support)
SELECT ProductName, StockQuantity 
FROM Products 
WHERE StockQuantity = 0;

-- Query C: Top Spending Customers (Client Data Processing)
SELECT c.CustomerName, SUM(s.TotalAmount) AS TotalSpent
FROM Customers c
JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerName
ORDER BY TotalSpent DESC;
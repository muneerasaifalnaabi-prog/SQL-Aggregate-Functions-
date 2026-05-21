USE COMPANYDB1;
--TASK1:
--Find the total salary of all employees  
SELECT SUM(SALARY) FROM Employee1;

--Find the average salary 
SELECT AVG(SALARY) FROM Employee1;

--Find the highest salary
SELECT MAX(SALARY) FROM Employee1;

--Find the lowest salary 
SELECT MIN(SALARY) FROM Employee1;

--Count the total number of employees
SELECT COUNT(SSN) FROM Employee1;

--TASK2
--Show total salary per department 
SELECT SUM(SALARY) FROM Employee1 GROUP BY DNUM;

--Average salary per department
SELECT AVG(SALARY) FROM Employee1 GROUP BY DNUM;

--Show number of employees in each department 
SELECT COUNT(SSN) FROM Employee1 GROUP BY DNUM;


--TASK3 
--Departments where total salary is greater than 10000
SELECT DNUM,
  SUM(SALARY) AS TotalSalary
FROM Employee1
GROUP BY DNUM
HAVING SUM(SALARY) > 10000;

--Departments with more than 5 employees
SELECT DNUM,
       COUNT(SSN) AS TotalEmployees
FROM Employee1
GROUP BY DNUM
HAVING COUNT(SSN) > 5;

--Departments with more than 5 employees
SELECT DNUM,
       COUNT(SSN) AS TotalEmployees
FROM Employee1
GROUP BY DNUM
HAVING COUNT(SSN) > 2;



-- Departments with more than 5 employees
SELECT DNUM,
       COUNT(SSN) AS TotalEmployees
FROM Employee1
GROUP BY DNUM
HAVING COUNT(SSN) > 2;

--3. Departments where average salary is above 5000
SELECT DNUM,
       AVG(SALARY) AS AverageSalary
FROM Employee1
GROUP BY DNUM
HAVING AVG(SALARY) > 5000;

--TASK4
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL
);
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    Amount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Customers (CustomerID, CustomerName) VALUES
(1, 'Ali'),
(2, 'Fatima'),
(3, 'Omar'),
(4, 'Aisha'),
(5, 'Khalid');

INSERT INTO Orders (OrderID, CustomerID, Amount) VALUES
(101, 1, 250.00),
(102, 1, 300.00),
(103, 2, 150.00),
(104, 3, 500.00),
(105, 3, 200.00),
(106, 4, 750.00),
(107, 5, 100.00),
(108, 2, 400.00);

--1. Total revenue from all orders
SELECT SUM(Amount) AS TotalRevenue
FROM Orders;

-- Average order amount
SELECT AVG(Amount) AS AverageOrderAmount
FROM Orders;

--3. Count total orders
SELECT COUNT(OrderID) AS TotalOrders
FROM Orders;

--Maximum and minimum order amount
SELECT MAX(Amount) AS MaxAmount,
       MIN(Amount) AS MinAmount
FROM Orders;

-- Total amount per customer
SELECT CustomerID,
       SUM(Amount) AS TotalSpent
FROM Orders
GROUP BY CustomerID;

--TASK 5 :
--Number of orders per customer
SELECT C.CustomerID,
       C.CustomerName,
       COUNT(O.OrderID) AS TotalOrders
FROM Customers C
LEFT JOIN Orders O
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CustomerName;

-- Total amount spent per customer
SELECT C.CustomerID,
       C.CustomerName,
       SUM(O.Amount) AS TotalSpent
FROM Customers C
LEFT JOIN Orders O
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CustomerName;

-- Customers who spent more than 1000 total
SELECT C.CustomerID,
       C.CustomerName,
       SUM(O.Amount) AS TotalSpent
FROM Customers C
INNER JOIN Orders O
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CustomerName
HAVING SUM(O.Amount) > 1000;

--Customers with no orders
SELECT C.CustomerID,
       C.CustomerName
FROM Customers C
LEFT JOIN Orders O
ON C.CustomerID = O.CustomerID
WHERE O.OrderID IS NULL;

--TASK6 


CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);
INSERT INTO Sales (SaleID, ProductID, Quantity, Price) VALUES
(1, 101, 5, 10.00),
(2, 101, 3, 10.00),
(3, 102, 2, 50.00),
(4, 102, 1, 50.00),
(5, 103, 10, 20.00),
(6, 104, 4, 15.00),
(7, 104, 6, 15.00),
(8, 105, 7, 30.00),
(9, 105, 2, 30.00),
(10, 106, 1, 100.00);

-- Total sales revenue (Quantity × Price)
SELECT SUM(Quantity * Price) AS TotalRevenue
FROM Sales;

--Total quantity sold per product
SELECT ProductID,
       SUM(Quantity) AS TotalQuantity
FROM Sales
GROUP BY ProductID;

-- Average price per product
SELECT ProductID,
       AVG(Price) AS AveragePrice
FROM Sales
GROUP BY ProductID;

--Best-selling product (highest quantity sold)
SELECT TOP 1 ProductID,
       SUM(Quantity) AS TotalQuantity
FROM Sales
GROUP BY ProductID
ORDER BY TotalQuantity DESC;

--TASK 7 :
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL
);

CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
--Products data
INSERT INTO Products (ProductID, ProductName) VALUES
(101, 'Laptop'),
(102, 'Mobile'),
(103, 'Tablet'),
(104, 'Headphones'),
(105, 'Keyboard');

--OrderDetails data
INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES
(1, 101, 10),
(2, 101, 15),
(3, 102, 20),
(4, 102, 5),
(5, 103, 30),
(6, 104, 12),
(7, 104, 8),
(8, 105, 25),
(9, 105, 30),
(10, 103, 5);

--Total quantity sold per product name
SELECT P.ProductName,
       SUM(O.Quantity) AS TotalQuantity
FROM OrderDetails O
INNER JOIN Products P
ON O.ProductID = P.ProductID
GROUP BY P.ProductName;

--Products with total quantity greater than 50
SELECT P.ProductName,
       SUM(O.Quantity) AS TotalQuantity
FROM OrderDetails O
INNER JOIN Products P
ON O.ProductID = P.ProductID
GROUP BY P.ProductName
HAVING SUM(O.Quantity) > 50;

-- Number of orders per product
SELECT P.ProductName,
       COUNT(O.OrderID) AS TotalOrders
FROM OrderDetails O
INNER JOIN Products P
ON O.ProductID = P.ProductID
GROUP BY P.ProductName;

-- Most ordered product
SELECT TOP 1 P.ProductName,
       SUM(O.Quantity) AS TotalQuantity
FROM OrderDetails O
INNER JOIN Products P
ON O.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY TotalQuantity DESC;

--TASK8
-- Maximum salary per department
SELECT DNUM,
       MAX(Salary) AS MaxSalary
FROM Employee1
GROUP BY DNUM;

-- Minimum salary per department
SELECT DNUM,
       MIN(Salary) AS MinSalary
FROM Employee1
GROUP BY DNUM;

--Average salary per department
SELECT DNUM,
       AVG(Salary) AS AvgSalary
FROM Employee1
GROUP BY DNUM;

-- Salary difference (MAX - MIN)
SELECT DNUM,
       MAX(Salary) AS MaxSalary,
       MIN(Salary) AS MinSalary,
       (MAX(Salary) - MIN(Salary)) AS SalaryDifference
FROM Employee1
GROUP BY DNUM;

--TASK 9
-- Departments where average salary is above 6000
SELECT DNUM,
       AVG(Salary) AS AvgSalary
FROM Employee1
GROUP BY DNUM
HAVING AVG(Salary) > 6000;

-- Departments where total salary is above 20000
SELECT DNUM,
       SUM(Salary) AS TotalSalary
FROM Employee1
GROUP BY DNUM
HAVING SUM(Salary) > 20000;

-- Departments with more than 3 employees
SELECT DNUM,
       COUNT(SSN) AS TotalEmployees
FROM Employee1
GROUP BY DNUM
HAVING COUNT(SSN) > 3;

-- Sort by highest average salary
SELECT DNUM,
       AVG(Salary) AS AvgSalary
FROM Employee1
GROUP BY DNUM
ORDER BY AvgSalary DESC;

--TASK10 
-- Total spending per customer
SELECT C.CustomerID,
       C.CustomerName,
       SUM(O.Amount) AS TotalSpending
FROM Customers C
INNER JOIN Orders O
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CustomerName;


-- Average order value per customer
SELECT C.CustomerID,
       C.CustomerName,
       AVG(O.Amount) AS AverageOrderValue
FROM Customers C
INNER JOIN Orders O
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CustomerName;

-- Number of orders per customer
SELECT C.CustomerID,
       C.CustomerName,
       COUNT(O.OrderID) AS TotalOrders
FROM Customers C
LEFT JOIN Orders O
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CustomerName;

-- Customers who spent more than 500
SELECT C.CustomerID,
       C.CustomerName,
       SUM(O.Amount) AS TotalSpending
FROM Customers C
INNER JOIN Orders O
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CustomerName
HAVING SUM(O.Amount) > 500;


--TASK 11 :
-- Total revenue per product
SELECT ProductID,
       SUM(Quantity * Price) AS TotalRevenue
FROM Sales
GROUP BY ProductID;

--2. Total quantity sold per product
SELECT ProductID,
       SUM(Quantity) AS TotalQuantity
FROM Sales
GROUP BY ProductID;

--Average price per product
SELECT ProductID,
       AVG(Price) AS AveragePrice
FROM Sales
GROUP BY ProductID;

-- Products where revenue > 1000
SELECT ProductID,
       SUM(Quantity * Price) AS TotalRevenue
FROM Sales
GROUP BY ProductID
HAVING SUM(Quantity * Price) > 1000;

--TASK 12 :
--Total number of orders
SELECT COUNT(OrderID) AS TotalOrders
FROM Orders;

-- Total revenue
SELECT SUM(Amount) AS TotalRevenue
FROM Orders;

-- Average order amount
SELECT AVG(Amount) AS AverageOrderAmount
FROM Orders;

-- Highest and lowest order amount
SELECT MAX(Amount) AS HighestAmount,
       MIN(Amount) AS LowestAmount
FROM Orders;

-- Customers with more than 2 orders
SELECT CustomerID,
       COUNT(OrderID) AS TotalOrders
FROM Orders
GROUP BY CustomerID
HAVING COUNT(OrderID) > 2;


--TASK 13 :
--1. Total orders per customer name
SELECT C.CustomerName,
       COUNT(O.OrderID) AS TotalOrders
FROM Customers C
INNER JOIN Orders O
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName;

--Total spending per customer name
SELECT C.CustomerName,
       SUM(O.Amount) AS TotalSpending
FROM Customers C
INNER JOIN Orders O
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName;

--Customers with spending above 1000
SELECT C.CustomerName,
       SUM(O.Amount) AS TotalSpending
FROM Customers C
INNER JOIN Orders O
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName
HAVING SUM(O.Amount) > 1000;

--Sort by highest spending
SELECT C.CustomerName,
       SUM(O.Amount) AS TotalSpending
FROM Customers C
INNER JOIN Orders O
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName
ORDER BY TotalSpending DESC;


--TASK 14 :
-- Departments where MAX salary > 8000
SELECT DNUM,
       MAX(Salary) AS MaxSalary
FROM Employee1
GROUP BY DNUM
HAVING MAX(Salary) > 8000;


-- Departments where MIN salary < 3000
SELECT DNUM,
       MIN(Salary) AS MinSalary
FROM Employee1
GROUP BY DNUM
HAVING MIN(Salary) < 3000;

-- Departments where AVG salary between 4000 and 7000
SELECT DNUM,
       AVG(Salary) AS AvgSalary
FROM Employee1
GROUP BY DNUM
HAVING AVG(Salary) BETWEEN 4000 AND 7000;

-- Departments with at least 2 employees
SELECT DNUM,
       COUNT(SSN) AS TotalEmployees
FROM Employee1
GROUP BY DNUM
HAVING COUNT(SSN) >= 2;

--TASK 15

-- Total revenue per product name
SELECT P.ProductName,
       SUM(S.Quantity * S.Price) AS TotalRevenue
FROM Sales S
INNER JOIN Products P
ON S.ProductID = P.ProductID
GROUP BY P.ProductName;

-- Total revenue per product name
SELECT P.ProductName,
       SUM(S.Quantity * S.Price) AS TotalRevenue
FROM Sales S
INNER JOIN Products P
ON S.ProductID = P.ProductID
GROUP BY P.ProductName;

-- Best-selling product (by quantity)
SELECT TOP 1 P.ProductName,
       SUM(S.Quantity) AS TotalQuantity
FROM Sales S
INNER JOIN Products P
ON S.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY TotalQuantity DESC;


-- Most profitable product (by revenue)
SELECT TOP 1 P.ProductName,
       SUM(S.Quantity * S.Price) AS TotalRevenue
FROM Sales S
INNER JOIN Products P
ON S.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY TotalRevenue DESC;

--Products with no sales
SELECT P.ProductName
FROM Products P
LEFT JOIN Sales S
ON P.ProductID = S.ProductID
WHERE S.SaleID IS NULL;

--TASK 16 
-- Total salary per department
SELECT DNUM,
       SUM(Salary) AS TotalSalary
FROM Employee1
GROUP BY DNUM;

--Average salary per department
SELECT DNUM,
       AVG(Salary) AS AvgSalary
FROM Employee1
GROUP BY DNUM;

--Departments where total salary is above overall average department salary

SELECT DNUM,
       SUM(Salary) AS TotalSalary
FROM Employee1
GROUP BY DNUM
HAVING SUM(Salary) >
(
    SELECT AVG(DeptTotal)
    FROM (
        SELECT SUM(Salary) AS DeptTotal
        FROM Employee1
        GROUP BY DNUM
    ) AS DeptTable
);

-- Rank departments by total salary (conceptual)
SELECT DNUM,
       SUM(Salary) AS TotalSalary,
       RANK() OVER (ORDER BY SUM(Salary) DESC) AS DeptRank
FROM Employee1
GROUP BY DNUM;


--TASK17
ALTER TABLE Sales
ADD SaleDate DATE;

UPDATE Sales SET SaleDate = '2026-01-01' WHERE SaleID = 1;
UPDATE Sales SET SaleDate = '2026-01-01' WHERE SaleID = 2;
UPDATE Sales SET SaleDate = '2026-01-02' WHERE SaleID = 3;
UPDATE Sales SET SaleDate = '2026-01-02' WHERE SaleID = 4;
UPDATE Sales SET SaleDate = '2026-01-03' WHERE SaleID = 5;
UPDATE Sales SET SaleDate = '2026-01-03' WHERE SaleID = 6;
UPDATE Sales SET SaleDate = '2026-01-04' WHERE SaleID = 7;
UPDATE Sales SET SaleDate = '2026-01-04' WHERE SaleID = 8;
UPDATE Sales SET SaleDate = '2026-01-05' WHERE SaleID = 9;
UPDATE Sales SET SaleDate = '2026-01-05' WHERE SaleID = 10;
--Total revenue per day
SELECT SaleDate,
       SUM(Quantity * Price) AS TotalRevenue
FROM Sales
GROUP BY SaleDate;


-- Total revenue per month
SELECT MONTH(SaleDate) AS SaleMonth,
       SUM(Quantity * Price) AS TotalRevenue
FROM Sales
GROUP BY MONTH(SaleDate);


-- Day with highest sales revenue
SELECT TOP 1 SaleDate,
       SUM(Quantity * Price) AS TotalRevenue
FROM Sales
GROUP BY SaleDate
ORDER BY TotalRevenue DESC;

-- Number of sales per month
SELECT MONTH(SaleDate) AS SaleMonth,
       COUNT(SaleID) AS TotalSales
FROM Sales
GROUP BY MONTH(SaleDate);

--TASK 18:
-- Customers with more than 5 orders
SELECT CustomerID,
       COUNT(OrderID) AS TotalOrders
FROM Orders
GROUP BY CustomerID
HAVING COUNT(OrderID) > 5;

-- Customers with average order value above 200
SELECT CustomerID,
       AVG(Amount) AS AvgOrderValue
FROM Orders
GROUP BY CustomerID
HAVING AVG(Amount) > 200;

-- Top 3 customers by total spending
SELECT TOP 3 CustomerID,
       SUM(Amount) AS TotalSpending
FROM Orders
GROUP BY CustomerID
ORDER BY TotalSpending DESC;
--Customers who placed only one order
SELECT CustomerID,
       COUNT(OrderID) AS TotalOrders
FROM Orders
GROUP BY CustomerID
HAVING COUNT(OrderID) = 1;

--TASK 19 

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL
);
ALTER TABLE Products
ADD CategoryID INT;
ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID)
REFERENCES Categories(CategoryID);

INSERT INTO Categories (CategoryID, CategoryName) VALUES
(1, 'Electronics'),
(2, 'Home Appliances'),
(3, 'Accessories');

-- Total revenue per category
SELECT C.CategoryName,
       SUM(S.Quantity * S.Price) AS TotalRevenue
FROM Sales S
INNER JOIN Products P
ON S.ProductID = P.ProductID
INNER JOIN Categories C
ON P.CategoryID = C.CategoryID
GROUP BY C.CategoryName;


-- Average product revenue per category
SELECT C.CategoryName,
       AVG(S.Quantity * S.Price) AS AvgRevenue
FROM Sales S
INNER JOIN Products P
ON S.ProductID = P.ProductID
INNER JOIN Categories C
ON P.CategoryID = C.CategoryID
GROUP BY C.CategoryName;

-- Categories with revenue > 5000
SELECT C.CategoryName,
       SUM(S.Quantity * S.Price) AS TotalRevenue
FROM Sales S
INNER JOIN Products P
ON S.ProductID = P.ProductID
INNER JOIN Categories C
ON P.CategoryID = C.CategoryID
GROUP BY C.CategoryName
HAVING SUM(S.Quantity * S.Price) > 5000;

-- Best category by total sales
SELECT TOP 1 C.CategoryName,
       SUM(S.Quantity * S.Price) AS TotalRevenue
FROM Sales S
INNER JOIN Products P
ON S.ProductID = P.ProductID
INNER JOIN Categories C
ON P.CategoryID = C.CategoryID
GROUP BY C.CategoryName
ORDER BY TotalRevenue DESC;

-- Best category by total sales
SELECT TOP 1 C.CategoryName,
       SUM(S.Quantity * S.Price) AS TotalRevenue
FROM Sales S
INNER JOIN Products P
ON S.ProductID = P.ProductID
INNER JOIN Categories C
ON P.CategoryID = C.CategoryID
GROUP BY C.CategoryName
ORDER BY TotalRevenue DESC;

--TASK 20 :

-- Count employees with non-null salary
SELECT COUNT(Salary) AS EmployeesWithSalary
FROM Employee1;

-- Departments including those with NULL salaries
SELECT DNUM,
       COUNT(Salary) AS EmployeesWithSalary
FROM Employee1
GROUP BY DNUM;

-- Average salary ignoring NULL values
SELECT DNUM,
       AVG(Salary) AS AvgSalary
FROM Employee1
GROUP BY DNUM;

-- Departments where all salaries are NULL
SELECT DNUM
FROM Employee1
GROUP BY DNUM
HAVING COUNT(Salary) = 0;










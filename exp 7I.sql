CREATE TABLE Sales_UNF (
    OrderID INT,
    OrderDate DATE,
    CustomerID VARCHAR(10),
    CustomerName VARCHAR(100),
    ProductID VARCHAR(10),
    ProductName VARCHAR(100),
    Qty INT,
    UnitPrice DECIMAL(10,2)
);

INSERT INTO Sales_UNF VALUES
(101, '2026-10-01', 'C01', 'Asha', 'P10', 'Keyboard', 2, 800.00),
(101, '2026-10-01', 'C01', 'Asha', 'P11', 'Mouse', 1, 400.00),
(102, '2026-10-02', 'C02', 'Ravi', 'P10', 'Keyboard', 1, 800.00);

SELECT * FROM Sales_UNF;

CREATE TABLE Sales_1NF (
    OrderID INT,
    OrderDate DATE,
    CustomerID VARCHAR(10),
    CustomerName VARCHAR(100),
    ProductID VARCHAR(10),
    ProductName VARCHAR(100),
    Qty INT,
    UnitPrice DECIMAL(10,2),
    PRIMARY KEY (OrderID, ProductID)
);

INSERT INTO Sales_1NF
SELECT * FROM Sales_UNF;

SELECT * FROM Sales_1NF;

CREATE TABLE Orders_2NF (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID VARCHAR(10),
    CustomerName VARCHAR(100)
);

CREATE TABLE Products_2NF (
    ProductID VARCHAR(10) PRIMARY KEY,
    ProductName VARCHAR(100),
    UnitPrice DECIMAL(10,2)
);

CREATE TABLE OrderDetails_2NF (
    OrderID INT,
    ProductID VARCHAR(10),
    Qty INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders_2NF(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products_2NF(ProductID)
);

INSERT INTO Orders_2NF VALUES
(101, '2026-10-01', 'C01', 'Asha'),
(102, '2026-10-02', 'C02', 'Ravi');

INSERT INTO Products_2NF VALUES
('P10', 'Keyboard', 800.00),
('P11', 'Mouse', 400.00);

INSERT INTO OrderDetails_2NF VALUES
(101, 'P10', 2),
(101, 'P11', 1),
(102, 'P10', 1);
SELECT * FROM Orders_2NF;
SELECT * FROM Products_2NF;
SELECT * FROM OrderDetails_2NF;
CREATE TABLE Customers (
    CustomerID VARCHAR(10) PRIMARY KEY,
    CustomerName VARCHAR(100)
);
CREATE TABLE Orders_3NF (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID VARCHAR(10),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
CREATE TABLE Products_3NF (
    ProductID VARCHAR(10) PRIMARY KEY,
    ProductName VARCHAR(100),
    UnitPrice DECIMAL(10,2)
);
CREATE TABLE OrderDetails_3NF (
    OrderID INT,
    ProductID VARCHAR(10),
    Qty INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders_3NF(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products_3NF(ProductID)
);

INSERT INTO Customers VALUES
('C01', 'Asha'),
('C02', 'Ravi');

INSERT INTO Orders_3NF VALUES
(101, '2026-10-01', 'C01'),
(102, '2026-10-02', 'C02');

INSERT INTO Products_3NF VALUES
('P10', 'Keyboard', 800.00),
('P11', 'Mouse', 400.00);

INSERT INTO OrderDetails_3NF VALUES
(101, 'P10', 2),
(101, 'P11', 1),
(102, 'P10', 1);

SELECT * FROM Customers;
SELECT * FROM Orders_3NF;
SELECT * FROM Products_3NF;
SELECT * FROM OrderDetails_3NF;

SELECT
    O.OrderID,
    O.OrderDate,
    O.CustomerID,
    C.CustomerName,
    P.ProductID,
    P.ProductName,
    D.Qty,
    P.UnitPrice
FROM Orders_3NF O
JOIN Customers C
    ON O.CustomerID = C.CustomerID
JOIN OrderDetails_3NF D
    ON O.OrderID = D.OrderID
JOIN Products_3NF P
    ON D.ProductID = P.ProductID
ORDER BY O.OrderID, P.ProductID;
SELECT OrderID, OrderDate, CustomerID
FROM Orders_3NF;
SELECT CustomerID, CustomerName
FROM Customers;
SELECT ProductID, ProductName, UnitPrice
FROM Products_3NF;
SELECT OrderID, ProductID, Qty
FROM OrderDetails_3NF;
SELECT
    OrderID,
    ProductID,
    COUNT(*) AS TotalRows
FROM OrderDetails_3NF
GROUP BY OrderID, ProductID
HAVING COUNT(*) > 1;
SELECT
    O.OrderID,
    O.OrderDate,
    C.CustomerID,
    C.CustomerName,
    P.ProductID,
    P.ProductName,
    D.Qty,
    P.UnitPrice
FROM Orders_3NF O
JOIN Customers C
    ON O.CustomerID = C.CustomerID
JOIN OrderDetails_3NF D
    ON O.OrderID = D.OrderID
JOIN Products_3NF P
    ON D.ProductID = P.ProductID
ORDER BY O.OrderID, P.ProductID;
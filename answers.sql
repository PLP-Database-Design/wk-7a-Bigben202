--  Question 1 Achieving 1NF (First Normal Form)
 
SELECT 
    OrderID,
    CustomerName,
    TRIM(product) AS Product
FROM
    ProductDetail,
    JSON_TABLE(
        CONCAT('["', REPLACE(Products, ',', '","'), '"]'),
        '$[*]' COLUMNS(product VARCHAR(100) PATH '$')
    ) AS prod;

--  Question 2 Achieving 2NF (Second Normal Form) 
-- Solution: Decompose the table into two tables:

-- 1. Orders table (OrderID → CustomerName)

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- 2. OrderItems table (OrderID + Product → Quantity)

CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;





/*
------------------------------------------------------------
LeetCode :
Title    : Customers Who Never Order
Difficulty : Easy

------------------------------------------------------------
Question

Find all customers who never placed an order.

------------------------------------------------------------
Schema
*/

CREATE TABLE Customers (
    id INT,
    name VARCHAR(50)
);

CREATE TABLE Orders (
    id INT,
    customerId INT
);

INSERT INTO Customers VALUES
(1,'Joe'),
(2,'Henry'),
(3,'Sam'),
(4,'Max');

INSERT INTO Orders VALUES
(1,3),
(2,1);

/*
------------------------------------------------------------
Solution
------------------------------------------------------------
*/

SELECT c.name AS Customers
FROM Customers c
LEFT JOIN Orders o
ON c.id = o.customerId
WHERE o.customerId IS NULL;

/*
------------------------------------------------------------
Alternative Solution
------------------------------------------------------------
*/

SELECT name
FROM Customers
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.customerId = Customers.id
);
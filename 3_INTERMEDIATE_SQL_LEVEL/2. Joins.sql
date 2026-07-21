/* ==============================================================================
   SQL Joins 
-------------------------------------------------------------------------------
   This section provides an overview of SQL joins, which allow combining data
   from multiple tables to retrieve meaningful insights.

   Table of Contents:
     1. Basic Joins
        - INNER JOIN
        - LEFT JOIN
        - RIGHT JOIN
        - FULL JOIN
     2. Advanced Joins
        - LEFT ANTI JOIN
        - RIGHT ANTI JOIN
        - ALTERNATIVE INNER JOIN
        - FULL ANTI JOIN
        - CROSS JOIN
     3. Multiple Table Joins (4 Tables)
=================================================================================
*/

/* ============================================================================== 
   BASIC JOINS 
=============================================================================== */

-- No Join
/* Retrieve all data from customers and orders as separate results */
SELECT * FROM customers;
SELECT * FROM orders;

-- INNER JOIN
/* Get all customers along with their orders, 
   but only for customers who have placed an order */
SELECT
	C.id,
    C.first_name,
    O.order_id,
    O.sales
FROM customers AS C
INNER JOIN orders AS O
ON C.id = O.customer_id;

-- LEFT JOIN
/* Get all customers along with their orders, 
   including those without orders */
SELECT
	C.id,
    C.first_name,
    O.order_id,
    O.order_date,
    O.sales
FROM customers AS C
LEFT JOIN orders AS O
ON C.id = O.customer_id;

-- RIGHT JOIN
/* Get all customers along with their orders, 
   including orders without matching customers */
SELECT
	C.id,
    C.first_name,
    O.order_id,
    O.order_date,
    O.sales
FROM customers AS C
RIGHT JOIN orders AS O
ON C.id = O.customer_id;

-- Alternative to RIGHT JOIN using LEFT JOIN
/* Get all customers along with their orders, 
   including orders without matching customers */
SELECT
    c.id,
    c.first_name,
    o.order_id,
	o.order_date,
    o.sales
FROM orders AS o 
LEFT JOIN customers AS c
ON c.id = o.customer_id;

/* NOTE:
MySQL Database Management System does not support FULL JOIN (or FULL OUTER JOIN).
IF you you run a FULL JOIN ON MySQL, you will get:

Error Code: 1064 - You have an error in your SQL syntax near 'FULL JOIN...'

Why?

FULL JOIN is supported by Database Management System such as:

SQL Server
PostgreSQL
Oracle

But MySQL Database Management System only supports:

INNER JOIN
LEFT JOIN
RIGHT JOIN
CROSS JOIN

Simulating a FULL JOIN in MySQL Database Management System 

If you need a true FULL JOIN, combine a LEFT JOIN and a RIGHT JOIN using UNION:
 */
 
SELECT
    C.id,
    C.first_name,
    O.order_id,
    O.order_date,
    O.sales
FROM customers AS C
LEFT JOIN orders AS O
ON C.id = O.customer_id

UNION

SELECT
    C.id,
    C.first_name,
    O.order_id,
    O.order_date,
    O.sales
FROM customers AS C
RIGHT JOIN orders AS O
ON C.id = O.customer_id;

-- LEFT ANTI JOIN
/* Get all customers who haven't placed any order */
SELECT *
FROM customers AS C
LEFT JOIN orders AS O
ON C.id = O.customer_id
WHERE customer_id IS NULL;

-- RIGHT ANTI JOIN
/* Get all orders without matching customers */
SELECT *
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id
WHERE c.id IS NULL;

-- Alternative to RIGHT ANTI JOIN using LEFT JOIN
/* Get all orders without matching customers */
SELECT *
FROM orders AS o 
LEFT JOIN customers AS c
ON c.id = o.customer_id
WHERE c.id IS NULL;

-- Alternative to INNER JOIN using LEFT JOIN
/* Get all customers along with their orders, 
   but only for customers who have placed an order */
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NOT NULL;

-- CROSS JOIN
/* Generate all possible combinations of customers and orders */
SELECT *
FROM customers
CROSS JOIN orders;

/* ============================================================================== 
   MULTIPLE TABLE JOINS (4 Tables)
=============================================================================== */

/* Task: Using the SalesDB, Retrieve a list of all orders, along with the related customer, product, 
   and employee details. For each order, display:
   - Order ID
   - Customer's name
   - Product name
   - Sales amount
   - Product price
   - Salesperson's name */

USE SalesDB;

SELECT 
    o.OrderID,
    o.Sales,
    c.FirstName AS CustomerFirstName,
    c.LastName AS CustomerLastName,
    p.Product AS ProductName,
    p.Price,
    e.FirstName AS SalesPersonFirstName,
    e.LastName AS SalesPersonLastName
FROM salesdb.Orders AS o
LEFT JOIN salesdb.Customers AS c
ON o.CustomerID = c.CustomerID
LEFT JOIN salesdb.Products AS p
ON o.ProductID = p.ProductID
LEFT JOIN salesdb.Employees AS e
ON o.SalesPersonID = e.EmployeeID;
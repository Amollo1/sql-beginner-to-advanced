

/* RULE: Data Types/* ==============================================================================
   SQL SET Operations
-------------------------------------------------------------------------------
   SQL set operations enable you to combine results from multiple queries
   into a single result set. This script demonstrates the rules and usage of
   set operations, including UNION, UNION ALL, EXCEPT, and INTERSECT.
   
   Table of Contents:
     1. SQL Operation Rules
     2. UNION
     3. UNION ALL
     4. EXCEPT
     5. INTERSECT
=================================================================================
*/

/* ==============================================================================
   RULES OF SET OPERATIONS

   The data types of columns in each query should match.
*/
USE salesdb;

SELECT
    FirstName,
    LastName
FROM salesdb.Customers
UNION
SELECT
    FirstName,
    LastName
FROM salesdb.Employees;

/* RULE: Data Types (Example)
   The data types of columns in each query should match.
*/
SELECT
	FirstName,
    LastName
FROM salesdb.Customers
UNION
SELECT
    FirstName,
    LastName
FROM salesdb.Employees;

/* RULE: Column Order
   The order of the columns in each query must be the same.
*/
SELECT
    LastName,
    CustomerID
FROM salesdb.Customers
UNION
SELECT
	LastName,
    EmployeeID
FROM salesdb.Employees;

/* RULE: Column Aliases
   The column names in the result set are determined by the column names
   specified in the first SELECT statement.
*/
SELECT
    CustomerID AS ID,
    LastName AS Last_Name
FROM salesdb.Customers
UNION
SELECT
    EmployeeID,
    LastName
FROM salesdb.Employees;

/* RULE: Correct Columns
   Ensure that the correct columns are used to maintain data consistency.
*/
SELECT
    FirstName as Given_Name,
    LastName as Family_Name
FROM salesdb.Customers
UNION
SELECT
    LastName,
    FirstName
FROM salesdb.Employees;

/* TASK 1: 
   Combine the data from Employees and Customers into one table using UNION 
*/
SELECT
	firstname,
	lastname
FROM salesdb.employees

UNION

SELECT
	firstname,
	lastname
FROM salesdb.customers;

/* TASK 2: 
   Combine the data from Employees and Customers into one table, including duplicates, using UNION ALL 
*/
SELECT
	firstname,
	lastname
FROM salesdb.employees

UNION ALL

SELECT
	firstname,
	lastname
FROM salesdb.customers;

/* TASK 3: 
   Find employees who are NOT customers using EXCEPT 
*/
SELECT
    FirstName,
    LastName
FROM salesdb.Employees

EXCEPT

SELECT
    FirstName,
    LastName
FROM Salesdb.Customers;

/*
EXCEPT is not fullly supported in MySQL Database Management System.
To achive the same result in MySQL, Use NOT EXIST or LEFT JOIN
*/

SELECT
    e.FirstName,
    e.LastName
FROM salesdb.Employees as e
WHERE NOT EXISTS (
	SELECT 1
	FROM salesdb.customers as c
	WHERE e.FirstName = c.FirstName
    );


/* TASK 4: 
   Find employees who are also customers using INTERSECT 
*/
SELECT
    FirstName,
    LastName
FROM salesdb.Employees

INTERSECT

SELECT
    FirstName,
    LastName
FROM Salesdb.Customers;


/* ==============================================================================
   SQL SELECT Query
-------------------------------------------------------------------------------
  SELECT is an SQL command used to retrieve data from one or more tables in a database.
-------------------------------------------------------------------------------
  The following section explores a variety of SELECT query techniques for efficiently retrieving,
  filtering, sorting, and summarizing data from database tables.
  These examples demonstrate how to extract meaningful
  information from a database using different SQL query operations as shown below.


   Table of Contents:
     1. SELECT ALL COLUMNS
     2. SELECT SPECIFIC COLUMNS
     3. WHERE CLAUSE
     4. ORDER BY
     5. GROUP BY
     6. HAVING
     7. DISTINCT
     8. TOP
     9. Combining Queries
	 10. COOL STUFF - Additional SQL Features
=================================================================================
*/

/* ==============================================================================
   COMMENTS: 
=============================================================================== */

/* Comments are notes added to SQL code to explain its purpose or improve readability.
They are ignored by the SQL Server database engine during execution.
------------------------------------------------------------------------------- */

-- This is a single-line comment.

/* This
   is
   a multiple-line
   comment
*/

/* ==============================================================================
   SELECT ALL COLUMNS
=============================================================================== */

-- Retrieve All Customer Data

SELECT * 
FROM 
customers;

-- Retrieve All Customer Data

SELECT * 
FROM 
orders;

/* ==============================================================================
   SELECT FEW COLUMNS:
   SELECT ... FROM is an SQL statement used to retrieve specific columns
   or all columns from a specified table in a database.
=============================================================================== */

-- Retrieve each customer's name, country, and score.

SELECT 
    first_name,
    country, 
    score
FROM customers;

/* ==============================================================================
   WHERE:
   WHERE Clause: The WHERE clause is used to filter records by specifying one
   or more conditions,returning only the rows that satisfy those conditions.
=============================================================================== */

-- Retrieve customers with a country is equal to Kenya

SELECT * 
FROM customers
WHERE country = 'Kenya';

-- Retrieve customers with a score not equal to 0
SELECT *
FROM customers
WHERE score > 0;

-- Retrieve the name and country of customers from Kenya
SELECT
    first_name,
    country
FROM customers
WHERE country = 'Kenya';

/* ==============================================================================
   ORDER BY:
   ORDER BY Clause: The ORDER BY clause is used to sort the result of a query in
   ascending (ASC) or descending (DESC) order based on one or more columns.
=============================================================================== */

/* Retrieve all customers and 
   sort the results by the highest score first. */

SELECT *
FROM
customers
ORDER BY score DESC;

/* Retrieve all customers and 
   sort the results by the lowest score first. */

SELECT *
FROM
customers
ORDER BY score ASC;

/* Retrieve all customers and 
   sort the results by the country. */

SELECT *
FROM
customers
ORDER BY country ASC;

/* Retrieve all customers and 
   sort the results by the country and then by the highest score. */

SELECT *
FROM customers
ORDER BY country ASC, score DESC;

/* Retrieve the name, country, and score of customers 
   whose score is not equal to 0
   and sort the results by the highest score first. */
   
   SELECT
	   first_name,
	   country,
	   score
   FROM
   customers
   WHERE score != 0
   ORDER BY score DESC;
   
   
   /* ==============================================================================
   GROUP BY:
   GROUP BY Clause: The GROUP BY clause is used to group rows that have the same
   values in one or more columns, typically for performing aggregate calculations
   such as COUNT(), SUM(), AVG(), MIN(), and MAX().
=============================================================================== */

-- Find the total score for each country

SELECT
	country,
	sum(score) as total
FROM
customers
GROUP BY country;

/* This will not work because 'first_name' is neither part of the GROUP BY 
   nor wrapped in an aggregate function. SQL doesn't know how to handle this column. */
SELECT 
    country,
    first_name,
    SUM(score) AS total_score
FROM customers
GROUP BY country;

-- Find the total score and total number of customers for each country

SELECT
	SUM(score) AS total_score_per_country,
    COUNT(id) AS total_number_customers,
	country
FROM
customers
GROUP BY country;

/* ==============================================================================
   HAVING:
   HAVING Clause: The HAVING clause is used to filter grouped data after
   the GROUP BY clause has been applied, based on aggregate conditions.
=============================================================================== */

/* Find the average score for each country
   and return only those countries with an average score greater than 430 */
   
SELECT
	AVG(score) AS average_score_per_country,
    COUNT(id) AS total_number_customers,
	country
FROM
customers
GROUP BY country
HAVING AVG(score) > 430;


/* Find the average score for each country
   considering only customers with a score not equal to 0
   and return only those countries with an average score greater than 430 */

SELECT
	country,
	AVG(score) as average_score
FROM
	customers
	WHERE score != 0
	GROUP BY country
	HAVING AVG(score) > 430;

/* ==============================================================================
   DISTINCT:
   DISTINCT Keyword: The DISTINCT keyword is used to return only unique values
   by eliminating duplicate rows from the query result.
=============================================================================== */

-- Return Unique list of all countries
SELECT DISTINCT country
FROM customers;

/* ==============================================================================
   TOP
=============================================================================== */

-- Return the first 3 rows
SELECT *
FROM Customers
LIMIT 3;

-- Retrieve the Top 3 Customers with the Highest Scores

SELECT *
FROM Customers
ORDER BY score DESC
limit 3;

-- Retrieve the Lowest 2 Customers based on the score
SELECT *
FROM Customers
ORDER BY score ASC
limit 2;

-- Get the Two Most Recent Orders

SELECT *
FROM
ORDERS
ORDER BY order_date DESC
LIMIT 2;

/* ==============================================================================
   All Put Together
=============================================================================== */

/* Calculate the average score for each country 
   considering only customers with a score not equal to 0
   and return only those countries with an average score greater than 430
   and sort the results by the highest average score first. */

SELECT
	AVG(score) AS average_score,
	country
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430
ORDER BY AVG(score) DESC;

/* ============================================================================== 
   SOME NICE Additional SQL Features
=============================================================================== */

-- Execute multiple queries at once
SELECT * FROM customers;
SELECT * FROM orders;

/* Selecting Static Data */
-- Select a static or constant value without accessing any table
SELECT 123 AS static_number;

SELECT 'Hello' AS static_string;

-- Assign a constant value to a column in a query
SELECT
    id,
    first_name,
    'New Customer' AS customer_type
FROM customers;


/* ============================================================================== 
   SQL Filtering Data
-------------------------------------------------------------------------------
   This document provides an overview of SQL filtering techniques using WHERE 
   and various operators for precise data retrieval.

   Table of Contents:
     1. Comparison Operators
        - =, <>, !=, >, >=, <, <=,
     2. Logical Operators
        - AND, OR, NOT
     3. Range Filtering
        - BETWEEN
     4. Set Filtering
        - IN
     5. Pattern Matching
        - LIKE
=================================================================================
*/

/* ============================================================================== 
   COMPARISON OPERATORS
=============================================================================== */

-- Retrieve all customers from Kenay.
SELECT *
FROM customers
WHERE country = 'Kenya';

-- Retrieve all customers who are not from Kenya.
SELECT *
FROM customers
WHERE country <> 'Kenya';

-- Retrieve all customers who are not from Kenya. (2nd Example).
SELECT *
FROM customers
WHERE country != 'Kenya';

-- Retrieve all customers with a score greater than 500.
SELECT *
FROM customers
where score >  500;

-- Retrieve all customers with a score of 500 or more.
SELECT *
FROM customers
where score >=  500;

-- Retrieve all customers with a score less than 500.
SELECT *
FROM customers
where score <  500;

-- Retrieve all customers with a score of 500 or less.
SELECT *
FROM customers
where score <=  500;

/* ============================================================================== 
   LOGICAL OPERATORS
=============================================================================== */

/* Combining conditions using AND, OR, and NOT */

-- Retrieve all customers who are from South Africa and have a score greater than 500.
SELECT *
FROM customers
where country = 'South Africa' AND score > 500;

-- Retrieve all customers who are either from the Kenya or have a score greater than 500.
SELECT *
FROM customers
WHERE country = 'Kenya' OR score > 500;

-- Retrieve all customers with a score not less than 500.
SELECT *
FROM customers
WHERE score >= 500;

-- Retrieve all customers with a score not less than 500. (Example 2)
SELECT *
FROM customers
WHERE NOT score < 500;

/* ============================================================================== 
   RANGE FILTERING - BETWEEN
=============================================================================== */

-- Retrieve all customers whose score falls in the range between 100 and 500.
SELECT *
FROM customers
WHERE score BETWEEN 100 AND 500;

-- Alternative method (Equivalent to BETWEEN)
SELECT *
FROM customers
WHERE score >= 100 AND score <=500;

/* ============================================================================== 
   SET FILTERING - IN, NOT IN
=============================================================================== */

-- Retrieve all customers from either Kenya or the South Africa.
SELECT *
FROM customers
WHERE country IN ('Kenya','South Africa');

SELECT *
FROM customers
WHERE country NOT IN ('Kenya','South Africa');


/* ============================================================================== 
   PATTERN MATCHING - LIKE
=============================================================================== */

-- Find all customers whose first name starts with 'L'.
SELECT *
FROM customers
WHERE first_name LIKE 'L%';

-- Find all customers whose first name ends with 'D'.
SELECT *
FROM customers
WHERE first_name LIKE '%d';

-- Find all customers whose first name contains 'r'.
SELECT *
FROM customers
WHERE first_name LIKE '%r%';

-- Find all customers whose first name has 'r' in the third position.
SELECT *
FROM customers
WHERE first_name LIKE '__r%'
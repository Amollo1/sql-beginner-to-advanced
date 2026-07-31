/* ==============================================================================
   SQL NULL Functions
-------------------------------------------------------------------------------
   This script highlights essential SQL functions for managing NULL values.
   It demonstrates how to handle NULLs in data aggregation, mathematical operations,
   sorting, and comparisons. These techniques help maintain data integrity 
   and ensure accurate query results.

   Table of Contents:
     1. Handle NULL - Data Aggregation
     2. Handle NULL - Mathematical Operators
     3. Handle NULL - Sorting Data
     4. NULLIF - Division by Zero
     5. IS NULL - IS NOT NULL
     6. LEFT ANTI JOIN
     7. NULLs vs Empty String vs Blank Spaces
===============================================================================
*/

/* ==============================================================================
   HANDLE NULL - DATA AGGREGATION
===============================================================================*/

/* TASK 1: 
   Find the average scores of the customers.
   Uses COALESCE to replace NULL Score with 0.
*/
SELECT
    CustomerID,
    Score,
    COALESCE(Score, 0) AS Score2,
    AVG(Score) OVER () AS AvgScores,
    AVG(COALESCE(Score, 0)) OVER () AS AvgScores2
FROM salesdb.Customers;

/* ==============================================================================
   HANDLE NULL - MATHEMATICAL OPERATORS
===============================================================================*/

/* TASK 2:
   Display the full name of customers in a single field by merging their
   first and last names, and add 10 bonus points to each customer's score.
*/
SELECT
    CustomerID,
    FirstName,
    LastName,
    CONCAT(FirstName, '   ', COALESCE(LastName, '')) AS FullName,
    Score,
    COALESCE(Score, 0) + 10 AS ScoreWithBonus
FROM salesdb.Customers;

/* ==============================================================================
   HANDLE NULL - SORTING DATA
===============================================================================*/

/* TASK 3: 
   Sort the customers from lowest to highest scores,
   with NULL values appearing last.
*/


SELECT
    CustomerID,
    Score
FROM Salesdb.Customers
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END, Score;

/* ==============================================================================
   NULLIF - DIVISION BY ZERO
===============================================================================*/

/* TASK 4: 
   Find the sales price for each order by dividing sales by quantity.
   Uses NULLIF to avoid division by zero.
*/

SELECT
	orderid,
	sales,
	quantity,
    sales / quantity AS Price
FROM salesdb.orders;

/* ==============================================================================
   IS NULL - IS NOT NULL
===============================================================================*/

/* TASK 5: 
   Identify the customers who have no scores 
*/
SELECT *
FROM Salesdb.Customers
WHERE Score IS NULL;

/* TASK 6: 
   Identify the customers who have scores 
*/
SELECT *
FROM salesdb.Customers
WHERE Score IS NOT NULL;


/* ==============================================================================
   LEFT ANTI JOIN
===============================================================================*/

/* TASK 7:
   List all details for customers who have not placed any orders.
*/
SELECT
    c.*,
    o.OrderID
FROM Salesdb.Customers AS c
LEFT JOIN salesdb.Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL;

/*Alternative (Recommended): NOT EXISTS*/

SELECT
    c.*
FROM Salesdb.Customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM Salesdb.Orders AS o
    WHERE o.CustomerID = c.CustomerID
);

/* ==============================================================================
   NULLs vs EMPTY STRING vs BLANK SPACES
===============================================================================*/

/* TASK 8:
   Demonstrate differences between NULL, empty strings, and blank spaces
*/
WITH Orders (Id, Category) AS (
    SELECT 1, 'A'
    UNION ALL
    SELECT 2, NULL
    UNION ALL
    SELECT 3, ''
    UNION ALL
    SELECT 4, '  '
)
SELECT
    *,
    LENGTH(Category) AS ByteLength,
    CHAR_LENGTH(Category) AS CharLength,
    TRIM(Category) AS Policy1,
    NULLIF(TRIM(Category), '') AS Policy2,
    COALESCE(NULLIF(TRIM(Category), ''), 'unknown') AS Policy3
FROM Orders;
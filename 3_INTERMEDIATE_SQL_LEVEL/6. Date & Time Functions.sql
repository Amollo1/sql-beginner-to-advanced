/* ==============================================================================
   SQL Date & Time Functions
-------------------------------------------------------------------------------
   This script demonstrates various date and time functions in SQL.
   It covers functions such as GETDATE, DATETRUNC, DATENAME, DATEPART,
   YEAR, MONTH, DAY, EOMONTH, FORMAT, CONVERT, CAST, DATEADD, DATEDIFF,
   and ISDATE.
   
   Table of Contents:
     1.  NOW | GETDATE | Date Values
     2. Date Part Extractions (DATETRUNC, DATENAME, YEAR, MONTH, DAY, HOUR, MINUTE,SECOND)
     3. MAKEDATE
     4. LAST_DAY
     5. Date Parts
     6. FORMAT
     7. CAST
     8. DATE_ADD() / DATE_SUB() / TIMESTAMPDIFF / LAG() + DATEDIFF()
	 9. ISDATE
===============================================================================
*/

/* ==============================================================================
   GETDATE() | DATE VALUES
===============================================================================*/

/* TASK 1:
   Display OrderID, CreationTime, a hard-coded date, and the current system date.
*/
USE salesdb;

SELECT
    OrderID,
    CreationTime,
    '2025-08-20' AS HardCoded,
	NOW() AS Today
FROM salesdb.orders;

/* ==============================================================================
   DATE PART EXTRACTIONS
   (MAKEDATE, DATENAME, DATEPART, YEAR, MONTH, DAY)
===============================================================================*/

/* TASK 2:
   Extract various parts of CreationTime using DATETRUNC, DATENAME,
   YEAR, QUATER, MONTH, WEEK, WEEKDAY, DAY, HOUR, MINUTE, SECOND
*/

-- DATEPART Examples
SELECT
    OrderID,
    CreationTime,
    YEAR (CreationTime) AS YEAR,
    MONTH (CreationTime) AS MONTH,
    DAY (CreationTime) AS DAY,
    DAYOFMONTH (CreationTime) AS DAY_Number,
    DAYOFWEEK(CreationTime) DAY_OF_WK,
    DAYOFYEAR (CreationTime) YEAR_DAY_COUNT,
    HOUR (CreationTime) AS HOUR,
    MINUTE (CreationTime) AS MINUTE,
    SECOND (CreationTime) AS SECOND,
    QUARTER (CreationTime) AS QUATER_1,
    WEEK (CreationTime) AS WEEK_NUMBER,
    WEEKDAY (CreationTime) WEEK_DAY,
    WEEKOFYEAR (CreationTime) WEEK_YR,
    
    -- DATENAME Examples
    MONTHNAME (CreationTime) AS MONTH_NAME,
    DAYNAME (CreationTime) AS DAY_NAME,
    
	--  Examples
    MAKEDATE(YEAR(CreationTime), 1) AS Year_dt,
    DATE(CreationTime) AS Day_dt,
    DATE_FORMAT(CreationTime, '%Y-%m-%d %H:%i:00') AS Minute_dt
    
    FROM Salesdb.Orders;
    
    /* ==============================================================================
   MAKEDATE() DATA AGGREGATION
===============================================================================*/

/* TASK 3:
   Aggregate orders by year using MAKEDATE on CreationTime.
*/
SELECT
    CreationTime,
    COUNT(*) AS OrderCount
FROM Salesdb.Orders
GROUP BY CreationTime;

-- Month Level
SELECT
    MAKEDATE(MONTH(CreationTime), 1) AS Creation,
    COUNT(*) AS OrderCount
FROM Salesdb.Orders
GROUP BY MAKEDATE(MONTH(CreationTime), 1);

-- Year level
SELECT
    MAKEDATE(YEAR(CreationTime), 1) AS Creation,
    COUNT(*) AS OrderCount
FROM Salesdb.Orders
GROUP BY MAKEDATE(YEAR(CreationTime), 1);

 /* ==============================================================================
 LAST_DAY()
===============================================================================*/

/* TASK 4:
   Display OrderID, CreationTime, and the end-of-month date for CreationTime.
*/
SELECT
    OrderID,
    CreationTime,
    LAST_DAY(CreationTime) AS EndOfMonth
FROM Salesdb.Orders;

/* ==============================================================================
   DATE PARTS | USE CASES
===============================================================================*/

/* TASK 5:
   How many orders were placed each year?
*/
SELECT 
    YEAR(OrderDate) AS OrderYear, 
    COUNT(*) AS TotalOrders
FROM Salesdb.Orders
GROUP BY YEAR(OrderDate);

/* TASK 6:
   How many orders were placed each month?
*/
SELECT 
    MONTH(OrderDate) AS OrderYear, 
    COUNT(*) AS TotalOrders
FROM Salesdb.Orders
GROUP BY MONTH(OrderDate);

/* TASK 7:
   How many orders were placed each month (using friendly month names)?
*/
SELECT
    MONTHNAME(OrderDate) AS OrderMonth,
    COUNT(*) AS TotalOrders
FROM Salesdb.Orders
GROUP BY MONTHNAME(OrderDate);

SELECT
    MONTHNAME(OrderDate) AS OrderMonth,
    COUNT(*) AS TotalOrders
FROM Salesdb.Orders
GROUP BY MONTH(OrderDate), MONTHNAME(OrderDate)
ORDER BY MONTH(OrderDate);

SELECT *
FROM salesdb.Orders
WHERE MONTH(OrderDate) = 2;

/* ==============================================================================
   DATE_FORMAT()
===============================================================================*/

/* TASK 9:
   Format CreationTime into various string representations.
   */
   
SELECT
    OrderID,
    CreationTime,
    DATE_FORMAT(CreationTime, '%d') AS date,
    DATE_FORMAT(CreationTime, '%a') AS shortday_name,
    DATE_FORMAT(CreationTime, '%W') AS full_day,
    DATE_FORMAT(CreationTime, '%Y') AS year,
    DATE_FORMAT(CreationTime, '%m') AS month,
    DATE_FORMAT(CreationTime, '%b') AS month_name,
    DATE_FORMAT(CreationTime, '%M') AS full_month_name,
    DATE_FORMAT(CreationTime, '%H') AS hour,
    DATE_FORMAT(CreationTime, '%i') AS minute,
    DATE_FORMAT(Creationtime, '%s') AS second,
    DATE_FORMAT(CreationTime, '%p') AS AM_PM,
    DATE_FORMAT(CreationTime, '%d-%m-%Y') AS US_fomart,
    DATE_FORMAT(CreationTime, '%m-%d-%Y') AS EURO_fomart
FROM Salesdb.Orders;

/* TASK 10:
   Display CreationTime using a custom format:
   Example: Day Wed Jan Q1 2025 12:34:56 PM
*/
SELECT
    OrderID,
    CreationTime,
    CONCAT(
        'Day   ',
        DATE_FORMAT(CreationTime, '%a   %b'),
        '   Q',
        QUARTER(CreationTime),
        '    ',
        DATE_FORMAT(CreationTime, '%Y   %h:%i:%s   %p')
    ) AS CustomFormat
FROM Salesdb.Orders;

/* TASK 11:
   How many orders were placed each year, formatted by month and year (e.g., "Jan 25")?
*/
SELECT
    DATE_FORMAT(Creationtime, '%b  %Y') AS OrderDate,
    COUNT(*) AS TotalOrders
FROM salesdb.Orders
GROUP BY DATE_FORMAT(Creationtime, '%b  %Y');

SELECT
DATE_FORMAT(OrderDate, '%b  %Y') AS OrderDate,
COUNT(*) AS Total_Orders
FROM salesdb.orders
GROUP BY DATE_FORMAT(OrderDate, '%b  %Y');

/* ==============================================================================
   CAST()
===============================================================================*/

/* TASK 12:
   Demonstrate conversion using CAST.
*/
SELECT
    CAST('123' AS SIGNED) AS `String to Int CONVERT`,
    CAST('2025-08-20' AS DATE) AS `String to Date CONVERT`,
    CreationTime,
    CAST(CreationTime AS DATE) AS `Datetime to Date CONVERT`,
    DATE_FORMAT(CreationTime, '%m/%d/%Y') AS `USA Std. Style`,
    DATE_FORMAT(CreationTime, '%d.%m.%Y') AS `EURO Std. Style`
FROM Salesdb.Orders;

SELECT
    CAST('123' AS SIGNED) AS `String to Int`,
    CAST(123 AS CHAR) AS `Int to String`,
    CAST('2025-08-20' AS DATE) AS `String to Date`,
    CAST('2025-08-20' AS DATETIME) AS `String to Date time`,
    CreationTime,
    CAST(CreationTime AS DATE) AS `Datetime to Date`
FROM Salesdb.Orders;

/* ==============================================================================
   DATE_ADD() / DATE_SUB()
============================================================================== */

/* TASK 14:
   Perform date arithmetic on OrderDate.
*/
SELECT
    OrderID,
    OrderDate AS `Order Date`,
    DATE_SUB(OrderDate, INTERVAL 15 DAY) AS `Ten Days Before`,
    DATE_ADD(OrderDate, INTERVAL 6 MONTH) AS `Three Months Later`,
    DATE_ADD(OrderDate, INTERVAL 5 YEAR) AS `Two Years Later`
FROM salesdb.Orders;

/* ==============================================================================
   TIMESTAMPDIFF()
===============================================================================*/

/* TASK 15:
   Calculate the age of employees.
*/
SELECT
	EmployeeID,
	concat(firstname,'  ',lastname) AS full_name,
    BirthDate,
    TIMESTAMPDIFF(YEAR, BirthDate, CURDATE()) AS Age
FROM Salesdb.Employees;

/* ==============================================================================
   DATEDIFF()
===============================================================================*/

/* TASK 16:
   Find the average shipping duration in days for each month.
*/
SELECT
    MONTH(OrderDate) AS OrderMonth,
    AVG(DATEDIFF(ShipDate, OrderDate)) AS AvgShip
FROM Salesdb.Orders
GROUP BY MONTH(OrderDate);

SELECT
    MONTHNAME(OrderDate) AS OrderMonth,
    AVG(DATEDIFF(ShipDate, OrderDate)) AS AvgShip
FROM Salesdb.Orders
GROUP BY MONTH(OrderDate), MONTHNAME(OrderDate)
ORDER BY MONTH(OrderDate);

SELECT
    MONTH(OrderDate) AS MonthNo,
    MONTHNAME(OrderDate) AS MonthName,
    AVG(DATEDIFF(ShipDate, OrderDate)) AS AvgShip
FROM Salesdb.Orders
GROUP BY
    MONTH(OrderDate),
    MONTHNAME(OrderDate)
ORDER BY MonthNo;

SELECT
    DATE_FORMAT(OrderDate, '%b') AS OrderMonth,
    AVG(DATEDIFF(ShipDate, OrderDate)) AS AvgShip
FROM Salesdb.Orders
GROUP BY
    MONTH(OrderDate),
    DATE_FORMAT(OrderDate, '%b')
ORDER BY MONTH(OrderDate);

/* ==============================================================================
   LAG() + DATEDIFF()
===============================================================================*/

/* TASK 17:
   Time Gap Analysis: Find the number of days between each order and the previous order.
*/
SELECT
    OrderID,
    OrderDate AS Current_Order_Date,
    LAG(OrderDate) OVER (ORDER BY OrderDate) AS Previous_Order_Date,
    DATEDIFF(
        OrderDate,
        LAG(OrderDate) OVER (ORDER BY OrderDate)
    ) AS Number_Of_Days
FROM Salesdb.Orders;

/* ==============================================================================
   STR_TO_DATE() - Equivalent to ISDATE()
===============================================================================*/

/* TASK 18:
   Validate OrderDate and convert valid dates.
*/
SELECT
    OrderDate,
    CASE
        WHEN STR_TO_DATE(OrderDate, '%Y-%m-%d') IS NOT NULL THEN 1
        ELSE 0
    END AS IsValidDate,
    CASE
        WHEN STR_TO_DATE(OrderDate, '%Y-%m-%d') IS NOT NULL
            THEN STR_TO_DATE(OrderDate, '%Y-%m-%d')
        ELSE '9999-01-01'
    END AS NewOrderDate
FROM (
    SELECT '2025-08-20' AS OrderDate
    UNION ALL
    SELECT '2025-08-21'
    UNION ALL
    SELECT '2025-08-23'
    UNION ALL
    SELECT '2025-08'
) AS t;

/* ============================================================================== 
   SQL String Functions
-------------------------------------------------------------------------------
   This document provides an overview of SQL string functions, which allow 
   manipulation, transformation, and extraction of text data efficiently.

   Table of Contents:
     1. Manipulations
        - CONCAT
        - LOWER
        - UPPER
	- TRIM
	- REPLACE
     2. Calculation
        - LENGTH
     3. Substring Extraction
        - LEFT
        - RIGHT
        - SUBSTRING
=================================================================================
*/

/* ============================================================================== 
   CONCAT() - String Concatenation
=============================================================================== */

-- Concatenate first name and country into one column

SELECT
	first_name,
	country,
    CONCAT(first_name,' from ', country) AS name_country
FROM customers;

/* ============================================================================== 
   LOWER() & UPPER() - Case Transformation
=============================================================================== */

-- Convert the first name to lowercase
SELECT
	first_name,
    LOWER(first_name) AS lower_case
FROM customers;

-- Convert the first name to uppercase
SELECT
	first_name,
    UPPER(first_name) AS Upper_case
FROM customers;

/* ============================================================================== 
   TRIM() - Remove White Spaces
=============================================================================== */

--- Find customers whose first name contains leading or trailing spaces
SELECT 
    first_name,
	LENGTH(first_name) len_name,
	LENGTH(TRIM(first_name)) len_trim_name,
	LENGTH(first_name) - LEN(TRIM(first_name)) flag
FROM customers
WHERE LEN(first_name)  != LEN(TRIM(first_name));

/* ============================================================================== 
   REPLACE() - Replace or Remove old value with new one
=============================================================================== */
-- Remove dashes (-) from a phone number

SELECT '123-456-7890' AS phone_number,
REPLACE('123-456-7890', '-', '/') AS clean_phone_number;

-- Replace File Extence from txt to csv
SELECT
'report.txt' AS old_filename,
REPLACE('report.txt', '.txt', '.csv') AS new_filename;

/* ============================================================================== 
   LEN() - String Length & Trimming
=============================================================================== */

-- Calculate the length of each customer's first name
SELECT 
    first_name, 
    LENGTH(first_name) AS name_length
FROM customers;

/* ============================================================================== 
   LEFT() & RIGHT() - Substring Extraction
=============================================================================== */

-- Retrieve the first two characters of each first name
SELECT 
    first_name,
    LEFT(TRIM(first_name), 2) AS the_first_2_chars
FROM customers;

-- Retrieve the last three characters of each first name
SELECT 
    first_name,
    RIGHT(first_name, 3) AS last_2_chars
FROM customers;

/* ============================================================================== 
   SUBSTRING() - Extracting Substrings
=============================================================================== */

-- Retrieve a list of customers' first names after removing the first character
SELECT 
    first_name,
    SUBSTRING(TRIM(first_name), 2, LENGTH(first_name)) AS trimmed_name
FROM customers;

/* ==============================================================================
   NESTING FUNCTIONS
===============================================================================*/

-- Nesting
SELECT
first_name, 
UPPER(LOWER(first_name)) AS nesting
FROM customers;




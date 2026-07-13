/* ==============================================================================
   SQL Data Manipulation Language (DML)
-------------------------------------------------------------------------------
   This guide covers the essential DML commands used for inserting, updating, 
   and deleting data in database tables.

   Table of Contents:
     1. INSERT - This adds data to tables
     2. UPDATE - This modifies existing data
     3. DELETE - This removes data from table
=================================================================================
*/

/* ============================================================================== 
   INSERT
=============================================================================== */
/* #1 Method: Manual INSERT using VALUES */
-- Insert new records into the customers table

select *
from
customers;

INSERT INTO customers (id, first_name, country, score)
VALUES 
    (6, 'Otieno', 'Kenya', NULL),
    (7, 'Mandla', NULL, 200);
    
select *
from
customers;

-- Incorrect column order 
INSERT INTO customers (id, first_name, country, score)
VALUES 
    (8, 'Max', 'Kenya', NULL);
    
select *
from
customers;
    
    -- Incorrect data type in values
INSERT INTO customers (id, first_name, country, score)
VALUES 
	('Tom', 9, 'Tom', NULL);


-- Insert a new record with full column values
INSERT INTO customers (id, first_name, country, score)
VALUES (8, 'Omari', 'Somali', 368);

select *
from
customers;

-- Insert a new record without specifying column names (this is not recommended)
INSERT INTO customers 
VALUES 
    (9, 'Andreas', 'Germany', NULL);
    
select *
from
customers;

-- Insert a record with only id and first_name (other columns will be NULL or default values)
INSERT INTO customers (id, first_name)
VALUES 
    (10, 'Agwati');

select *
from
customers;

-- Insert a record with only id and first_name (other columns will be NULL or default values)
INSERT INTO customers (id, first_name, score)
VALUES 
    (11, 'Agwati', 450);
    
select *
from
customers;

/* Create a new table called persons 
   with columns: id, person_name, birth_date, and phone */
CREATE TABLE persons (
    id INT NOT NULL,
    person_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    phone VARCHAR(15) NOT NULL,
    CONSTRAINT pk_persons PRIMARY KEY (id);
)

 #2 Method: INSERT DATA USING SELECT - Moving Data From One Table to Another */
-- Copy data from the 'customers' table into 'persons'

INSERT INTO persons (id, person_name, birth_date, phone)
SELECT
    id,
    first_name,
    NULL,
    'Unknown'
FROM customers
   
select *
from
persons;

select *
from
customers;

/* ============================================================================== 
   UPDATE
=============================================================================== */

-- Change the score of customer with ID 6 to 0
UPDATE customers
SET score = 0
WHERE id = 6;

select *
from
customers;

-- Change the score of customer with ID 10 to 0 and update the country to 'UK'
UPDATE customers
SET score = 0,
    country = 'United Kindom'
WHERE id = 10;

select *
from
customers;

-- Update all customers with a NULL score by setting their score to 0

select *
from
customers
where score IS NULL;

SET SQL_SAFE_UPDATES = 0;

UPDATE customers
SET score = 0
WHERE score IS NULL; 

-- Verify the update
SELECT *
FROM customers;

SET SQL_SAFE_UPDATES = 1;

/* ============================================================================== 
   DELETE
=============================================================================== */

-- Select customers with an ID greater than 5 before deleting

SELECT *
FROM customers
WHERE id > 5;

-- Delete all customers with an ID greater than 5
DELETE FROM customers
WHERE id > 5;

SELECT *
FROM customers;

-- Delete all data from the persons table
DELETE FROM persons;

-- Faster method to delete all rows, especially useful for large tables
TRUNCATE TABLE persons;

select *
from persons


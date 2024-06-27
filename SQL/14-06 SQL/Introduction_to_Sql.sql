--SQL (Structured Query Language) is a standard language used to manage and manipulate relational databases. 
/*
DATE: Stores date values (year, month, day).
Syntax: column_name DATE

TIME: Stores time values (hour, minute, second).
Syntax: column_name TIME

DATETIME: Stores both date and time values.
Syntax: column_name DATETIME

TIMESTAMP: Stores both date and time values, typically with time zone.
Syntax: column_name TIMESTAMP

YEAR: Stores a year value.
Syntax: column_name YEAR

INT / INTEGER: Used to store whole numbers.
Syntax: column_name INT

DECIMAL / NUMERIC: Used to store fixed-point numbers.
Syntax: column_name DECIMAL(k, no of digits after decimal)

SMALLINT: Stores small-range integer values.
Syntax: column_name SMALLINT

BIGINT: Stores large-range integer values.
Syntax: column_name BIGINT

 STRING DATATYPES
1) CHAR 
2) VARCHAR
3) TEXT
*/

-- CREATE command is used to create a new table or database
create database bootcamp;

-- creating a products table

CREATE TABLE products (
  pid INT,
  pname VARCHAR(50),
  price INT(10),
  stock INT,
  location VARCHAR(50)
);

-- DROP commands deletes database or a table

-- to delete a table 
drop table table_name;

-- to delete a database
drop database db_name;

-- ALTER command is used to modify an existing database object.

-- Adding a column to a table
ALTER TABLE products
ADD rating int(2);

-- Modifying table
ALTER TABLE products
MODIFY COLUMN rating DECIMAL(2, 2)

INSERT INTO products (pid, pname, price, stock, location)
VALUES (1, 'Product A', 100, 50, 'Location 1');

INSERT INTO products (pid, pname, price, stock, location)
VALUES (2, 'Product B', 150, 30, 'Location 2');

INSERT INTO products (pid, pname, price, stock, location)
VALUES (3, 'Product C', 200, 20, 'Location 3');


-- TRUNCATE -->This command removes all rows from a table. 
-- It's faster than DELETE for large tables.
-- TRUNCATE TABLE table_name;
TRUNCATE TABLE products;

/*
CONSTRAINTS
NOT NULL - Ensures that a column cannot have a NULL value
UNIQUE - Ensures that all values in a column are different
PRIMARY KEY - A combination of a NOT NULL and UNIQUE. Uniquely identifies each row in a table
FOREIGN KEY - Prevents actions that would destroy links between tables
CHECK - Ensures that the values in a column satisfies a specific condition
DEFAULT - Sets a default value for a column if no value is specified
*/

CREATE TABLE products (
  pid INT,
  pname VARCHAR(50),
  price INT DEFAULT 0,  -- default price is 0
  stock INT CHECK (stock >= 0),  -- stock cannot be negative
  location VARCHAR(50) DEFAULT 'Unknown'  -- default location is 'Unknown'
);

/*
 Data Manipulation Language (DML) commands are used to retrieve, insert, update, and delete data in a database. 
DML commands are essential for managing data within tables. 

SELECT: Retrieves data from the database.
INSERT: Adds new records to a table.
UPDATE: Modifies existing records in a table.
DELETE: Removes records from a table.
*/

/* 1. SELECT
The SELECT command is used to retrieve data from one or more tables.*/

-- Retrieve all columns for all products
SELECT * FROM products;

-- Retrieve specific columns
SELECT pname, price FROM products;

-- Retrieve products with a price greater than 50
SELECT * FROM products WHERE price > 50;

-- Retrieve products sorted by price in descending order
SELECT * FROM products ORDER BY price DESC;

/* The INSERT command is used to add new rows to a table.*/

--  By using  column names
INSERT INTO products (pid, pname, price, stock, location)
VALUES (1, 'Product A', 100, 50, 'Location 1');

INSERT INTO products (pid, pname, price, stock, location)
VALUES (2, 'Product B', 150, 30, 'Location 2');

INSERT INTO products (pid, pname, price, stock, location)
VALUES (3, 'Product C', 200, 20, 'Location 3');

-- By using existing column order
INSERT INTO products
VALUES (4, 'Product D', 250, 40, 'Location 4');

INSERT INTO products
VALUES (5, 'Product E', 300, 60, 'Location 5');

INSERT INTO products
VALUES (6, 'Product F', 350, 25, 'Location 6');

/* The UPDATE command is used to modify existing rows in a table.*/

-- Update the price and stock of a specific product
UPDATE products
SET price = 120, stock = 60
WHERE pid = 1;

-- Update the location of all products to 'Warehouse 2'
UPDATE products
SET location = 'Warehouse 2';

/* The DELETE command Removes records from a table.*/

-- Delete a specific product
DELETE FROM products
WHERE pid = 1;

-- Delete all products with a price less than 50
DELETE FROM products
WHERE price < 50;

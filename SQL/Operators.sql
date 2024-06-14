--SQL operators are special characters or keywords used to perform operations on values. 

/* They can be categorized into several types: 
arithmetic 
comparison 
logical
bitwise
*/

/* 
1. Arithmetic Operators
Arithmetic operators are used to perform mathematical operations on numerical data

Addition (+): Adds two numbers.
Subtraction (-): Subtracts the second number from the first.
Multiplication (*): Multiplies two numbers.
Division (/): Divides the first number by the second.
Modulo (%): Returns the remainder of the division.
*/

CREATE TABLE products (
  pid INT,
  pname VARCHAR(50),
  price INT(10),
  stock INT,
  location VARCHAR(50)
);

INSERT INTO products (pid, pname, price, stock, location)
VALUES (1, 'Product A', 100, 50, 'Location 1');

INSERT INTO products (pid, pname, price, stock, location)
VALUES (2, 'Product B', 150, 30, 'Location 2');

INSERT INTO products (pid, pname, price, stock, location)
VALUES (3, 'Product C', 200, 20, 'Location 3');

-- Add 10 to the price of all products
SELECT pid, pname, price, price + 10 AS new_price
FROM products;

-- Subtract 5 from the stock of all products
SELECT pid, pname, stock, stock - 5 AS new_stock
FROM products;

-- Calculate the total value (price * stock) of all products
SELECT pid, pname, price, stock, price * stock AS total_value
FROM products;

/* 
2.Comparison Operators
Comparison operators are used to compare two values. They return a boolean value (TRUE or FALSE).

Equal to (=): Checks if two values are equal.
Not equal to (!= or < >): Checks if two values are not equal.
Greater than (>): Checks if the left value is greater than the right.
Less than (<): Checks if the left value is less than the right.
Greater than or equal to (>=): Checks if the left value is greater than or equal to the right.
Less than or equal to (<=): Checks if the left value is less than or equal to the right.
*/

-- Select products with a price equal to 100
SELECT * FROM products
WHERE price = 100;

-- Select products with a stock not equal to 0
SELECT * FROM products
WHERE stock != 0;

-- Select products with a price greater than 50
SELECT * FROM products
WHERE price > 50;

-- Select products with a stock less than 100
SELECT * FROM products
WHERE stock < 100;

-- Select products with a price greater than or equal to 40
SELECT * FROM products
WHERE price >= 40;

-- Select products with a price less than or equal to 40
SELECT * FROM products
WHERE price <= 40;

/* 
3.Logical Operators
Logical operators are used to combine multiple conditions in a WHERE clause.

AND: Returns TRUE if all conditions are TRUE.
OR: Returns TRUE if any condition is TRUE.
NOT: Reverses the boolean value of a condition.
*/

-- Select products with a price greater than 50 and stock greater than 20
SELECT * FROM products
WHERE price > 50 AND stock > 20;

-- Select products with a price less than 50 or stock greater than 50
SELECT * FROM products
WHERE price < 50 OR stock > 50;

-- Select products with a price not equal to 100
SELECT * FROM products
WHERE NOT price = 100;

/* 
4.Bitwise operator

AND (&): Performs a bitwise AND operation.
OR (|): Performs a bitwise OR operation.
XOR (^): Performs a bitwise XOR operation.
NOT (~): Performs a bitwise NOT operation (also known as a bitwise complement).
Shift Left (<<): Shifts bits to the left.
Shift Right (>>): Shifts bits to the right.
*/

-- bitwise OR on the price column
SELECT pid, pname, price, price | 1 AS bitwise_or_result
FROM products;

--  bitwise NOT on the price column
SELECT pid, pname, price, ~price AS bitwise_not_result
FROM products;

--  bitwise XOR on the price column
SELECT pid, pname, price, price ^ 1 AS bitwise_xor_result
FROM products;

--  bitwise shift left on the price column
SELECT pid, pname, price, price << 1 AS shift_left_result
FROM products;

--  bitwise shift right on the price column
SELECT pid, pname, price, price >> 1 AS shift_right_result
FROM products;

/* 
The price << 1 operation shifts the bits of price to the left by one position, 
effectively multiplying price by 2.
The price >> 1 operation shifts the bits of price to the right by one position, 
effectively dividing price by 2.
*/

/* 
BETWEEN: Checks if a value is within a range.
IN: Checks if a value matches any value in a list.
LIKE: Searches for a specified pattern in a column.
IS NULL: Checks if a value is NULL.
*/

-- Select products with a price between 50 and 150
SELECT * FROM products
WHERE price BETWEEN 50 AND 150;

-- Select products with a location in the specified list
SELECT * FROM products
WHERE location IN ('Warehouse 1', 'Warehouse 2');

-- Select products with a name starting with 'Product'
SELECT * FROM products
WHERE pname LIKE 'Product%';

-- Select products with a NULL location
SELECT * FROM products
WHERE location IS NULL;

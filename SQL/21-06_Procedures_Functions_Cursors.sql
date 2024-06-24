-- DELIMITER COMMAND:
-- 1. Purpose: The DELIMITER command is used to change the standard delimiter (like a semicolon (;)), to a different character.
-- 2. Usage: When defining stored procedures, functions, or other multi-statement constructs that contain semicolons within their body.
-- 3. Syntax: DELIMITER new_delimiter;
-- 4. Example:
--    DELIMITER //
--    CREATE PROCEDURE procedure_name()
--    BEGIN
--        SQL statements
--    END //
--    DELIMITER ;

-- DETERMINISTIC:
-- DETERMINISTIC indicates that the function will always return the same result for the same input values.
-- If the function contains any non-deterministic elements (e.g., calls to functions that return different values each time they are called), you should omit this keyword.


-- PROCEDURES 
--  A procedure is a set of SQL statements that can be saved and reused.
  
-- CREATING A PROCEDURE
-- Procedure to fetch all restaurant details
DELIMITER //
CREATE PROCEDURE get_all_restaurants()
BEGIN
    SELECT * FROM restaurants;
END //
DELIMITER ;
--Explanation:This procedure get_all_restaurants is created to fetch all restaurant details (SELECT * FROM restaurants).

--EXECUTING A PROCEDURE:Once a procedure is defined, you can execute it to perform its defined task.

CALL get_all_restaurants();
--Explanation:This statement calls the get_all_restaurants procedure, which retrieves all restaurant information from the restaurants table.

--DROPPING A PROCEDURE :If a procedure is no longer needed, you can drop it from the database.

DROP PROCEDURE get_all_restaurants;
--Explanation:This statement removes the get_all_restaurants procedure from the database.

-- IN
/* 
This In is a  part of procedures
IN parameters in MySQL stored procedures allow you to pass values into the procedure.
These values are read-only within the procedure and cannot be modified
 */
 
/* 
~ Syntax for IN
 CREATE PROCEDURE procedure_name(IN parameter_name data_type)
 BEGIN
    -- Procedure logic using parameter_name
    END;
*/

-- Creating procedure with IN
DELIMITER //
CREATE PROCEDURE get_product_details(IN product_id INT)
BEGIN
    SELECT * FROM products WHERE pid = product_id;
END //

/*
EXPLANATION:
product_id is the IN parameter.
INT is the data type of the parameter.
*/

-- Calling Procedure
CALL get_product_details(1);
-- This will retrieve details for the product with ID 1.

/* 
EXPLANATION:
-> CREATE PROCEDURE get_product_details(IN product_id INT): This statement defines a procedure named get_product_details
with an IN parameter product_id of type INT.
-> BEGIN and END: These keywords mark the beginning and end of the procedure's body, respectively.
-> SELECT * FROM products WHERE pid = product_id;: This is the SQL query inside the procedure that selects product details
based on the product_id parameter.
-> CALL get_product_details(3); This statement calls the procedure get_product_details with the argument 3, 
which is the product ID to retrieve details for.
*/



-- OUT
/* 
This OUT is a  part of procedures
 OUT  OUT parameters in MySQL stored procedures allow you to return values from a procedure. 
These values can be accessed by the calling program after the procedure execution. 
*/

/* 
~ Syntax
 CREATE PROCEDURE procedure_name(OUT parameter_name data_type)
 BEGIN
    -- Procedure logic using parameter_name
 END;
*/

-- Create the procedure to get product count using OUT
DELIMITER //
CREATE PROCEDURE get_product_count(OUT product_count INT)
BEGIN
    SELECT COUNT(*) INTO product_count FROM products;
END //
/*
EXPLANATION:
product_count is the OUT parameter.
INT is the data type of the parameter.
*/

-- Calling the OUT Procedure
CALL get_product_count(@product_count);
SELECT @product_count as product_count;
/*
call -> Using @product_count to store the result
select-> Accessing the variable using @product_count
*/


/*
EXPLANATION:
-> CREATE PROCEDURE get_product_count(OUT product_count INT): This statement defines a procedure named get_product_count with an
 OUT parameter product_count of type INT.
-> BEGIN and END: These keywords mark the beginning and end of the procedures body, respectively.
-> SELECT COUNT(*) INTO product_count FROM products;: This is the SQL query inside the procedure that calculates the 
total number of products and stores it in the product_count variable.
-> CALL get_product_count(@count);: This statement calls the procedure get_product_count and 
passes the OUT parameter. The result is stored in the variable @count.
*/


-- FUNCTIONS
/*
A function is a reusable block of code that performs a specific task and can return a value.
Functions are similar to procedures, but procedures do not return values.
Functions can have input parameters (IN) but cannot have output parameters.
Input parameters allow you to pass data into the function, and the function can use that data to perform its task.
*/

/*
 FUNCTION CREATION:

 To create a function, you need to define its name, input parameters (if any), and the data type of the value it returns.
The function logic (the code that performs the task) goes inside the BEGIN and END blocks.
 Syntax:
CREATE FUNCTION function_name(parameter1 data_type, parameter2 data_type, ...)
RETURNS return_data_type
AS
BEGIN
     -- Function logic here
 END;
 */

--1. Creating a Function
--Functions in SQL return a single value based on the input parameters provided.

-- Function to calculate total number of orders

DELIMITER $$
CREATE FUNCTION calculate_total_orders()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_orders INT;
    SELECT COUNT(*) INTO total_orders FROM orders;
    RETURN total_orders;
END$$
DELIMITER ;

--Explanation: This function calculate_total_orders calculates the total number of orders (SELECT COUNT(*) FROM orders) and returns that count.

--2. Executing a Function
--You can execute a function within a SQL query to retrieve its computed value.

SELECT calculate_total_orders();

--Explanation:This statement calls the calculate_total_orders function and retrieves the total number of orders.

3. Dropping a Function
--To remove a function from the database when it's no longer needed.

DROP FUNCTION IF EXISTS calculate_total_orders;

--Explanation:This statement deletes the calculate_total_orders function, if it exists, from the database.

-- CURSOR:
-- 1. Purpose:
--    - Cursors in SQL are used to retrieve and process rows one by one from the result set of a query.
-- 2. Declaration:
--    - Cursors are declared using the DECLARE CURSOR statement, specifying the SELECT query whose result set will be processed.
-- 3. Opening:
--    - A cursor must be opened using the OPEN statement before fetching rows.
--    - Opening a cursor positions the cursor before the first row.
-- 4. Fetching:
--    - Rows from the result set are fetched one by one using the FETCH statement.
--    - Each fetch operation advances the cursor to the next row in the result set.
-- 5. Closing:
--    - After processing all rows, the cursor should be closed using the CLOSE statement.
--    - Closing a cursor releases the resources associated with the result set and frees memory.

-- Syntax:
-- DECLARE cursor_name CURSOR FOR
-- SELECT column1, column2, ... 
-- FROM table_name 
-- WHERE condition;
-- OPEN cursor_name;
-- FETCH cursor_name INTO variable1, variable2, ...;
-- WHILE (condition) DO
--    -- Process fetched row here
--    -- Use fetched values stored in variables
--    FETCH cursor_name INTO variable1, variable2, ...;
-- END WHILE;
-- CLOSE cursor_name;

--1. Declaring and Using a cursor==> Cursors in SQL allow you to iterate through a result set row by row.
-- Procedure to print names of all restaurants
DELIMITER //
CREATE PROCEDURE print_restaurant_names()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE restaurant_name VARCHAR(100);
    DECLARE restaurant_cursor CURSOR FOR SELECT name FROM restaurants;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN restaurant_cursor;

    read_names: LOOP
        FETCH restaurant_cursor INTO restaurant_name;
        IF done THEN
            LEAVE read_names;
        END IF;
        SELECT restaurant_name;
    END LOOP read_names;

    CLOSE restaurant_cursor;
END //
DELIMITER ;
/*Explanation:

This procedure print_restaurant_names declares a cursor restaurant_cursor to fetch restaurant names (SELECT name FROM restaurants).
It then iterates through each restaurant name fetched using a LOOP.
FETCH restaurant_cursor INTO restaurant_name; retrieves the current restaurant name into restaurant_name.
SELECT restaurant_name; displays each restaurant name in the result.
*/

-- Executing the Cursor Procedure ==> To execute the procedure and display restaurant names.

CALL print_restaurant_names();
Explanation:

--This statement calls the print_restaurant_names procedure, which prints all restaurant names stored in the restaurants table.

-- User-Defined Cursors:
-- 1. Purpose:
--    - User-defined cursors are declared by the user to process rows retrieved from a query result set.
--    - They are particularly useful when you need to perform custom operations on individual rows.
-- 2. Declaration:
--    - User-defined cursors are declared using the DECLARE CURSOR statement, specifying the SELECT query whose result set will be processed.
--    - This allows the user to define custom logic for fetching and processing rows.
-- 3. Opening, Fetching, and Closing:
--    - User-defined cursors follow a similar process of opening, fetching, and closing as predefined cursors.
--    - After declaring and opening the cursor, the user fetches rows one by one and processes them as needed.
--    - Finally, the cursor is closed to release resources.

-- EXAMPLE:
-- To calculate the number of users
DELIMITER //
DECLARE @user_count INT;
SELECT @user_count = COUNT(*)
FROM customer;
PRINT 'Number of users: ' + CAST(@user_count AS VARCHAR(10));
DELIMITER ;

-- Pre-defined Cursors:
-- 1. Purpose:
--    - Predefined cursors are system-defined cursors provided by the DBMS.
--    - They are often associated with built-in functions or stored procedures that return result sets.
-- 2. Usage:
--    - Predefined cursors are commonly used with predefined functions or procedures to process result sets returned by these functions.
--    - Examples of predefined cursors include cursors used with aggregate functions like COUNT(), SUM(), etc.
-- 3. Fetching:
--    - The process of fetching rows from predefined cursors is similar to user-defined cursors.
--    - The cursor is opened, rows are fetched and processed, and the cursor is closed to release resources.

-- Function to calculate total number of orders using a predefined cursor
DELIMITER //
CREATE FUNCTION calculate_total_orders()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_orders INT;
    SELECT COUNT(*) INTO total_orders FROM orders;
    RETURN total_orders;
END$$
DELIMITER ;
--Explanation:This function calculate_total_orders calculates the total number of orders (SELECT COUNT(*) FROM orders) using a predefined cursor.


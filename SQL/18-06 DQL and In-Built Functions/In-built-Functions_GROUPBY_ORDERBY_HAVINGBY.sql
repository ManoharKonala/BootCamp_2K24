-- GROUPBY,HAVINGBY,ORDERBY

-- GROUP BY

/* 
The GROUP BY Statement in SQL is used to arrange identical data into groups with the help of some functions. 
if a particular column has the same values in different rows then it will arrange these rows in a group. 

SELECT column1, aggregate_function(column2)
FROM table_name
GROUP BY column1;
*/

-- Count Employees by Department

SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department;

-- to know max and min priced food item

SELECT food_id, MAX(price) AS max_sales, MIN(price) AS min_sales
FROM food_item
GROUP BY food_id;

-- ORDER BY

/*
 The ORDER BY clause sorts the result set by one or more columns, either in ascending (default) or descending order.
SELECT column1, column2, ...
FROM table_name
ORDER BY column1 [ASC|DESC], column2 [ASC|DESC], ...;
*/

SELECT food_name, price
FROM food_item
ORDER BY price DESC, food_name ASC;

--the ORDER BY clause sorts the results first by price in descending order and then by food_name in ascending order.

--Combining GROUP BY and ORDER BY
-- You can use both GROUP BY and ORDER BY in the same query to first group the data and then sort the grouped results.

SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department
ORDER BY employee_count DESC;

--This query groups employees by department and then sorts the departments by the number of employees in descending order.

-- HAVINGBY

/*
The HAVING clause in SQL is used to filter groups of rows created by the GROUP BY clause. 
While the WHERE clause is used to filter rows before grouping, the HAVING clause is used to filter groups after the aggregation has been performed.

SELECT column1, aggregate_function(column2)
FROM table_name
GROUP BY column1
HAVING condition;
*/

SELECT Fid, F_name, price
FROM Menu
GROUP BY Fid, F_name, price
HAVING price < 100;

-- restaurants with rating above 4.5, ordered by restaurant name

SELECT Restaurant, MAX(Rating) AS max_rating
FROM Restaurants
GROUP BY Restaurant
HAVING MAX(Rating) > 4.5
ORDER BY Restaurant ASC;

-- IN-BUILT-FUNCTIONS

--AGGREGATE FUNCTIONS

--1.COUNT(): Returns the number of rows.
SELECT COUNT(*) AS total_restaurants FROM restaurants;

--2.SUM(): Returns the total sum of a numeric column.
SELECT SUM(total_orders) AS total_orders_all_restaurants FROM orders;

--3.AVG(): Returns the average value of a numeric column.
SELECT AVG(rating) AS average_rating FROM reviews;

--4.MIN(): Returns the minimum value of a column.
SELECT MIN(price) AS lowest_price FROM menu_items;

--5.MAX(): Returns the maximum value of a column.
SELECT MAX(price) AS highest_price FROM menu_items;

--6.ROUND(number, decimals): rounds a number to a specified number of decimal places. 
-- If decimals is not mentioned then the number gets rounded to nearest integer.
SELECT ROUND(2.1446, 2) AS result; -- Output: 2.14
SELECT ROUND(2.3434334) AS result; -- Output: 2

-- 7.POW(base, exponent): base raised to the power of exponent.
SELECT POW(16, 2) AS result;
-- Output: 256

-- 8.ABS(): Returns the absolute value of a number.
SELECT ABS(price_change) AS absolute_price_change FROM menu_items_price_changes;

/* String Functions
String functions perform operations on string (text) data types.
*/

--UPPER(): Converts a string to uppercase.
SELECT UPPER(restaurant_name) AS uppercase_name FROM restaurants;

--LOWER(): Converts a string to lowercase.
SELECT LOWER(restaurant_name) AS lowercase_name FROM restaurants;

--CONCAT(): Concatenates two or more strings.
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM users;

--SUBSTRING((str, start, length)): Extracts a substring from a string.
SELECT SUBSTRING(description, 1, 50) AS short_description FROM menu_items;

--LENGTH(): Returns the length of a string.
SELECT LENGTH(restaurant_name) AS name_length FROM restaurants;

--CHAR_LENGTH(str): This function returns the length of the given string str in characters.
SELECT CHAR_LENGTH('EDA,MONE');

-- ASCII(str): This function returns the ASCII code value of the leftmost character in the string str.
SELECT ASCII('A');
SELECT ASCII('abc');


--Date and Time Functions
--Date and time functions perform operations on date and time data types.

--CURRENT_DATE(): Returns the current date.
SELECT CURRENT_DATE() AS today_date;

--CURRENT_TIME(): Returns the current time.
SELECT CURRENT_TIME() AS current_time;

--DATE_ADD(): Adds a specified time interval to a date.
SELECT DATE_ADD(order_date, INTERVAL 7 DAY) AS delivery_due_date FROM orders;

--DATE_SUB(): Subtracts a specified time interval from a date.
SELECT DATE_SUB(order_date, INTERVAL 1 MONTH) AS one_month_before_order FROM orders;

--DATEDIFF(): Returns the difference in days between two dates.
SELECT DATEDIFF(CURRENT_DATE(), registration_date) AS days_since_registration FROM users;

--SYSDATE(): This function returns the current date and time as a value in the format 'YYYY-MM-DD HH:MM:SS'.
SELECT SYSDATE() AS `Timestamp`;

--LAST_DAY(date): This function returns the last day of the month for a given date.
SELECT LAST_DAY('2024-06-01') AS last_day_of_june;


-- DQL 

-- DQL -> Data Query Language

--DQL is used to fetch the data from the database.

-- There is only one DQL command in SQL i.e. select
 /* SELECT

It is used to retrieve data from the database

SYNTAX: 
SELECT column1, column2, ...FROM table_name<br>WHERE condition;

*/


--  SELECT With DISTINCT Clause
-- The DISTINCT Clause after SELECT eliminates duplicate rows from the result set.
SELECT DISTINCT cname,addr FROM customer;

--  SELECT all columns(*)
SELECT * FROM Restaurants;

-- SELECT by column name
SELECT restaurant_id FROM Restaurants;

--  SELECT with LIKE(%)

-- % (percent sign): Represents zero, one, or multiple characters.
-- _ (underscore): Represents a single character.

-- Find All Restaurants with  Names Starting with 'S':

SELECT Restaurant_name
FROM Restaurants
WHERE Restaurant_name LIKE 'S%';

-- Find All Restaurant with  Names Ending in 'a':

SELECT Restaurant_name
FROM Restaurants
WHERE Restaurant_name LIKE '%a';

-- Find All Employees with 'grand' Anywhere in Their Last Name:
SELECT Restaurant_name
FROM Restaurants
WHERE Restaurant_name LIKE '%grand%';

--Find all food_name that have 'chicken' in their name:
SELECT food_name, price
FROM food_item
WHERE food_name LIKE '%chicken%';

-- Find all user_name which have four letters:
SELECT user_name
FROM User
WHERE user_name LIKE '____';


--  SELECT with CASE or IF
--  CASE

SELECT 
    food_name, 
    quantity, 
    CASE 
        WHEN quantity = 0 THEN 'Out of Food'
        WHEN quantity > 0 AND quantity <= 20 THEN 'Low Food Item'
        ELSE 'In Stock'
    END AS quantity_status
FROM food_item;

-- b) IF
SELECT 
    first_name, 
    last_name, 
    salary, 
    IF(salary < 30000, 'Low', 
        IF(salary < 60000, 'Medium', 'High')) AS salary_category
FROM employees;

-- F) SELECT with a LIMIT Clause
SELECT * 
FROM food_item
ORDER BY price
LIMIT 2;

-- G) SELECT with WHERE

-- To retrieve the menu for a specific restaurant:
SELECT fi.food_name, rfp.price
FROM food_Item fi
JOIN restaurant_food_price rfp ON fi.food_id = rfp.food_id
WHERE rfp.restaurant_id = 4;
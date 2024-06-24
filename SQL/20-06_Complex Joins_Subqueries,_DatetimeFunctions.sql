CREATE DATABASE IF NOT EXISTS zomato_clone;
USE zomato_clone;

-- Create Users table
CREATE TABLE IF NOT EXISTS Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    other_profile_info TEXT
);

INSERT INTO Users (username, password, email, other_profile_info) VALUES
('Sri', 'password123', 'sri@gmail.com', 'Loves Italian food'),
('Teju', 'password456', 'teju@gmail.com', 'Vegetarian'),
('Manohari', 'password789', 'manuu@gamil.com', 'Enjoys spicy food'),
('Ramanii', 'password901', 'ramanii@gmail.com', 'Non- veg lover'),
('Akshitha', 'password321', 'akshitha@gmail.com' , 'Non- spicy food only'),
('Vikram', 'password234', 'vikram@gmail.com', 'Prefers vegan food'),
('Suman', 'password567', 'suman@yahoo.com', 'Loves street food'),
('Nithya', 'password890', 'nithya@hotmail.com', 'Enjoys gourmet cuisine'),
('Karthik', 'password112', 'karthik@gmail.com', 'Gluten-free diet'),
('Anjali', 'password334', 'anjali@gmail.com', 'Prefers organic food'),
('Rajesh', 'password556', 'rajesh@gmail.com', 'Loves fast food'),
('Pooja', 'password778', 'pooja@gmail.com', 'Sugar-free diet'),
('Arjun', 'password990', 'arjun@gmail.com', 'Enjoys Mediterranean food'),
('Sneha', 'password1234', 'sneha@gmail.com', 'Prefers raw food diet'),
('Ravi', 'password5678', 'ravi@gmail.com', 'Loves seafood');


SELECT * From Users;
-- Create Restaurants table
CREATE TABLE IF NOT EXISTS Restaurants (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    cuisine VARCHAR(50),
    rating DECIMAL(3, 2),
    other_info TEXT
);

INSERT INTO Restaurants (name, location, cuisine, rating, other_info) VALUES

('Paradise', 'Hyderabad', 'Non-veg', 4.6, 'Renowned for biryani'),
('Rasoi Ghar', 'Mumbai', 'Vegetarian', 4.7, 'Authentic Gujarati thali'),
('Coastal Spice', 'Chennai', 'Indian', 4.3, 'Specializes in coastal cuisine'),
('Spice Symphony', 'Delhi', 'Non-veg', 4.8, 'Known for butter chicken'),
('Urban Tadka', 'Pune', 'veg and non-veg', 4.5, 'Fusion cuisine with a modern twist'),
('Saffron', 'Kolkata', 'Indian', 4.4, 'Bengali delicacies'),
('Tandoori Flames', 'Ahmedabad', 'Non-veg', 4.6, 'Delicious kebabs and tikkas'),
('Green Leaf', 'Coimbatore', 'Vegetarian', 4.7, 'Organic and farm-fresh dishes'),
('Royal Feast', 'Jaipur', 'Indian', 4.5, 'Rajasthani royal cuisine'),
('Blue Bay', 'Goa', 'veg and non-veg', 4.8, 'Seafood and beachside dining');


SELECT * From Restaurants;
-- Create Menus table
CREATE TABLE IF NOT EXISTS Menus (
    menu_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT,
    item_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id) ON DELETE CASCADE
);

INSERT INTO Menus (restaurant_id, item_name, price, description) VALUES

(1, 'Mutton Rogan Josh', 180, 'Tender mutton cooked in aromatic spices.'),
(2, 'Mixed Vegetable Curry', 130, 'A delightful medley of seasonal vegetables.'),
(3, 'Fish Fry', 150, 'Crispy fried fish with a tangy dip.'),
(4, 'Butter Chicken', 200, 'Creamy and rich butter chicken.'),
(5, 'Egg Biryani', 140, 'Delicious biryani with boiled eggs.'),
(1, 'Haleem', 220, 'A rich and savory meat and lentil stew.'),
(2, 'Aloo Gobi', 90, 'Classic potato and cauliflower curry.'),
(3, 'Dal Makhani', 110, 'Creamy black lentils cooked with butter.'),
(4, 'Mutton Biryani', 300, 'Flavorful and aromatic mutton biryani.'),
(5, 'Prawn Curry', 250, 'Succulent prawns in a spicy coconut curry.'),
(1, 'Tandoori Chicken', 180, 'Juicy chicken marinated in yogurt and spices.'),
(2, 'Palak Paneer', 150, 'Creamy spinach with cubes of paneer.'),
(3, 'Hyderabadi Biryani', 220, 'Spicy and flavorful Hyderabadi biryani.'),
(4, 'Keema Naan', 130, 'Naan stuffed with minced meat.'),
(5, 'Chicken Tikka Masala', 200, 'Grilled chicken in a rich tomato sauce.'),
(1, 'Chicken 65', 160, 'Spicy, deep-fried chicken bites.'),
(2, 'Rajma Chawal', 120, 'Kidney beans curry with rice.'),
(3, 'Lamb Vindaloo', 180, 'Spicy and tangy lamb curry.'),
(4, 'Fish Curry', 220, 'Fish cooked in a coconut milk-based curry.'),
(5, 'Chole Bhature', 140, 'Spicy chickpeas with fried bread.'),
(1, 'Vegetable Samosa', 50, 'Crispy pastry filled with spiced potatoes and peas.'),
(2, 'Bhindi Masala', 130, 'Stir-fried okra with onions and tomatoes.'),
(3, 'Prawn Biryani', 250, 'Biryani with succulent prawns and aromatic spices.'),
(4, 'Kadhai Paneer', 160, 'Paneer cooked with bell peppers and tomatoes.'),
(5, 'Mutton Korma', 300, 'Tender mutton in a rich, creamy sauce.'),
(1, 'Chicken Kebab', 140, 'Grilled chicken skewers with spices.'),
(2, 'Jeera Rice', 90, 'Basmati rice flavored with cumin seeds.'),
(3, 'Paneer Butter Masala', 170, 'Paneer in a rich tomato and butter sauce.'),
(4, 'Dal Tadka', 110, 'Yellow lentils tempered with spices.'),
(5, 'Vegetable Pulao', 130, 'Rice cooked with mixed vegetables and spices.'),
(1, 'Chicken Manchurian', 180, 'Chicken in a tangy and spicy Manchurian sauce.'),
(2, 'Gobi Manchurian', 120, 'Crispy cauliflower in Manchurian sauce.'),
(3, 'Mutton Biryani', 270, 'Aromatic biryani with tender mutton pieces.'),
(4, 'Vegetable Hakka Noodles', 150, 'Stir-fried noodles with mixed vegetables.'),
(5, 'Chicken Shawarma', 160, 'Grilled chicken wrapped in pita bread.'),
(1, 'Malai Kofta', 180, 'Fried dumplings in a creamy sauce.'),
(2, 'Paneer Bhurji', 140, 'Scrambled paneer with spices.'),
(3, 'Chicken Chettinad', 210, 'Spicy chicken curry from Chettinad.'),
(4, 'Fish Amritsari', 180, 'Crispy fried fish with spices.'),
(5, 'Vegetable Korma', 160, 'Mixed vegetables in a creamy coconut sauce.');



SELECT * From Menus;

-- Create Orders table
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    restaurant_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id) ON DELETE CASCADE
);

INSERT INTO Orders (user_id, restaurant_id, total_amount) VALUES
(1, 1, 270),
(2, 2, 270),
(3, 3, 260),
(4, 4, 150),
(5, 5, 300);

SELECT * From Orders;

-- Create OrderDetails table
CREATE TABLE IF NOT EXISTS OrderDetails (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    menu_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (menu_id) REFERENCES Menus(menu_id) ON DELETE CASCADE
);

INSERT INTO OrderDetails (order_id, menu_id, quantity, price) VALUES
(1, 1, 1, 170),
(1, 2, 1, 360),
(2, 3, 1, 250),
(2, 4, 1, 400),
(3, 5, 1, 150),
(3, 6, 1, 170),
(4, 4, 1, 200),
(5, 3, 1, 150);

SELECT * From OrderDetails;

insert into orderdetails (order_detail_id,order_id,menu_id,quantity,price) values
(9,3,2,1,130),
(10,3,4,1,200);


insert into orders (order_id,user_id,restaurant_id,order_date,total_amount) values
(6,3,2,'2024-05-20 13:16:35',130),
(7,3,4,'2024-04-20 13:16:35',200);

insert into orderdetails (order_detail_id,order_id,menu_id,quantity,price) values
(11,6,7,1,90),
(12,7,4,9,300);

-- Subqueries are nested queries that can return a single value, a list of values, or a temporary table.

-- Using a subquery to find customers who placed orders within a certain date range

SELECT name, email
FROM user
WHERE user_id IN (
    SELECT user_id
    FROM orders
    WHERE order_date BETWEEN '2024-01-01' AND '2024-06-30'
);

--SINGLE ROW SUBQUERY

--A single row subquery returns only one row from the subquery. It is used to compare a value from the outer query with a single value returned by the subquery.

--Find the restaurant with the highest rating.

SELECT *
FROM restaurants
WHERE rating = (
    SELECT MAX(rating)
    FROM restaurants
); 
--the subquery returns the maximum rating from the restaurants table, and the outer query selects the restaurant with that rating.

--MULTI ROW SUBQUERY

--A multi row subquery returns multiple rows from the subquery. It is used to compare a value from the outer query with multiple values returned by the subquery.

-- Find all restaurants that have a rating higher than the average rating.

SELECT *
FROM restaurants
WHERE rating > (
    SELECT AVG(rating)
    FROM restaurants
);
-- the subquery returns the average rating from the restaurants table, and the outer query selects all restaurants with a rating higher than the average.

--CORRELATED SUBQUERY

--A correlated subquery is a subquery that references columns from the outer query. It is used to compare values from the outer query with values from the subquery.

-- Find restaurants where the average menu item price is higher than the average menu item price of all restaurants.

SELECT name, location
FROM restaurants r
WHERE (SELECT AVG(item_price) FROM menus WHERE restaurant_id = r.restaurant_id) >
      (SELECT AVG(item_price) FROM menus);

--The correlated subquery (SELECT AVG(item_price) FROM menus WHERE restaurant_id = r.restaurant_id) calculates the average item_price for each restaurant.
--The outer query selects restaurants (name and location) where this average item_price is greater than the overall average item_price across all restaurants.

--JOINS

--1. Inner Join with Subquery: Restaurants with Orders where Total Amount > 1000

SELECT r.name AS restaurant_name, o.order_id, o.total_amount
FROM restaurants r
INNER JOIN (
    SELECT * 
    FROM orders
    WHERE total_amount > 1000
) o ON r.restaurant_id = o.restaurant_id;

/*
Inner Join (INNER JOIN): Combines rows from restaurants and a subquery result (orders with total_amount > 1000) where restaurant_id matches.
(SELECT * FROM orders WHERE total_amount > 1000): Filters orders where the total_amount is greater than 1000.
Returns restaurant_name, order_id, and total_amount for orders meeting the criteria.
*/

--2. Left Join with Aggregate Function: Restaurants and their Total Orders' Amounts

SELECT r.name AS restaurant_name, COALESCE(SUM(o.total_amount), 0) AS total_orders_amount
FROM restaurants r
LEFT JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.name;

/*
Left Join (LEFT JOIN): Retrieves all rows from restaurants and matches corresponding rows from orders.
 (SUM(o.total_amount)): Calculates the total total_amount for each restaurant.
COALESCE() Handles cases where no orders exist for a restaurant, ensuring a default of 0 for total_orders_amount.
 Provides restaurant_name and total_orders_amount for each restaurant, even if they have no orders.

*/

--3. Right Join with Date and Time Functions: Orders and their Payment Status

SELECT o.order_id, o.total_amount, p.status, p.timestamp
FROM orders o
RIGHT JOIN payment p ON o.order_id = p.order_id;

/*
Right Join (RIGHT JOIN): Retrieves all rows from payment and matches corresponding rows from orders.
 Combines order_id, total_amount from orders with status and timestamp from payment.
*/

-- ANALYTIC FUNCTIONS/ ADVANCED FUNCTIONS

--Advanced functions, also known as analytic functions or window functions, are powerful SQL features that allow for more complex analysis and reporting within queries. 
--These functions operate on a set of rows related to the current query row and can perform calculations across these rows.

--1. ROW_NUMBER()==>Assigns a unique sequential integer starting from 1 to each row in the result set.
--Assign a unique row number to each row in a result set.

SELECT 
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num,
    employee_id,
    name,
    salary
FROM 
    employees;

--OVER (ORDER BY salary DESC): Specifies the order of rows based on the salary column.
-- Returns row_num, employee_id, name, and salary sorted by descending salary.

--2. RANK() ==> Computes the rank of rows based on the sales_amount, where rows with the same sales_amount receive the same rank.
-- Assign a rank to each row based on a specified criteria.

SELECT 
    RANK() OVER (ORDER BY sales_amount DESC) AS rank,
    salesperson_id,
    name,
    sales_amount
FROM 
    sales;

-- Returns rank, salesperson_id, name, and sales_amount showing the rank of each salesperson by sales amount.

--3. Computes the rank of rows based on salary within each department_id, ensuring no gaps in ranking.
-- Calculate a dense rank for each row.

SELECT 
    DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dense_rank,
    employee_id,
    name,
    salary,
    department_id
FROM 
    employees;

--Returns dense_rank, employee_id, name, salary, and department_id showing dense ranking by salary within each department.

--4.LEAD(): Get the next row's value in a result set.

SELECT 
    employee_id,
    name,
    salary,
    LEAD(salary, 1, 0) OVER (ORDER BY salary) AS next_salary
FROM 
    employees;

--LEAD(salary, 1, 0): Retrieves the salary value from the next row (offset = 1) in the result set ordered by salary. If no next row exists, returns 0.
-- Returns employee_id, name, salary, and next_salary (next row's salary) for each employee.

--5.LAG(): Get the previous row's value in a result set.

SELECT 
    employee_id,
    name,
    salary,
    LAG(salary, 1, 0) OVER (ORDER BY salary) AS prev_salary
FROM 
    employees;

--LAG(salary, 1, 0): Retrieves the salary value from the previous row (offset = 1) in the result set ordered by salary. If no previous row exists, returns 0.
-- Returns employee_id, name, salary, and prev_salary (previous row's salary) for each employee.

-- CUME_DIST: Cumulative distribution of payment amounts
select oid, amount, cume_dist() over (order by amount) as cumulative_distribution 
from payment;
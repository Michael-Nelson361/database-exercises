-- More Drills With The Sakila Database
-- 1. SELECT statements
-- 	a. Select all columns from the actor table.
-- 	b. Select only the last_name column from the actor table.
-- 	c. Select only the film_id, title, and release_year columns from the film table.


-- 2. DISTINCT operator
-- 	a. Select all distinct (different) last names from the actor table.
-- 	b. Select all distinct (different) postal codes from the address table.
-- 	c. Select all distinct (different) ratings from the film table.


-- 3. WHERE clause
-- 	a. Select the title, description, rating, and movie length columns from the films table that last 3 hours or longer.
-- 	b. Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.
-- 	c. Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005.
-- 	d. Select all columns from the customer table for rows that have last names beginning with "S" and first names ending with "N".
-- 	e. Select all columns from the customer table for rows where the customer is inactive or has a last name beginning with "M".
-- 	f. Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either "C", "S" or "T".
-- 	g. Select all columns minus the password column from the staff table for rows that contain a password.
-- 	h. Select all columns minus the password column from the staff table for rows that do not contain a password.


-- 4. IN operator
-- 	a. Select the phone and district columns from the address table for addresses in California, England, Taipei, or West Java.
-- 	b. Select the payment id, amount, and payment date columns from the payment table for payments made on 05/25/2005, 05/27/2005, and 05/29/2005. 
-- 		(Use the IN operator and the DATE function, instead of the AND operator as in previous exercises.)
-- 	c. Select all columns from the film table for films rated G, PG-13 or NC-17.


-- 5. BETWEEN operator
-- 	a. Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.
-- 	b. Select the film_id, title, and description columns from the film table for films where the length of the description is between 100 and 120.


-- 6. LIKE operator
-- 	a. Select the following columns from the film table for rows where the description begins with "A Thoughtful".
-- 	b. Select the following columns from the film table for rows where the description ends with the word "Boat".
-- 	c. Select the following columns from the film table where the description contains the word "Database" and the length of the film is greater than 3 hours.


-- 7. LIMIT Operator
-- 	a. Select all columns from the payment table and only include the first 20 rows.
-- 	b. Select the payment date and amount columns from the payment table for rows where the payment amount is greater than 5,
-- 		and only select rows whose zero-based index in the result set is between 1000-2000.
-- 	c. Select all columns from the customer table, limiting results to those where the zero-based index is between 101-200.


-- 8. ORDER BY statement
-- 	a. Select all columns from the film table and order rows by the length field in ascending order.
-- 	b. Select all distinct ratings from the film table ordered by rating in descending order.
-- 	c. Select the payment date and amount columns from the payment table for the first 20 payments ordered by payment amount in descending order.
-- 	d. Select the title, description, special features, length, and rental duration columns
-- 		from the film table for the first 10 films with behind the scenes footage under 2 hours in length
--         and a rental duration between 5 and 7 days, ordered by length in descending order.


-- 9. JOINs
-- 	a. Select customer first_name/last_name and actor first_name/last_name columns from performing a left join between the customer 
-- 		and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
-- 		- Label customer first_name/last_name columns as customer_first_name/customer_last_name
-- 		- Label actor first_name/last_name columns in a similar fashion.
-- 		- returns correct number of records: 620
-- 	b. Select the customer first_name/last_name and actor first_name/last_name columns from performing a right join
-- 		between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
-- 		- returns correct number of records: 200
-- 	c. Select the customer first_name/last_name and actor first_name/last_name columns from performing an inner join 
-- 		between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
-- 		- returns correct number of records: 43
-- 	d. Select the city name and country name columns from the city table, performing a left join with the country table to get the country name column.
-- 		- Returns correct records: 600
-- 	e. Select the title, description, release year, and language name columns from the film table, 
-- 		performing a left join with the language table to get the "language" column.
-- 		- Label the language.name column as "language"
-- 		- Returns 1000 rows
-- 	f. Select the first_name, last_name, address, address2, city name, district, and postal code columns from the staff table, 
-- 		performing 2 left joins with the address table then the city table to get the address and city related columns.
-- 		- returns correct number of rows: 2

-- ----------------

-- 1. Display the first and last names in all lowercase of all the actors.
-- 2. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." 
-- 	What is one query would you use to obtain this information?
-- 3. Find all actors whose last name contain the letters "gen":
-- 4. Find all actors whose last names contain the letters "li". This time, order the rows by last name and first name, in that order.
-- 5. Using IN, display the country_id and country columns for the following countries: Afghanistan, Bangladesh, and China.
-- 6. List the last names of all the actors, as well as how many actors have that last name.
-- 7. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
-- 8. You cannot locate the schema of the address table. Which query would you use to recreate it?
-- 9. Use JOIN to display the first and last names, as well as the address, of each staff member.
-- 10. Use JOIN to display the total amount rung up by each staff member in August of 2005.
-- 11. List each film and the number of actors who are listed for that film.
-- 12. How many copies of the film Hunchback Impossible exist in the inventory system?
-- 13. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. 
-- 	As an unintended consequence, films starting with the letters K and Q have also soared in popularity. 
-- 	Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
-- 14. Use subqueries to display all actors who appear in the film Alone Trip.
-- 15. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers.
-- 16. Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
-- 	Identify all movies categorized as family films.
-- 17. Write a query to display how much business, in dollars, each store brought in.
-- 18. Write a query to display for each store the store ID, city, and country.
-- 19. List the top five genres in gross revenue in descending order. 
-- 	(Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)

-- ----------------

-- 1. What is the average replacement cost of a film? Does this change depending on the rating of the film?
-- 2. How many different films of each genre are in the database?
-- 3. What are the 5 frequently rented films?
-- 4. What are the most profitable films (in terms of gross revenue)?
-- 5. Who is the best customer?
-- 6. Who are the most popular actors (that have appeared in the most films)?
-- 7. What are the sales of each store for each month in 2005?
-- 8. Bonus: Find the film title, customer name, customer phone number, and customer address for all the outstanding DVDs.

-- Employees Database
-- 1. How much do the current managers of each department get paid, relative to the average salary for the department? 
-- 	Is there any department where the department manager gets paid less than the average salary?

-- World Database
-- Use the world database for the questions below.

-- 	- What languages are spoken in Santa Monica?
-- 	- How many different countries are in each region?
-- 	- What is the population for each region?
-- 	- What is the population for each continent?
-- 	- What is the average life expectancy globally?
-- 	- What is the average life expectancy for each region, each continent? Sort the results from shortest to longest

-- Bonus
-- 	- Find all the countries whose local name is different from the official name
-- 	- How many countries have a life expectancy less than x?
-- 	- What state is city x located in?
-- 	- What region of the world is city x located in?
-- 	- What country (use the human readable name) city x located in?
-- 	- What is the life expectancy in city x?


-- Advanced: Pizza Database
-- Use the pizza database to answer the following questions.

-- 	- What information is stored in the toppings table? How does this table relate to the pizzas table?
-- 	- What information is stored in the modifiers table? How does this table relate to the pizzas table?
-- 	- How are the pizzas and sizes tables related?
-- 	- What other tables are in the database?
-- 	- How many unique toppings are there?
-- 	- How many unique orders are in this dataset?
-- 	- Which size of pizza is sold the most?
-- 	- How many pizzas have been sold in total?
-- 	- What is the most common size of pizza ordered?
-- 	- What is the average number of pizzas per order?

-- ----------------

-- Find the total price for each order. The total price is the sum of:
-- 	- The price based on pizza size
-- 	- Any modifiers that need to be charged for
-- 	- The sum of the topping prices
-- Topping price is affected by the amount of the topping specified. A light amount is half of the regular price. 
-- 	An extra amount is 1.5 times the regular price, and double the topping is double the price.

-- ----------------

-- Additional Questions:
-- 	- What is the average price of pizzas that have no cheese?
-- 	- What is the most common size for pizzas that have extra cheese?
-- 	- What is the most common topping for pizzas that are well done?
-- 	- How many pizzas are only cheese (i.e. have no toppings)?
-- 	- How many orders consist of pizza(s) that are only cheese? What is the average price of these orders? The most common pizza size?
-- 	- How many large pizzas have olives on them?
-- 	- What is the average number of toppings per pizza?
-- 	- What is the average number of pizzas per order?
-- 	- What is the average pizza price?
-- 	- What is the average order total?
-- 	- What is the average number of items per order?
-- 	- What is the average number of toppings per pizza for each size of pizza?
-- 	- What is the average order total for orders that contain more than 1 pizza?
-- 	- What is the most common pizza size for orders that contain only a single pizza?
-- 	- How many orders consist of 3+ pizzas? What is the average number of toppings for these orders?
-- 	- What is the most common topping on large and extra large pizzas?
-- 	- What is the most common topping for orders that consist of 2 pizzas?
-- 	- Which size of pizza most frequently has modifiers?
-- 	- What percentage of pizzas with hot sauce have extra cheese?
-- 	- What is the average order price for orders that have at least 1 pizza with pineapple?
-- Create a file named join_exercises.sql to do your work in.
show databases;

-- Join Example Database
-- 1. Use the join_example_db. 
-- 	Select all the records from both the users and roles tables.
use join_example_db;
select database();
show tables;
select *
from roles;
select *
from users;

-- 2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. 
-- 	Before you run each query, guess the expected number of results.
select users.name as user_name, roles.name as role_name
from users
join roles on users.role_id = roles.id;

-- 3. Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. 
-- 	Use count and the appropriate join type to get a list of roles along with the number of users that have the role. 
-- 	Hint: You will also need to use group by in the query.


-- Employees Database
-- 1. Use the employees database.

-- 2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.


-- 3. Find the name of all departments currently managed by women.


-- 4. Find the current titles of employees currently working in the Customer Service department.


-- 5. Find the current salary of all current managers.


-- 6. Find the number of current employees in each department.


-- 7. Which department has the highest average salary? Hint: Use current not historic information.


-- 8. Who is the highest paid employee in the Marketing department?


-- 9. Which current department manager has the highest salary?


-- 10. Determine the average salary for each department. Use all salary information and round your results.


-- 11. Bonus Find the names of all current employees, their department name, and their current manager's name.


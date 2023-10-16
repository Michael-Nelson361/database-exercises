-- Create a new file named group_by_exercises.sql
show databases;
use employees;
select database();
show tables;

-- In your script, use DISTINCT to find the unique titles in the titles table. 
-- How many unique titles have there ever been? 
-- Answer that in a comment in your SQL file.
select count(distinct title) 'Title Count'
from titles
;
-- There are 7 unique titles

-- Write a query to find a list of all unique last names that start and end with 'E' using GROUP BY.
select last_name
from employees
where last_name like 'e%e'
group by last_name
;
-- Returns 5 rows: Erde, Eldridgel Etalle, Erie, and Erbe

-- Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
select first_name,last_name
from employees
where last_name like 'e%e'
group by last_name,first_name
order by last_name
;

-- Write a query to find the unique last names with a 'q' but not 'qu'. 
-- Include those names in a comment in your sql code.
select last_name
from employees
where last_name like '%q%'
	and last_name not like '%qu%'
group by last_name
;
-- Chleq, Lindqvist, and Qiwen

-- Add a COUNT() to your results for exercise 5 to find the number of employees with the same last name.
select last_name, count(*)
from employees
where last_name like '%q%'
	and last_name not like '%qu%'
group by last_name
;
-- Chleq, 189
-- Lindqvist, 190
-- Qiwen, 168

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya'. 
-- Use COUNT(*) and GROUP BY to find the number of employees with those names for each gender.
select first_name, gender, count(*)
from employees
where first_name in ('Irena','Vidya','Maya')
group by gender, first_name
order by first_name, gender
;
/*
Irena:(M)-144, (F)-97
Maya:(M)-146, (F)-90
Vidya:(M)-151, (F)-81
*/

-- Using your query that generates a username for all employees, generate a count of employees with each unique username.
select concat(
	substr(lower(first_name),1,1)
	,substr(lower(last_name),1,4)
    ,'_'
    ,substr(birth_date,6,2)
	,substr(year(birth_date),3,2))
    as username, first_name, last_name, birth_date
from employees
; -- WIP

-- From your previous query, are there any duplicate usernames? 
-- What is the highest number of times a username shows up? 
-- Bonus: How many duplicate usernames are there?



-- Bonus: More practice with aggregate functions:

-- Determine the historic average salary for each employee. 
-- When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.


-- Using the dept_emp table, count how many current employees work in each department. 
-- The query result should show 9 rows, one for each department and the employee count.


-- Determine how many different salaries each employee has had. 
-- This includes both historic and current.


-- Find the maximum salary for each employee.


-- Find the minimum salary for each employee.


-- Find the standard deviation of salaries for each employee.


-- Find the max salary for each employee where that max salary is greater than $150,000.


-- Find the average salary for each employee where that average salary is between $80k and $90k.


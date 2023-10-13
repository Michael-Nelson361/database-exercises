-- Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.
USE employees;
SHOW TABLES;

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. 
DESCRIBE employees;
select emp_no,first_name,last_name
from employees
where first_name in ('Irena','Vidya','Maya')
order by first_name
;
-- In your comments, answer: 
-- What was the first and last name in the first row of the results? 
	-- First individual is Irena Reutenauer
-- What was the first and last name of the last person in the table?
	-- Last individual is Vidya Simmen


-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. 
DESCRIBE employees;
select emp_no,first_name,last_name
from employees
where first_name in ('Irena','Vidya','Maya')
order by first_name,last_name
;
-- In your comments, answer: 
-- What was the first and last name in the first row of the results? 
	-- First individual is Irena Acton
-- What was the first and last name of the last person in the table?
	-- Last individual is Vidya Zweizig


-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. 
DESCRIBE employees;
select emp_no,first_name,last_name
from employees
where first_name in ('Irena','Vidya','Maya')
order by last_name,first_name
;
-- In your comments, answer: 
-- What was the first and last name in the first row of the results? 
	-- First individual is still Irena Acton
-- What was the first and last name of the last person in the table?
	-- Last individual is Maya Zyda


-- Write a query to find all employees whose last name starts and ends with 'E'. 
-- Sort the results by their employee number. 
-- Enter a comment with 
-- 	the number of employees returned, 
--  the first employee number and their first and last name, and 
--  the last employee number with their first and last name.
select emp_no,first_name,last_name
from employees
where last_name like 'e%'
	and last_name like '%e'
order by emp_no
;
-- Number of employees returned: 899
-- First employee: 10021 Ramzi Erde
-- Last employee: 499648 Tadahiro Erde


-- Write a query to find all employees whose last name starts and ends with 'E'. 
-- Sort the results by their hire date, so that the newest employees are listed first. 
-- Enter a comment with 
-- 	the number of employees returned, 
--     the name of the newest employee, and 
--     the name of the oldest employee.
select emp_no,first_name,last_name,hire_date
from employees
where last_name like 'e%e'
order by hire_date desc
;
-- Number of employees returned: 899
-- Name of newest employee: Teiji Eldridge
-- Name of oldest employee: Sergi Erde


-- Find all employees hired in the 90s and born on Christmas. 
-- Sort the results so that the oldest employee who was hired last is the first result. 
-- Enter a comment with 
-- 	the number of employees returned, 
-- 	the name of the oldest employee who was hired last, and 
--     the name of the youngest employee who was hired first.
select *
from employees
where birth_date like '%-12-25'
	AND hire_date BETWEEN '1990-01-01' and '1999-12-31'
order by birth_date,hire_date desc
;
-- Number of employees returned: 362
-- Oldest employee hired last: Khun Bernini
-- Youngest employee hired first: Douadi Pettis
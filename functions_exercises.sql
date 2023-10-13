-- You may choose to copy the order by exercises and save it as functions_exercises.sql, 
-- to save time as you will be editing the queries to answer your functions exercises.
use employees;
select database();

-- Write a query to find all employees whose last name starts and ends with 'E'. 
-- Use concat() to combine their first and last name together as a single column named full_name.
select concat(first_name,' ',last_name) as full_name
from employees
where last_name like 'e%e'
;
-- 899 rows returned

-- Convert the names produced in your last query to all uppercase.
select upper(
	concat(first_name,' ',last_name)
)
from employees
where last_name like 'e%e'
;

-- Use a function to determine how many results were returned from your previous query.
select count(
	upper(
		concat(first_name,' ',last_name)
	)
) as count_names
from employees
where last_name like 'e%e'
;
-- 899 results

-- Find all employees hired in the 90s and born on Christmas. 
-- Use datediff() function to find how many days they have been working at the company 
-- (Hint: You will also need to use NOW() or CURDATE()),
select 
	birth_date
	,concat(first_name,' ',last_name) as full_name
    ,datediff(curdate(),hire_date) as days_working
from employees
where birth_date like '%12-25'
	and year(hire_date) between 1990 and 1999
;

-- Find the smallest and largest current salary from the salaries table.
describe salaries;
select 
	min(salary) as min_salary
	,max(salary) as max_salary
from salaries
where to_date > curdate()
;
-- Smallest salary is 38623, largest salary is 158220

-- Use your knowledge of built in SQL functions to generate a username for all of the employees. 
-- A username should be all lowercase, and consist of the first character of the employees first name, 
-- the first 4 characters of the employees last name, an underscore, the month the employee was born, 
-- and the last two digits of the year that they were born.
select concat(
	substr(lower(first_name),1,1)
	,substr(lower(last_name),1,4)
    ,'_'
    ,substr(birth_date,6,2)
    -- ,month(birth_date) -- This probably works too, but I don't like its formatting
	,substr(year(birth_date),3,2)
) as username, first_name, last_name, birth_date
from employees
limit 20
;
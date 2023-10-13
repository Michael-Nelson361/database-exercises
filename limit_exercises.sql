-- Create a new SQL script named limit_exercises.sql.
show databases;
use employees;
select database();
-- MySQL provides a way to return only unique results from our queries with the keyword DISTINCT. 
-- For example, to find all the unique titles within the company, we could run the following query:
-- SELECT DISTINCT title FROM titles;

-- List the first 10 distinct last names sorted in descending order.
select distinct last_name
from employees
order by last_name desc
limit 10
;
-- 'Zykh'
-- 'Zyda'
-- 'Zwicker'
-- 'Zweizig'
-- 'Zumaque'
-- 'Zultner'
-- 'Zucker'
-- 'Zuberek'
-- 'Zschoche'
-- 'Zongker'


-- Find all previous or current employees hired in the 90s and born on Christmas. 
-- Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. 
-- Write a comment in your code that lists the five names of the employees returned.
select first_name,last_name
from employees
where birth_date like '%-12-25'
	AND hire_date BETWEEN '1990-01-01' and '1999-12-31'
order by hire_date
limit 5
;
-- 'Alselm','Cappello'
-- 'Utz','Mandell'
-- 'Bouchung','Schreiter'
-- 'Baocai','Kushner'
-- 'Petter','Stroustrup'


-- Try to think of your results as batches, sets, or pages. 
-- The first five results are your first page. 
-- The five after that would be your second page, etc. 
-- Update the query to find the tenth page of results.
select first_name,last_name
from employees
where birth_date like '%-12-25'
	AND hire_date BETWEEN '1990-01-01' and '1999-12-31'
order by hire_date
limit 5 offset 45
;
-- 10th page of results should be as follows:
-- 'Pranay','Narwekar'
-- 'Marjo','Farrow'
-- 'Ennio','Karcich'
-- 'Dines','Lubachevsky'
-- 'Ipke','Fontan'


-- LIMIT and OFFSET can be used to create multiple pages of data. 
-- What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?
/*
Since the first 5 results is the equivalent of OFFSET 0,
then the offset should evaluate to the expression: (limit * page_number) - limit
which should return offset 45 for for the 10th page

Or you can evaluate the 1st page as 'index 0'
So the expression becomes offset = limit * index
*/
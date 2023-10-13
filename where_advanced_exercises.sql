USE employees;
SHOW TABLES;
-- 1. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. 
-- What is the employee number of the top three results?
DESCRIBE employees;
select emp_no,first_name,last_name
from employees
where first_name in ('Irena','Vidya','Maya')
;
-- top three results are:
-- '10200','Vidya','Awdeh'
-- '10397','Irena','Reutenauer'
-- '10610','Irena','Roccetti'


-- 2. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. 
-- What is the employee number of the top three results? Does it match the previous question?
select emp_no,first_name,last_name
from employees
where first_name = 'Irena'
	or first_name = 'Vidya'
    or first_name = 'Maya'
;
-- top three results are:
-- '10200','Vidya','Awdeh'
-- '10397','Irena','Reutenauer'
-- '10610','Irena','Roccetti'
-- So it gives the same answer as before

-- 3. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. 
-- What is the employee number of the top three results?
select emp_no,first_name,last_name,gender
from employees
where (first_name = 'Irena'
	or first_name = 'Vidya'
    or first_name = 'Maya')
    and gender = 'M'
;
-- Employee number of the top 3 results are: 10200, 10397, and 10821

-- 4. Find all unique last names that start with 'E'.
select distinct last_name
from employees
where last_name like 'e%'
;
-- 40 rows returned

-- 5. Find all unique last names that start or end with 'E'.
select distinct last_name
from employees
where last_name like '%e'
	or last_name like 'e%'
;
-- 167 rows returned

-- 6. Find all unique last names that end with E, but does not start with E?
select distinct last_name
from employees
where last_name like '%e'
	and last_name not like 'e%'
;
-- 127 rows returned

-- 7. Find all unique last names that start and end with 'E'.
select distinct last_name
from employees
where last_name like 'e%'
	and last_name like '%e'
;
-- 5 rows returned: Erde, Eldridge, Etalle, Erie, and Erbe

-- 8. Find all current or previous employees hired in the 90s. 
-- Enter a comment with the top three employee numbers.
select *
from employees
where hire_date >='1990-01-01'
	and hire_date <'2000-01-01'
;
-- Top 3 employees returned: 10008, 10011, 10012

-- 9. Find all current or previous employees born on Christmas. 
-- Enter a comment with the top three employee numbers.
select *
from employees
where birth_date like '%-12-25'
;
-- Top 3 employee numbers: 10078, 10115, 10261

-- 10. Find all current or previous employees hired in the 90s and born on Christmas. 
-- Enter a comment with the top three employee numbers.
select *
from employees
where birth_date like '%-12-25'
	AND hire_date BETWEEN '1990-01-01' and '1999-12-31'
;
-- 362 rows returned, top 3: 10261, 10438, 10681


-- 11. Find all unique last names that have a 'q' in their last name.
select distinct last_name
from employees
where last_name like '%q%'
;
-- 10 rows returned:
-- 'Rouquie'
-- 'Chleq'
-- 'Maquelin'
-- 'Lindqvist'
-- 'Quittner'
-- 'Zumaque'
-- 'Quaggetto'
-- 'Quadeer'
-- 'Marquardt'
-- 'Qiwen'


-- 12. Find all unique last names that have a 'q' in their last name but not 'qu'.
select distinct last_name
from employees
where last_name like '%q%'
	and last_name not like '%qu%'
;
-- 3 rows returned: Chleq, Lindqvist, and Qiwen

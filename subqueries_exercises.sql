-- Create a file named subqueries_exercises.sql and craft queries to return the results for the following criteria:
use employees;

-- 1. Find all the current employees with the same hire date as employee 101010 using a subquery.
select *
from employees
inner join dept_emp
	using(emp_no)
where hire_date = (
	select hire_date
    from employees
    where emp_no = 101010
) and to_date > curdate()
;

-- 2. Find all the titles ever held by all current employees with the first name Aamod.
select distinct title
from titles
where emp_no in (
	select emp_no
    from employees
    where first_name = 'Aamod'
)
;

-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
/*select count(distinct emp_no)
from employees;

select count(distinct emp_no)
from dept_emp
where to_date > now();*/

select count(distinct emp_no)
from employees
where emp_no not in (
	select distinct emp_no
    from dept_emp
    where to_date > now()
); -- 59900 employees no longer working for the company

-- 4. Find all the current department managers that are female. List their names in a comment in your code.
select emp_no
from dept_manager
where to_date > now()
;
select 
	concat(first_name, ' ', last_name) as 'Name'
from employees
where gender = 'F' and
	emp_no in (
    select emp_no
    from dept_manager
    where to_date > now()
);
/*
Isamu Legleitner
Karsten Sigstam
Leon DasSarma
Hilary Kambil
*/

-- 5. Find all the employees who currently have a higher salary than the company's overall, historical average salary.
/*select round(avg(salary)) as avg_salary
from salaries;*/

select 
	concat(e.first_name, ' ',e.last_name) as 'Employee Name'
    ,salary as 'Salary'
from employees as e
join salaries as s
	on e.emp_no=s.emp_no
    and s.to_date>now()
/*join dept_emp as de
	on de.emp_no=e.emp_no
    and de.to_date>now()*/	-- Testing to see if this makes a difference
where salary > (
	select round(avg(salary)) as avg_salary
    from salaries
)
;

-- 6. How many current salaries are within 1 standard deviation of the current highest salary? 
-- 	(Hint: you can use a built-in function to calculate the standard deviation.) 
-- 	What percentage of all salaries is this?

-- 	Hint You will likely use multiple subqueries in a variety of ways
-- 	Hint It's a good practice to write out all of the small queries that you can. 
--     Add a comment above the query showing the number of rows returned. 
--     You will use this number (or the query that produced it) in other, larger queries.
/*select std(salary)
from salaries
where to_date>now()
;
select max(salary)
from salaries
where to_date>now()
;
select count(salary)
from salaries
where to_date>now();*/

# Test code 1: outputs 220
/*select count(salary)
from salaries
where salary > (
	(select max(salary)
    from salaries
    where to_date>now()) - 
    (select std(salary)
    from salaries
    where to_date>now())
)
;*/

# Test code 2: outputs 220
/*select count(salary)
from salaries
where salary > (
	(select max(salary) - std(salary)
    from salaries
    where to_date>now())
)
;*/

# Test code 3: outputs 220
/*select count(salary)
from salaries
where salary > (
	(select max(salary) - round(std(salary))
    from salaries
    where to_date>now() -- excluding this line results in 211
)) and to_date > now() -- without this line, then a bunch of older salaries will pop up
;*/

# Testing percentages
select 
	count(salary) / (
		select count(salary)
		from salaries
		where to_date>now()) 
	* 100 
    as perc_sal
from salaries
where salary > (
	(select max(salary) - round(std(salary))
    from salaries
    where to_date>now() -- excluding this line results in 211
)) and to_date > now() -- excluding this and statement results in 220
;

-- BONUS

-- 1. Find all the department names that currently have female managers.
select dept_no
from dept_manager as dm
join employees as e
	on e.emp_no=dm.emp_no
    and dm.to_date>now()
    and e.gender='F'
; -- Find department numbers with current female managers

select dept_name
from departments
where dept_no in (
	select dept_no
	from dept_manager as dm
	join employees as e
		on e.emp_no=dm.emp_no
		and dm.to_date>now()
		and e.gender='F'
)
; -- Select names with current female managers using subquery


-- 2. Find the first and last name of the employee with the highest salary.
select first_name,last_name
from employees
where emp_no in (
	# Subquery within a subquery to find employee number with max salary
	select emp_no -- ,salary -- don't need salary, it was just for verification
	from salaries
	where salary = (select max(salary) from salaries)
)
;

-- 3. Find the department name that the employee with the highest salary works in.

-- 4. Who is the highest paid employee within each department.


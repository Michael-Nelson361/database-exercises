-- Create a file named case_exercises.sql and craft queries to return the results for the following criteria:
use employees;
-- 1. Write a query that returns all employees, their department number, 
-- 	their start date, their end date, and a new column 'is_current_employee' that is a 1 
--     if the employee is still with the company and 0 if not. 
--     DO NOT WORRY ABOUT DUPLICATE EMPLOYEES.
select 
	de.*
    , case
		when to_date > now() then 1
        else 0
	end as is_current_employee
from dept_emp as de
;

-- 2. Write a query that returns all employee names (previous and current), 
-- 	and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' 
--     depending on the first letter of their last name.
select 
	e.first_name,e.last_name
	, case
		when left(last_name,1) between 'a' and 'h' then 'A-H'
        when left(last_name,1) between 'i' and 'q' then 'I-Q'
        when left(last_name,1) between 'r' and 'z' then 'R-Z'
        else 'ERROR'
    end as 'alpha_group'
from employees as e
;


-- 3. How many employees (current or previous) were born in each decade?
# get birth decades
select round(year(birth_date),-1) as decade
from employees
group by decade
;

select 
	count(*)
	,case
		when year(birth_date) < 1950 then 1940
        when year(birth_date) < 1960 then 1950
        when year(birth_date) < 1970 then 1960
        when year(birth_date) < 1980 then 1970
        when year(birth_date) < 1990 then 1980
        when year(birth_date) < 2000 then 1990
        else 'Gen Z'
    end as birth_decade
from employees as e
group by birth_decade
;

-- 4. What is the current average salary for each of the following department groups: 
-- R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
select 
	round(avg(salary),2) as avg_sal
	,case
		when dept_name like 'Customer Service' then 'Customer Service'
        when dept_name = 'Sales' or dept_name = 'Marketing' then 'Sales & Marketing'
        when dept_name = 'Research' or dept_name = 'Development' then 'R&D'
        when dept_name = 'Production' or dept_name = 'Quality Management' then 'Prod & QM'
        when dept_name = 'Finance' or dept_name = 'Human Resources' then 'Finance & HR'
    end as dept_group
from departments as d
join dept_emp as de
	using (dept_no)
join salaries as s
	using (emp_no)
where s.to_date > now()
	and de.to_date > now()
group by dept_group
;

-- BONUS

-- Remove duplicate employees from exercise 1.
select 
	emp_no
	,count(emp_no) as doubles
from dept_emp as de
group by emp_no
;

select 
	de.*
    , case
		when to_date < now() and doubles > 1 then null -- mark field with null if the employee has moved departments and not companies
        when to_date > now() then 1 -- This has to be after the above, or duplicate records won't be caught
        else 0
	end as is_current
    -- ,double_count.* -- Visually check matching double_count properly
from dept_emp as de
left join 
	( # Subquery to tack on a "tag" denoting employees who are found twice
    select 
		emp_no
		,count(emp_no) as doubles
	from dept_emp as de
	group by emp_no
    ) as double_count
    using(emp_no)
having is_current is not null	-- Take out any employee whose is_current field has a null in it
-- having is_current is null and to_date > now()	-- Check to see if case 1 happened to pick up any current records
;
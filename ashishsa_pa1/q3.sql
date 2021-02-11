USE employees;
SELECT e.last_name,s.salary,s.from_date,s.to_date FROM employees e INNER JOIN salaries s ON e.emp_no = s.emp_no ORDER BY e.last_name,s.from_date,s.to_date,s.salary;
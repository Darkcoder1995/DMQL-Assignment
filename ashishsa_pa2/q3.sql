USE employees;
SELECT d.emp_no, d1.dept_name FROM dept_manager d, departments d1 
WHERE EXISTS (SELECT d2.emp_no FROM dept_manager d2 
WHERE d2.emp_no=d.emp_no AND datediff(d2.to_date,d2.from_date) <= 
ALL (SELECT datediff(d3.to_date,d3.from_date) FROM dept_manager d3 WHERE d3.dept_no=d2.dept_no)) 
AND d1.dept_no=d.dept_no ORDER BY d.emp_no;
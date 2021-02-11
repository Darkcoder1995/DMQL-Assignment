USE employees;
SELECT d1.dept_name AS dept_name, t.title AS title, COUNT(*) AS 'cnt' FROM dept_emp d 
INNER JOIN titles t ON d.emp_no = t.emp_no INNER JOIN departments d1 
ON d.dept_no = d1.dept_no WHERE d.to_date = '9999-01-01' AND t.to_date = '9999-01-01' 
GROUP BY t.title,d1.dept_name ORDER BY d1.dept_name,t.title
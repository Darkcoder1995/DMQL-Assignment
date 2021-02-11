USE employees;
SELECT d1.dept_name, COUNT(*)-1 AS 'cnt' FROM dept_manager d INNER JOIN departments d1 ON d.dept_no = d1.dept_no GROUP BY(d.dept_no) HAVING COUNT(d.emp_no)>2 ORDER BY d1.dept_name;
USE employees;
SELECT e.emp_no AS emp, d.emp_no AS mgr, e.from_date FROM dept_emp e INNER JOIN dept_manager d ON e.dept_no = d.dept_no WHERE e.to_date = '9999-01-01' AND d.emp_no IN(SELECT d1.emp_no FROM dept_manager d1 WHERE d1.from_date >= ALL(SELECT d2.from_date FROM dept_manager d2 WHERE d1.dept_no=d2.dept_no)) ORDER BY e.emp_no; 

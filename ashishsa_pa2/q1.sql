USE employees;
SELECT e1.emp_no AS e1,e2.emp_no AS e2 
FROM employees e1, employees e2 , salaries s1, salaries s2, dept_emp d1, dept_emp d2 
WHERE e1.emp_no = s1.emp_no AND e2.emp_no = s2.emp_no 
AND e1.emp_no = d1.emp_no AND e2.emp_no=d2.emp_no 
AND s1.to_date='9999-01-01' AND s2.to_date='9999-01-01' 
AND d1.to_date='9999-01-01' AND d2.to_date='9999-01-01' 
AND d1.dept_no='d002' AND d2.dept_no='d002' 
AND YEAR(e1.birth_date) LIKE '1956%' AND YEAR(e2.birth_date) LIKE '1956%' 
AND s1.salary<s2.salary AND e1.emp_no>e2.emp_no AND e1.emp_no<100000 AND e2.emp_no<100000 ORDER BY e1,e2;


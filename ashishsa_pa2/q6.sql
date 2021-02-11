USE employees;
SELECT s.emp_no,100*((count(s.emp_no)OVER(ORDER BY s.salary)-1)/(SELECT count(s1.emp_no)-1 FROM salaries s1 WHERE s1.to_date='9999-01-01' AND s1.emp_no < 20000)) AS percentile FROM
salaries s WHERE s.to_date='9999-01-01' AND s.emp_no<20000 ORDER BY s.emp_no;
USE employees;
SELECT t1.emp_no,t2.from_date AS 'on_date',t1.title AS 'o_title',t2.title AS 'n_title',s1.salary AS 'o_salary',s2.salary AS 'n_salary' 
FROM titles t1, titles t2, salaries s1, salaries s2 
WHERE t1.emp_no=t2.emp_no AND
t1.title <> t2.title AND
s1.emp_no = s2.emp_no AND
t1.emp_no = s1.emp_no AND
t1.to_date=t2.from_date AND
s1.to_date = t1.to_date AND
s2.from_date = t2.from_date AND
s1.salary>s2.salary
ORDER BY t1.emp_no;

USE Employees;
WITH RECURSIVE initial AS (
SELECT t1.title AS 'src' ,t2.title as 'dst',AVG(YEAR(t2.from_date)-YEAR(t1.from_date)+1) AS 'years'  FROM
titles t1, titles t2 WHERE
t1.emp_no=t2.emp_no AND t1.title<>t2.title AND t1.to_date=t2.from_date  GROUP BY t1.title,t2.title
),
natural_selection2(src, dst, years) AS (
SELECT src,dst,years FROM initial
UNION
SELECT t1.src AS 'src' ,t2.dst AS 'dst',(t1.years+t2.years) AS 'years'  FROM
initial t1, natural_selection2 t2 WHERE
t1.dst=t2.src AND t1.src<>t2.dst AND (t1.years+t2.years)<100
)SELECT src,dst,min(years) AS 'years' FROM natural_selection2 GROUP BY src,dst ORDER BY src,dst;

USE pa3;
WITH RECURSIVE flights(src,dst) AS(
SELECT src,dst FROM amap
UNION 
SELECT P.src,U.dst 
FROM amap P, flights U 
WHERE P.dst = U.src)
SELECT flights.src,flights.dst 
FROM flights ORDER BY src,dst;
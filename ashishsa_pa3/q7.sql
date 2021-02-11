USE pa3;
WITH RECURSIVE flights(src,dst,cost) AS(
SELECT src,dst,cost FROM amap
UNION
SELECT a.src,a1.dst,(a.cost+a1.cost) AS 'cost'
FROM amap a,amap a1
WHERE a.dst = a1.src)
SELECT flights.src,flights.dst,MIN(flights.cost) AS 'cost'
FROM flights WHERE flights.src<>flights.dst GROUP BY flights.src,flights.dst ORDER BY src,dst;
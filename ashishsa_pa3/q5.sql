USE sakila;
WITH RECURSIVE initial AS (SELECT c1.customer_id AS c1,c2.customer_id AS c2,
ROUND(ST_Distance_Sphere(a1.location, a2.location) * .000621371192, 2) AS 'distance' 
FROM customer c1,customer c2, address a1, address a2 
WHERE c1.address_id=a1.address_id AND c2.address_id=a2.address_id
AND c1.customer_id<c2.customer_id 
AND -180<ST_X(a1.location) AND -180<ST_X(a2.location) 
AND ST_X(a1.location)<=180 AND ST_X(a2.location)<=180 AND
ST_Y(a1.location)<=90 AND ST_Y(a2.location)<=90 AND
ROUND(ST_Distance_Sphere(a1.location, a2.location) * .000621371192, 2)<20 AND
ROUND(ST_Distance_Sphere(a1.location, a2.location) * .000621371192, 2)>0
),
natural_selection2 (c1, c2, distance) AS (SELECT c1, c2, distance FROM initial
	UNION ALL 
	SELECT I.c1, n.c2, (I.distance + n.distance) FROM initial AS I, natural_selection2 AS n
	WHERE I.c2 = n.c1) SELECT c1, c2, MIN(distance) AS 'distance' FROM natural_selection2 
WHERE c1 NOT IN (SELECT c2 FROM natural_selection2) GROUP BY c1, c2 ORDER BY c1, c2;
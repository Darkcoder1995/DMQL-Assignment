USE sakila;
SELECT CONCAT_WS(' ',a1.first_name,a1.last_name) AS actor_name, COUNT(DISTINCT f.category_id) AS 'ncat'
FROM film_category f, film_actor a, actor a1
WHERE f.film_id=a.film_id AND a.actor_id=a1.actor_id 
GROUP BY a.actor_id ORDER BY actor_name;


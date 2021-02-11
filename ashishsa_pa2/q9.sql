USE sakila;
SELECT f.film_id,k.length,AVG(DATEDIFF(r.return_date,r.rental_date)) AS 'avg_days' FROM rental r,inventory f,film k WHERE r.inventory_id=f.inventory_id AND f.film_id=k.film_id GROUP BY f.film_id

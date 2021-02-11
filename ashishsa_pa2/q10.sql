USE sakila;
SELECT p.customer_id,SUM(p.amount) AS 'total',COUNT(r.rental_id) AS 'n_rent' FROM payment p INNER JOIN rental r ON p.rental_id=r.rental_id GROUP BY r.customer_id HAVING SUM(p.amount)>100;
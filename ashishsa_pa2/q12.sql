USE sakila;
SELECT * FROM (SELECT i.film_id, f.replacement_cost-sum(p.amount) AS 'to_breakeven' 
FROM rental r, payment p, inventory i, film f 
WHERE r.rental_id=p.rental_id AND
i.inventory_id=r.inventory_id AND
i.film_id=f.film_id 
GROUP BY i.film_id 
HAVING sum(p.amount)<(SELECT f1.replacement_cost FROM film f1 WHERE f1.film_id=i.film_id) 
ORDER BY to_breakeven asc) f  WHERE f.to_breakeven<1.07 AND f.to_breakeven>0.08 ORDER BY f.film_id;

USE sakila;
SELECT p.rental_id, p.payment_id FROM payment p WHERE p.amount <= ALL(SELECT p1.amount FROM payment p1 WHERE p.payment_id<>p1.payment_id) ORDER BY p.rental_id 
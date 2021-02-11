USE sakila;
SELECT e.film_id,e.title FROM film e WHERE e.rental_rate<1;
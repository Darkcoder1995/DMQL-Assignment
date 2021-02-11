USE sakila;
SELECT a.title AS film_1, b.title AS film_2, a.length, a.rating FROM film a, film b WHERE a.FILM_ID > b.film_id AND a.length=b.length AND a.rating=b.rating;

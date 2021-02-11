USE sakila;
UPDATE customer SET active='0' WHERE first_name='MARIA' AND last_name='MILLER';
SELECT e.email,e.active FROM customer e WHERE e.first_name='MARIA' AND e.last_name='MILLER';


USE sakila;
INSERT INTO actor(first_name,last_name) VALUES ('KENNETH','OLIVIER');
SELECT e.first_name,e.last_name FROM actor e WHERE e.first_name='KENNETH';
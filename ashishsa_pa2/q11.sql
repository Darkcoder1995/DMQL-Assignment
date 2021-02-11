USE sakila;
SELECT i1.film_id AS 'f1', i2.film_id AS 'f2', count(*) AS 'cnt' FROM rental r1, rental r2, inventory i1,inventory i2
where r1.customer_id = r2.customer_id and
r1.inventory_id = i1.inventory_id and
r2.inventory_id = i2.inventory_id and
i1.film_id <> i2.film_id and
(i2.film_id and i1.film_id) in 
(select i3.film_id from rental r3, inventory i3 where
r3.inventory_id = i3.inventory_id and
r1.customer_id = r3.customer_id and
i1.film_id<>i3.film_id and
i2.film_id<>i3.film_id and
DATEDIFF(r2.rental_date,r1.rental_date) < DATEDIFF(r3.rental_date,r1.rental_date) and 
DATEDIFF(r3.rental_date,r2.rental_date) < DATEDIFF(r3.rental_date,r1.rental_date))
group by i1.film_id,i2.film_id
order by cnt desc,f1 asc,f2 asc;



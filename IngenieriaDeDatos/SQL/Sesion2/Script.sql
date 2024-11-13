
-- seleccionar todas las columnas de la tabla actor
select * 
from actor 

--seleccionar dos columnas de la tabla actor
select first_name, last_name 
from actor

--renombrar las columnas (uso del as)
select first_name as nombre, last_name as apellido 
from actor

--intentar siempre poner alias a las tablas, en cambio renombrar columnas no es necesario

--se pueden hacer calculos de diferentes columnas de una tabla (en este caso poner nombre a la columna es necesario)
select title, rental_rate, replacement_cost, rental_rate + replacement_cost as operacion 
from public.film 

--funciones: round, avg, mod, floor...
select avg(rental_duration)
from film 

--ejercicio 1 
select title, rental_rate,replacement_cost, round((rental_rate/replacement_cost)*100,2) as percentage 
from public.film

--aquí he concatenado un numero que el rental_duration con un caracter de texto
select concat((rental_duration)::varchar,'%'), film_id  
from film 

--ejercicio 2 
select title, rental_rate, replacement_cost, ceil(replacement_cost/rental_rate) as alquiler 
from public.film 

--ejercicio 3
select count(inventory_id) as inventario 
from public.inventory 

select count(film_id) as numero_peliculas, max(replacement_cost), min(replacement_cost), avg(replacement_cost) as media,stddev(replacement_cost) as variabilidad 
from public.film

--ejercicio 4 (peliculas que cuestan menos de 5€ alquilarlas)
select *
from public.film 
where rental_rate <5

--ejercicio 5 
select *
from public.film 
where rental_rate between 2 and 6

select *
from public.film
where film.title like 'J%'

--HAY MUCHOS USOS CON EL WHERE MIRAR EN DIAPOSITIVAS
--Los nulos siempre intentar controlarlos
select first_name as nombre_actor
from public.actor 
where first_name ilike 'a%'

--ilike no distinge entre mayuscula y minuscula y like si distingue
select rental_rate
from public.film 
where rental_rate > 4

select title, rental_rate as alquiler_pelicula
from public.film 
where rental_rate between 2 and 6

select title, rental_rate as alquiler_pelicula, length  as duracion
from public.film 
where rental_rate < 5 and length < 100

--ejercicio 4
select title, rental_rate as precio_alquiler
from public.film 
where title like 'Gi%'

select title, rating, length as duracion
from public.film 
where title like 'Ali Forever'

select title, rental_rate as precio_alquiler
from public.film 
where rental_rate is null  

--ordenar columnas --> orden by
-- limit es de la secuencia que te he puesto dame un numero finito de resultados limit 2 te dará los dos mejores de la sentencia

select title, length as duracion
from public.film
order by length asc 

select title, length as duracion
from public.film
order by length asc 
limit 5

--pelicula más cara por minuto
select title, length as duracion, rental_rate as coste_alquiler, (rental_rate/length) as coste_minuto
from public.film 
order by coste_minuto desc 
limit 1

-- pelicula más antigua cuyo precio alquiler no sobrepase 3€
select title, rental_rate as coste_alquiler, release_year as año_lanzamiento
from public.film 
where rental_rate < 3
order by año_lanzamiento asc 
limit 4

--uso del group by 
select  rating, count(rating), avg(rental_rate) as precio_medio_alquiler, min(rental_rate) as coste_minimo, max(rental_rate) as coste_maximo, avg(rental_duration) as duracion_media,min(release_year) as mas_antigua,max(release_year) as mas_nueva
from public.film 
group by rating 

select  rating, count(rating), avg(rental_rate) as precio_medio_alquiler, min(rental_rate) as coste_minimo, max(rental_rate) as coste_maximo, avg(rental_duration) as duracion_media,min(release_year) as mas_antigua,max(release_year) as mas_nueva
from public.film 
group by rating
having count(rating) > 200

select  rating, count(rating), avg(rental_rate) as precio_medio_alquiler, min(rental_rate) as coste_minimo, max(rental_rate) as coste_maximo, avg(rental_duration) as duracion_media,min(release_year) as mas_antigua,max(release_year) as mas_nueva
from public.film 
where rental_rate >1
group by rating
having count(rating) > 130

select  rating, count(rating) as numero_peliculas
from public.film 
group by rating 
having count(rating) > 200

select  rating, avg(rental_rate) 
from film 
group by rating 
having avg(rental_rate) between 1 and 3

select  rating, avg(length) as media_duracion
from film 
group by rating 
having avg(length) between 115 and 200

select  rating
from film 
group by rating 
HAVING rating::text like 'P%'

-- aquí estamos haciendo join para obtener los clientes del videoclub, su dirección, su país y su ciudad
SELECT c.customer_id,c.first_name, c.last_name , a.address, b.city, d.country
FROM address a
LEFT JOIN customer c on a.address_id  = c.address_id 
LEFT JOIN city b on b.city_id  = a.city_id 
LEFT JOIN country d on d.country_id  = b.country_id 


--aquí estoy contando los clientes de cada pais --> habría sido mejor poner en el from los clientes
select d.country_id , d.country , count(c.customer_id) as numero_clientes
FROM address a
LEFT JOIN customer c on a.address_id  = c.address_id 
LEFT JOIN city b on b.city_id  = a.city_id 
LEFT JOIN country d on d.country_id  = b.country_id 
group by d.country_id 


--ejercicio 9: de cada una de las peliculas saber que actores tienen con el apellido que empiece por c  --> si una pelicula no tiene actor no la quiero
select a.first_name , a.last_name , f.title 
from actor a  
inner join film_actor fa on a.actor_id  = fa.actor_id 
inner join film f on f.film_id =fa.film_id  
where a.last_name  like 'C%'

--¿Cuantos actores tiene cada pelicula?
select f.title , count(a.actor_id)  as numero_actores
from actor a  
inner join film_actor fa on a.actor_id  = fa.actor_id 
inner join film f on f.film_id =fa.film_id  
group by f.film_id 

--¿Cuales son las peliculas que tienen más de dos actores?
select f.title , count(a.actor_id)  as numero_actores
from actor a  
inner join film_actor fa on a.actor_id  = fa.actor_id 
inner join film f on f.film_id =fa.film_id  
group by f.film_id 
having count(a.actor_id)> 2

--¿Cual es la pelicula que tiene más actores?
select f.title , count(a.actor_id)  as numero_actores
from actor a  
inner join film_actor fa on a.actor_id  = fa.actor_id 
inner join film f on f.film_id =fa.film_id  
group by f.film_id 
order by 2 desc  
limit 1

--crear tablas
--crear tabla : reviews_yael
CREATE TABLE public.reviews_yael(
film_id serial4 NOT NULL,
customer_id serial4 NOT NULL,
review_date timestamp NOT NULL,
review_description varchar(200) NOT NULL DEFAULT now(),
CONSTRAINT reviews_yael_pkey PRIMARY KEY (film_id,customer_id)
)

--asignar valores a esa tabla
insert INTO public.reviews_ines
(film_id,customer_id,review_date,review_description)
VALUES (4, 7, '10-11-2023', 'La pelicula me ha encantado!! una comedia navideña muy entretenida ;)')

--asignar valores a esa tabla
insert INTO public.reviews_gabriela
(film_id,customer_id,review_date,review_description)
VALUES (4, 7, '10-11-2023', 'Me encantaaaaa!!!! Super emocionante')

--cambiar la descripcion del id 4 
update public.reviews_gabriela
set review_description = 'la pelicula no estaba tan bien como pensaba'
where film_id=4

--altert table --> cambiar algo de una tabla
alter table reviews_ines 
alter column review_description type varchar(850)

--renombrar una columna
ALTER TABLE reviews_gabriela 
RENAME COLUMN me_encanta_el_perico
TO hola

--eliminar columna
ALTER TABLE reviews_ines 
DROP COLUMN review_date

--cambiar un tipo de dato
ALTER TABLE reviews_gabriela 
ALTER COLUMN review_description TYPE varchar(100)

--eliminar una fila
delete 
from reviews_gabriela 
where customer_id = 7

--eliminar el contenido de una tabla 
delete 
from reviews_yael

--eliminar toda una tabla
DROP TABLE public.yael_larrosa

--ejecutar una vista
select * from actor_view_adg 

--crear una vista 
CREATE VIEW peliculas_actores AS
select f.title , count(a.actor_id)  as numero_actores
from actor a  
inner join film_actor fa on a.actor_id  = fa.actor_id 
inner join film f on f.film_id =fa.film_id  
group by f.film_id 
having count(a.actor_id)> 2

--para borrar una vista --> drop view

--SUBCONSULTAS

--Obtén haciendo una subconsulta en la cláusula WHERE, todas aquellas películas que están en el idioma de inglés
select film_id, title 
from public.film
where language_id in (select language_id
from public.language
where name = 'English') --en el in solo puede haber un elemento (una columna)

-- Obtén haciendo una subconsulta en la cláusula WHERE, todos aquellos clientes que viven en una dirección que empieza por 1
select *
from public.customer
where address_id in (select address_id
from public.address
where address like '3%')

--- Obtén haciendo una subconsulta en la cláusula WHERE, aquellos clientes que han se han gastado más de 190€

select customer_id
from public.customer
where customer_id in (select customer_id 
						from public.payment
						group by customer_id 
						having sum(amount) >190)
											
--obtener la suma de los pagos de los clientes que se han gastado más de 190€											
select sum(amount) as suma_total
from public.payment
where customer_id in (select customer_id
						from public.customer
						where customer_id in (select customer_id 
											from public.payment
											group by customer_id 
											having sum(amount) >190))
											
--nombre del cliente que ha comprado
select first_name, last_name
from customer
where customer_id in (
			select customer_id
			from payment
			group by customer_id
			having sum(amount)=
					(select sum(amount)
					from payment
					group by customer_id 
					order by sum(amount) desc limit 1
					))
					
--estructura de subconsultas más escalables --> Clausula with

--Obtén haciendo una subconsulta en la cláusula WITH  La suma de los amount que de los clientes que han pagado más de 190€, El número de clientes que han pagado más de 190€

--El número de clientes que han pagado más de 190€
with my_sub_query1 as ( 
select customer_id 
from public.payment
group by customer_id 
having sum(amount) >190)select count(customer_id) from my_sub_query1


--Obtén haciendo una subconsulta en la cláusula WITH  La suma de los amount que de los clientes que han pagado más de 190€,
with my_sub_query2 as ( 
select sum(amount) as suma_cliente
from public.payment
group by customer_id 
having sum(amount) >190)select sum(suma_cliente) as suma_total from my_sub_query2



--el numero de veces que un cliente ha alquilado una pelicula en elño 2005 y en el 2006

with msq1 as (
select count(rental_id) as cuentas, customer_id
from rental 
group by customer_id
having rental_date like ('2005%' or '2006%')) select customer_id,cuentas from msq1 --mal


--numero de veces que un cliente ha alquilado una pelicula
with msq1 as (
select r.rental_id, c.customer_id , c.first_name, f.film_id ,f.title 
FROM customer c
LEFT JOIN rental r on c.customer_id  = r.customer_id
left join inventory i on i.inventory_id = r.inventory_id
left join film f on f.film_id = i.film_id
)
select customer_id, first_name, film_id, title, count(rental_id)
from msq1
group by customer_id, film_id, first_name, title

--union on poder unir dos o mas tablas de datos sin duplicados (que no hayan columnas repetidas) union all es unir todo (incluso datos duplicados)
select * from film
union
select * from customer





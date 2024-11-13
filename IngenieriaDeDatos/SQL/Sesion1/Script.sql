
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





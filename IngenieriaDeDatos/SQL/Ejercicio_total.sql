--Ejercicio 1 : ¿Qué porcentaje supone el coste de alquiler sobre el coste de reemplazar?
--Ofrece un resultado redondeado a 2 decimales y renombra la columna.

select film_id, title, round((rental_rate/replacement_cost)*100, 2) as relacion_precio_coste
from public.film 

--Ejercicio 2: ¿Cuántas veces tienen que alquilar cada película para igualar o superar el coste de reemplazarla película?
--Da un resultado entero y renombra la nueva columna.

select title, rental_rate ,replacement_cost ,ceil(replacement_cost/rental_rate) as veces_recuperar
from public.film 

--Ejercicio: ¿Cuántas películas disponibles(que tienen en la empresa --> es decir, el inventario)?
select count(inventory_id) as inventario
from public.inventory 

--Ejercicio:  ¿Cual es la película a alquilar más cara? ¿Y la más barata? ¿Cual es elprecio medio de alquiler? ¿Qué variabilidad de precios tenemos?
select  max(rental_rate) as pelicula_mas_cara, min(rental_rate) as pelicula_mas_barata,avg(rental_rate) as precio_medio_alquiler, round(variance(rental_rate),2) as variabilidad_precios 
from public.film 

--Ejercicio: Muéstrame todos los datos de la película llamada Academy Dinosaur
select *
from public.film f 
where title = 'Academy Dinosaur'

--Ejercicio: Muéstrame todas las películas que cueste menos de 5€ alquilarlas
select title, rental_rate 
from public.film  
where film.rental_rate < 5

--Ejercicio 3: ¿Cómo se llaman los actores que empiezan por la letra A?
select first_name, last_name 
from actor 
where first_name like 'A%'

--Ejercicio 3: ¿Cuales son las películas que podemos alquilar por más de 4€? 
select film_id, title, rental_rate
from film 
where rental_rate > 4

--Ejercicio 3: ¿Cuantas películas podemos alquilar entre 2 y 4 euros?
select COUNT(film_id) as numero_peliculas_rango
from film 
where rental_rate between 2 and 4

--Ejercicio 3: ¿Cuantas películas podemos alquilar por menos de 5€ y con una duración menor a 100 minutos? 
select COUNT(film_id) as numero_peliculas_condiciones
from film 
where rental_rate < 5 and length < 100

--Ejercicio 4: ¿Qué precio de alquiler tienen las siguientes películas? Giant Troopers Gilbert Pelican Gilmore Boiled
select title, rental_rate
from film 
where title = 'Giant Troopers' or title = 'Gilbert Pelican' or title = 'Gilmore Boiled'

--Ejercicio 4: ¿Qué rating tiene la película Ali Forever? ¿Cuánta es su duración?
select title, rating, length
from film 
where title = 'Ali Forever'

--Ejercicio 4: ¿Nos falta por informar algún precio de alquiler en nuestra base de datos?
select film_id, title, rental_rate
from film 
where rental_rate  is null 

--Ejercicio 5: obtener un listado de las películas por orden de duración (de menos duración a más duración)
select film_id, title, length as duracion
from film 
order by length  asc 

--Ejercicio 5:  Quiere conocer los títulos de las 5 películas más cortas del videoclub
select title, length as duracion 
from film 
order by length asc
limit 5

--Ejercicio 6: Obten por ‘rating’:  El número de películas  El precio medio de alquiler  El mínimo precio de alquiler  El máximo precio de alquiler  La duración media de las películas

select rating, count(film_id) as numero_peliculas, round(avg(rental_rate),2) as precio_medio, min(rental_rate) as precio_min, 
max(rental_rate) as precio_max,avg(length) as duracion_media 
from film 
group by rating 

--Ejercicio 7: ¿Los precios de alquiler de las películas son mayores cuanto mayor es la duración?
select title, rental_rate, length as duracion
from film 
order by length desc 

-- Ejercicio 7: ¿Los precios de alquiler de las películas son mayores cuanto mayor es el coste de reemplazo?
select title, rental_rate, replacement_cost
from film 
order by replacement_cost desc 

--Ejercicio 7: Obten por ‘rating’: El número de películas y quédate únicamente con aquellos rating que tengan más de 200 películas
select rating, count(film_id) as numero_peliculas
from film 
group by rating
having count(film_id) > 200

--Ejercicio 7: El precio medio de alquiler y quédate únicamente con aquellos rating que tenga un precio medio superior a 3

select rating, round(avg(rental_rate),2) as media_precio
from film 
group by rating 
having avg(rental_rate)  > 3

--Ejercicio 7:La duración media de las películas y quédate con aquellos rating que tengan una duración media mayor a 115 minutos

select rating, round(avg(length),2) as duracion_media
from film 
group by rating 
having avg(length)  > 115

-- Ejercicio 8: Obtén las direcciones de aquellos clientes de nuestro videoclub
select c.customer_id , c.first_name , a.address 
from customer c
left join address a on c.address_id = a.address_id 

--Ejercicio 8: Ahora, añade las ciudades de las que son nuestros clientes
select c.customer_id , c.first_name , a.address , c2.city 
from customer c
left join address a on c.address_id = a.address_id 
left join city c2 on c2.city_id = a.city_id 

--Ejercicio 9: Obtén solamente las películas que tienen un actor que tenga un apellido que empiece por la letra “C”

select a.first_name , a.last_name , f.title 
from actor a  
inner join film_actor fa on a.actor_id  = fa.actor_id 
inner join film f on f.film_id =fa.film_id  
where a.last_name  like 'C%'

--Ejercicio 9: ¿Cuántos actores tiene cada película?
select f.title , count(a.actor_id) as numero_actores
from film f
left join film_actor fa on fa.film_id = f.film_id 
left join actor a on a.actor_id  = fa.actor_id  
group by f.film_id  

--Ejercicio 9: ¿Cuáles son las películas que tienen más de 2 actores?
select f.title , count(a.actor_id) as numero_actores
from film f
left join film_actor fa on fa.film_id = f.film_id 
left join actor a on a.actor_id  = fa.actor_id  
group by f.film_id  
having  count(a.actor_id) > 2


--Ejercicio 9:¿Cual es la película que tiene más actores?
select f.title , count(a.actor_id) as numero_actores
from film f
left join film_actor fa on fa.film_id = f.film_id 
left join actor a on a.actor_id  = fa.actor_id  
group by f.film_id  
order by 2 desc 
limit 1

--Ejercicio 10: Crear tabla “reviews” seguido de la inicial de tu nombre y tu apellido con los siguientets campos:
-- ● film_id ● customer_id ● review_date ● review_description
create table if not exists public.reviews_Yael(
film_id serial4 not null,
customer_id serial4 not null,
review_date timestamp not null,
review_description varchar(400) not null,
constraint reviewsYael_pkey primary key (film_id,customer_id))

--Ejercicio 11: nserta la opinión del cliente en la tabla nueva que hemos creado
--Película con ID = 4, el cliente con ID = 7 ha dicho que “La película es un poco aburrida” y lo ha dicho hoy, 10-11-2023
insert into public.reviews_Yael (film_id,customer_id,review_date,review_description)
values (4,7,'10-11-2023','La película es un poco aburrida')

--Ejercicio 12: Cambia la opinión del cliente 7, que ha hecho de la película 4.La película es bastante divertida y para todo los públicos
update public.reviews_Yael
set review_description = 'La película es bastante divertida y para todo los públicos'
where film_id = 4 and customer_id = 7

--Ejercicio 13: Añade el número de estrellas que le darías a una película. Puedes llamarle “review_stars” y con datatype int2
alter table public.reviews_Yael
add review_stars int4 not null

--Ejercicio 13: Renombra la columna “review_description” a “review_opinion”
alter table public.reviews_Yael
rename column review_description 
to review_opinion

--Este cliente nos pide que borremos sus opiniones de nuestra base de datos, de manera que no queden registradas en la tabla
delete 
from public.reviews_Yael
where customer_id = 7

--Eliminar tabla reviews_yael
drop table public.reviews_Yael

--Obtén haciendo una subconsulta en la cláusula WHERE, todas aquellas películas que están en el idioma de inglés
select film_id , title , language_id 
from film f 
where language_id  in (select language_id 
					from language l
					where name = 'English')
					
--Obtén haciendo una subconsulta en la cláusula WHERE, todos aquellos clientes que viven en una dirección que empieza por 1
select first_name ,last_name 
from customer c 
where address_id in( select address_id
				from address a
				where address like '1%')

--Obtén haciendo una subconsulta en la cláusula WHERE, aquellos clientes que han se han gastado más de 190€
select first_name ,last_name 
from customer c 
where c.customer_id  in ( select customer_id 
					from payment p 
					group by customer_id 
					having sum(amount)>190)
					
--Obtén aquellos film_id que tienen más de un replacement_cost de 17€ y obtén el total de film_id.
with subquery1 as
(SELECT film_id, title, replacement_cost
FROM public.film
where replacement_cost>17)
select count(distinct  film_id) 
from subquery1 

--Obtén aquellos film_id que tienen más de un replacement_cost de 17€ y obtén el idioma de éstas películas.

with subquery1 as
(SELECT film_id, title, replacement_cost,language_id 
FROM public.film 
where replacement_cost>17)
select s.film_id, s.title,l.name 
from subquery1 s
left join language l on l.language_id = s.language_id


--Obtén haciendo una subconsulta en la cláusula WITH - La suma de los amount que de los clientes que han pagado más de 190€ - El número de clientes que han pagado más de 190€
with subquery1 as
(SELECT customer_id, sum(amount) as cantidad
FROM public.payment p 
group by customer_id
having sum(amount)>190)
select sum(s.cantidad) as cantidad_total
from subquery1 s

--Obtén haciendo una subconsulta en la cláusula WITH - El número de clientes que han pagado más de 190€
with subquery1 as
(SELECT customer_id, sum(amount) as cantidad
FROM public.payment p 
group by customer_id
having sum(amount)>190)
select count(s.customer_id) as cantidad_total
from subquery1 s






















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




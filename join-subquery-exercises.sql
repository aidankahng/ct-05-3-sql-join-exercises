--Question 1
-- List all customers with their addresses who live in Texas (use JOINs)
-- Need to use both address and customer tables join on address_id
SELECT c.first_name, c.last_name, a.district
FROM customer c
JOIN address a
ON a.address_id = c.address_id
WHERE a.district = 'Texas';

--first_name|last_name|district|
------------+---------+--------+
--Jennifer  |Davis    |Texas   |
--Kim       |Cruz     |Texas   |
--Richard   |Mccrary  |Texas   |
--Bryan     |Hardison |Texas   |
--Ian       |Still    |Texas   |


-- Question 2
-- List all payments of more than $7.00 with the customer’s first and last name
SELECT c.first_name, c.last_name, p.amount
FROM customer c
JOIN payment p
ON c.customer_id = p.customer_id
WHERE amount > 7;

--first_name|last_name   |amount|
------------+------------+------+
--Peter     |Menard      |  7.99|
--Peter     |Menard      |  7.99|
--Peter     |Menard      |  7.99|
--Douglas   |Graf        |  8.99|
--Ryan      |Salisbury   |  8.99|
--Ryan      |Salisbury   |  8.99|
--Ryan      |Salisbury   |  7.99|
--Roger     |Quintanilla |  8.99|
--Joe       |Gilliland   |  8.99|
-- ...


-- Question 3
-- Show all customer names who have made over $175 in payments (use subqueries)
-- Using JOINS
SELECT c.first_name, c.last_name, SUM(amount) AS total
FROM customer c 
JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name 
HAVING SUM(amount) > 175;

-- USING subqueries
SELECT *
FROM customer c 
WHERE customer_id IN (
	SELECT customer_id 
	FROM payment
	GROUP BY customer_id 
	HAVING SUM(amount) > 175
);


--customer_id|store_id|first_name|last_name|email                            |address_id|activebool|create_date|last_update            |active|
-------------+--------+----------+---------+---------------------------------+----------+----------+-----------+-----------------------+------+
--        137|       2|Rhonda    |Kennedy  |rhonda.kennedy@sakilacustomer.org|       141|true      | 2006-02-14|2013-05-26 14:49:45.738|     1|
--        144|       1|Clara     |Shaw     |clara.shaw@sakilacustomer.org    |       148|true      | 2006-02-14|2013-05-26 14:49:45.738|     1|
--        148|       1|Eleanor   |Hunt     |eleanor.hunt@sakilacustomer.org  |       152|true      | 2006-02-14|2013-05-26 14:49:45.738|     1|
--        178|       2|Marion    |Snyder   |marion.snyder@sakilacustomer.org |       182|true      | 2006-02-14|2013-05-26 14:49:45.738|     1|
--        459|       1|Tommy     |Collazo  |tommy.collazo@sakilacustomer.org |       464|true      | 2006-02-14|2013-05-26 14:49:45.738|     1|
--        526|       2|Karl      |Seal     |karl.seal@sakilacustomer.org     |       532|true      | 2006-02-14|2013-05-26 14:49:45.738|     1|


-- Question 4
-- List all customers that live in Argentina (use multiple joins)
SELECT c.first_name, c.last_name, a.district, cty.city, ctry.country 
FROM customer c
JOIN address a
ON a.address_id = c.address_id
JOIN city cty
ON cty.city_id = a.city_id 
JOIN country ctry
ON ctry.country_id = cty.country_id
WHERE ctry.country = 'Argentina';


--first_name|last_name|district    |city                |country  |
------------+---------+------------+--------------------+---------+
--Willie    |Markham  |Buenos Aires|Almirante Brown     |Argentina|
--Jordan    |Archuleta|Buenos Aires|Avellaneda          |Argentina|
--Jason     |Morrissey|Buenos Aires|Baha Blanca         |Argentina|
--Kimberly  |Lee      |Crdoba      |Crdoba              |Argentina|
--Micheal   |Forman   |Buenos Aires|Escobar             |Argentina|
--Darryl    |Ashcraft |Buenos Aires|Ezeiza              |Argentina|
--Julia     |Flores   |Buenos Aires|La Plata            |Argentina|
--Florence  |Woods    |Buenos Aires|Merlo               |Argentina|
--Perry     |Swafford |Buenos Aires|Quilmes             |Argentina|
--Lydia     |Burke    |Tucumn      |San Miguel de Tucumn|Argentina|
--Eric      |Robert   |Santa F     |Santa F             |Argentina|
--Leonard   |Schofield|Buenos Aires|Tandil              |Argentina|
--Willie    |Howell   |Buenos Aires|Vicente Lpez        |Argentina|


-- Question 5
-- Show all the film categories with their count in descending order
-- JOIN film and film_category and category
SELECT c.category_id , c."name", COUNT(*) AS num_movies_in_category
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id 
JOIN category c
ON c.category_id = fc.category_id
GROUP BY c.category_id, c."name"
ORDER BY COUNT(*) DESC;


--category_id|name       |num_movies_in_cat|
-------------+-----------+-----------------+
--         15|Sports     |               74|
--          9|Foreign    |               73|
--          8|Family     |               69|
--          6|Documentary|               68|
--          2|Animation  |               66|
--          1|Action     |               64|
--         13|New        |               63|
--          7|Drama      |               62|
--         14|Sci-Fi     |               61|
--         10|Games      |               61|
--          3|Children   |               60|
--          5|Comedy     |               58|
--          4|Classics   |               57|
--         16|Travel     |               57|
--         11|Horror     |               56|
--         12|Music      |               51|



-- Question 6
-- What film had the most actors in it (show film info)?
-- Use film_actor and film
SELECT f.film_id, f.title, COUNT(*) AS num_actors
FROM film f
JOIN film_actor fa
ON f.film_id = fa.film_id 
GROUP BY f.film_id, f.title
ORDER BY COUNT(*) DESC
LIMIT 1;


--film_id|title           |num_actors|
---------+----------------+----------+
--    508|Lambs Cincinatti|        15|


-- Question 7 
-- Which actor has been in the least movies?
SELECT a.actor_id, a.first_name, a.last_name, COUNT(*) AS num_films
FROM actor a
JOIN film_actor fa
ON a.actor_id = fa.actor_id 
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY COUNT(*) ASC
LIMIT 1;


--actor_id|first_name|last_name|num_films|
----------+----------+---------+---------+
--     148|Emily     |Dee      |       14|


-- Question 8
-- Which country has the most cities?
SELECT c.country_id, c.country, COUNT(*) AS num_cities
FROM country c
JOIN city city
ON city.country_id = c.country_id
GROUP BY c.country_id, c.country
ORDER BY COUNT(*) DESC
LIMIT 10;

-- ANSWER: India has the most cities

--country_id|country                              |num_cities|
------------+-------------------------------------+----------+
--        44|India                                |        60|
--        23|China                                |        53|
--       103|United States                        |        35|


-- Question 9
-- List the actors who have been in between 20 and 25 films.
SELECT actor_id, first_name, last_name, num_films
FROM (
	SELECT a.actor_id, a.first_name, a.last_name, COUNT(*) AS num_films
	FROM actor a
	JOIN film_actor fa
	ON a.actor_id = fa.actor_id 
	GROUP BY a.actor_id, a.first_name, a.last_name
	ORDER BY COUNT(*) ASC
) AS film_counts
WHERE num_films BETWEEN 20 AND 25;


--actor_id|first_name |last_name  |count|
----------+-----------+-----------+-----+
--     114|Morgan     |Mcdormand  |   25|
--     153|Minnie     |Kilmer     |   20|
--      32|Tim        |Hackman    |   23|
--     132|Adam       |Hopper     |   22|
--      46|Parker     |Goldberg   |   24|
--     163|Christopher|West       |   21|
--...

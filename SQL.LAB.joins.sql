SELECT *
FROM sakila.category;

SELECT *
FROM sakila.film_category;

# 1 List the number of films per category.
SELECT category_id, COUNT(film_id)
FROM sakila.film_category
GROUP BY category_id;

# 2 Retrieve the store ID, city, and country for each store.
SELECT store_id, address_id
FROM sakila.store;
SELECT *
FROM sakila.country;
SELECT *
FROM sakila.city;
SELECT *
FROM sakila.address;


SELECT store_id, address_id, city_id, country.country_id, country.country
FROM sakila.country
INNER JOIN
	(SELECT store_id, address_id, sakila.city.city_id, city.country_id
	FROM sakila.city
	INNER JOIN
		(SELECT store_id, city_id, sakila.address.address_id
		FROM sakila.address
		INNER JOIN
			(SELECT store_id, address_id
			FROM sakila.store) AS store_address
		ON sakila.address.address_id = store_address.address_id) AS store_by_city
	ON sakila.city.city_id = store_by_city.city_id) AS store_by_country
ON sakila.country.country_id = store_by_country.country_id;



# 3 Calculate the total revenue generated by each store in dollars.
SELECT *
FROM sakila.payment;

SELECT *
FROM sakila.store;

SELECT store_id, ROUND(SUM(sakila.payment.amount + "$"),2) AS total_revenue$
FROM sakila.payment
INNER JOIN sakila.staff
ON sakila.payment.staff_id = sakila.staff.staff_id
GROUP BY store_id;

# 4 Determine the average running time of films for each category.

SELECT category_id, AVG(film.length)
FROM sakila.film
INNER JOIN sakila.film_category
ON sakila.film.film_id = sakila.film_category.film_id
GROUP BY category_id; 

# 5 Identify the film categories with the longest average running time.

SELECT category_id, AVG(film.length)
FROM sakila.film
INNER JOIN sakila.film_category
ON sakila.film.film_id = sakila.film_category.film_id
GROUP BY category_id
ORDER BY AVG(film.length) DESC
LIMIT 3;

# 6 Display the top 10 most frequently rented movies in descending order.

#### ???????   #####

SELECT film.title, film.film_id, COUNT(rentals.inventory_id)
FROM sakila.film
INNER JOIN
	(SELECT *
    FROM sakila.inventory
	INNER JOIN sakila.rental
	ON sakila.inventory.inventory_id = sakila.rental.inventory_id) AS rentals
ON sakila.film.film_id = sakila.rentals.film_id;

#ORDER by rental.inventory_id DESC

# 7 Determine if "Academy Dinosaur" can be rented from Store 1.


SELECT film.film_id, film.title, inventory_id, store_id
FROM sakila.film
INNER JOIN
	(SELECT inventory.inventory_id, store_id, film_id
	FROM sakila.inventory
	INNER JOIN
		(SELECT inventory_ID
		FROM sakila.rental
		WHERE return_date > rental_date) AS available
	ON sakila.inventory.inventory_ID = available.inventory_ID) available_by_store
ON sakila.film.film_id = sakila.available_by_store.film_id
WHERE film.title LIKE "%demy _inosa%"
AND store_id = 1; 




#SELECT store_id, film_id, inventory_id
#FROM sakila.inventory;

#SELEC


#FROM sakila.film
#INNER JOIN sakila.film_category
#ON film.film_id = film_category.film_id
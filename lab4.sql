-- LAB | SQL Joins
-- SQL Joins Lab for Sakila Database

-- 1. List the number of films per category.
SELECT 
    c.name AS category_name,
    COUNT(f.film_id) AS number_of_films
FROM 
    category c
JOIN 
    film_category fc ON c.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
GROUP BY 
    c.category_id, c.name;

-- 2. Retrieve the store ID, city, and country for each store.
SELECT 
    s.store_id,
    a.city,
    co.country
FROM 
    store s
JOIN 
    address a ON s.address_id = a.address_id
JOIN 
    city ci ON a.city_id = ci.city_id
JOIN 
    country co ON ci.country_id = co.country_id;

-- 3. Calculate the total revenue generated by each store in dollars.
SELECT 
    s.store_id,
    SUM(p.amount) AS total_revenue
FROM 
    store s
JOIN 
    staff st ON s.store_id = st.store_id
JOIN 
    payment p ON st.staff_id = p.staff_id  -- Fixed join logic
GROUP BY 
    s.store_id;

-- 4. Determine the average running time of films for each category.
SELECT 
    c.name AS category_name,
    ROUND(AVG(f.length), 2) AS average_running_time  -- Rounded to two decimal places
FROM 
    category c
JOIN 
    film_category fc ON c.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
GROUP BY 
    c.category_id, c.name;

-- Bonus: Identify the film categories with the longest average running time.
SELECT 
    c.name AS category_name,
    AVG(f.length) AS average_running_time
FROM 
    category c
JOIN 
    film_category fc ON c.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
GROUP BY 
    c.category_id, c.name
ORDER BY 
    average_running_time DESC
LIMIT 1;  -- Only show the category with the longest average

-- Bonus: Display the top 10 most frequently rented movies in descending order.
SELECT 
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM 
    film f
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    f.film_id, f.title
ORDER BY 
    rental_count DESC
LIMIT 10;

-- Bonus: Determine if "Academy Dinosaur" can be rented from Store 1.
SELECT 
    f.title,
    CASE 
        WHEN i.inventory_id IS NOT NULL THEN 'Available'
        ELSE 'NOT available'
    END AS availability
FROM 
    film f
LEFT JOIN 
    inventory i ON f.film_id = i.film_id AND i.store_id = 1
WHERE 
    f.title = 'Academy Dinosaur';

-- Bonus: Provide a list of all distinct film titles with availability status.
SELECT 
    f.title,
    CASE 
        WHEN i.inventory_id IS NOT NULL THEN 'Available'
        ELSE 'NOT available'
    END AS availability_status
FROM 
    film f
LEFT JOIN 
    inventory i ON f.film_id = i.film_id
GROUP BY 
    f.film_id, f.title;  -- Added this query

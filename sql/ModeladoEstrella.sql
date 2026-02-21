CREATE VIEW dim_customer AS 
SELECT DISTINCT 
	customer_id,
    customer_name,
    segment
FROM sales;

CREATE VIEW dim_product AS
SELECT 
	ROW_NUMBER() OVER(ORDER BY product_id, product_name, category, sub_category) AS product_key,
    product_id,
    product_name,
    category,
    sub_category
FROM (
	SELECT DISTINCT 
		product_id, 
		product_name,
		category,
		sub_category
	FROM sales
) dp;

CREATE VIEW dim_location AS
SELECT 
	ROW_NUMBER() OVER(ORDER BY country, region, state, city, postal_code) AS location_id,
	country,
    region,
    state,
    city,
    postal_code
FROM (
	SELECT DISTINCT 
		country,
		region,
		state,
		city,
		postal_code
	FROM sales
) dl;

CREATE VIEW dim_ship_mode AS
SELECT
	ROW_NUMBER() OVER(ORDER BY ship_mode) AS ship_mode_id,
    ship_mode
FROM (
SELECT DISTINCT ship_mode
FROM sales
)dsm;

CREATE VIEW dim_date AS 
SELECT DISTINCT
	date,
    YEAR(date) AS year,
    MONTH(date) AS month,
    DAY(date) AS day,
    MONTHNAME(date) AS month_name,
    DAYNAME(date) AS day_name
FROM (
	SELECT order_date AS date FROM sales
    UNION 
    SELECT ship_date AS date FROM sales
) d; 


CREATE VIEW fact_sales AS
SELECT
    s.row_id,
    s.order_id,
    s.customer_id,
    dp.product_key,
    dsm.ship_mode_id,
    DATE(s.order_date) AS order_date,
    DATE(s.ship_date) AS ship_date,
    dl.location_id,
    s.sales,
    s.quantity,
    s.discount,
    s.profit
FROM sales s
JOIN dim_location dl
	ON s.country = dl.country
    AND s.region = dl.region
    AND s.state = dl.state
    AND s.city = dl.city
    AND s.postal_code = dl.postal_code
    
JOIN dim_product dp
	ON s.product_id = dp.product_id
    AND s.product_name = dp.product_name
    AND s.category = dp.category
    AND s.sub_category = dp.sub_category
    
JOIN dim_ship_mode dsm
	ON s.ship_mode = dsm.ship_mode;

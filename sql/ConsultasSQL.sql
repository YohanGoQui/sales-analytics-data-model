# Ventas por país
SELECT country, SUM(sales) AS total_sales
FROM sales
GROUP BY country
ORDER BY total_sales DESC;

# Top 10 clientes
SELECT customer_name, SUM(sales) AS total_sales
FROM sales
GROUP BY customer_name
ORDER BY total_sales DESC
limit 10;

#Ranking clientes
SELECT customer_name, SUM(sales) AS total_sales,
RANK() OVER(ORDER BY SUM(sales) DESC) sales_rank
FROM sales
GROUP BY customer_name;

#Ventas mensuales CTE
WITH monthly_sales AS(
	SELECT 
		DATE_FORMAT(order_date, '%Y-%m') AS `month`,
        SUM(sales) AS total_sales
        FROM sales
        GROUP BY `month`
)
SELECT * 
FROM monthly_sales
ORDER BY `month`;

# Ventas totales
SELECT SUM(sales) AS total_sales
FROM sales;

# Ventas por región
SELECT region, SUM(sales) AS total_sales
FROM sales
GROUP BY region
ORDER BY total_sales DESC;

#Ventas por Categoría
SELECT category, SUM(sales) AS total_sales
FROM sales
GROUP BY category
ORDER BY total_sales DESC;



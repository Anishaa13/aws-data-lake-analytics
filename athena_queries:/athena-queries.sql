--sales_by_category

SELECT category, SUM(sales) AS total_sales
FROM orders_partitioned
GROUP BY category
ORDER BY total_sales DESC;


--top_products

SELECT product_name, SUM(sales) AS total_sales
FROM orders_partitioned
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;


--sales_profit_by_region

SELECT region, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM orders_partitioned
GROUP BY region
ORDER BY total_sales DESC;


--monthly_sales

SELECT order_month, SUM(sales) AS total_sales
FROM orders_partitioned
GROUP BY order_month
ORDER BY order_month;


--customer_sales

SELECT customer_id, COUNT(order_id) AS total_orders, SUM(sales) AS total_sales
FROM orders_partitioned
GROUP BY customer_id
ORDER BY total_sales DESC;

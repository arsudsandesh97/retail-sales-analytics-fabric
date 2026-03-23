-- Total Customers
-- How many customers exist?
SELECT 
COUNT(DISTINCT customer_id) AS total_customers
FROM fact_sales

-- Customer Value
-- Who are top customers?
SELECT 
    c.customer_name,
    SUM(f.sales) AS total_sales,
    RANK() OVER (ORDER BY SUM(f.sales) DESC) AS rank
FROM fact_sales f
JOIN dim_customer c ON f.customer_id = c.customer_id
GROUP BY c.customer_name

-- Customer Segmentation
-- How to segment customers by value?
WITH customer_spend AS (
    SELECT 
        c.customer_name,
        SUM(f.sales) AS total_spent
    FROM fact_sales f
    JOIN dim_customer c ON f.customer_id = c.customer_id
    GROUP BY c.customer_name
)
SELECT *,
    CASE 
        WHEN total_spent > 10000 THEN 'High Value'
        WHEN total_spent > 5000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS segment
FROM customer_spend

-- Repeat Customers
-- Which customers placed multiple orders?
SELECT customer_id, order_count
FROM (
    SELECT 
        customer_id,
        COUNT(order_id) AS order_count
    FROM fact_sales
    GROUP BY customer_id
) t
WHERE order_count > 1
ORDER BY order_count DESC




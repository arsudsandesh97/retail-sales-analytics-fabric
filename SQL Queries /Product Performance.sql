-- Sales by Category
-- Which categories drive revenue?
SELECT 
    p.category,
    ROUND(SUM(f.sales),2) AS total_sales
FROM fact_sales f
JOIN dim_product p 
ON f.product_id = p.product_id
GROUP BY p.category

-- Top Products
-- Which products generate highest sales?
SELECT *
FROM (
    SELECT 
        p.product_name,
        SUM(f.sales) AS total_sales,
        DENSE_RANK() OVER (ORDER BY SUM(f.sales) DESC) AS rank
    FROM fact_sales f
    JOIN dim_product p ON f.product_id = p.product_id
    GROUP BY p.product_name
) t
WHERE rank <= 10

-- Product Ranking
-- How do products rank by sales?
SELECT 
    p.product_name,
    ROUND(SUM(f.sales),2) AS total_sales,
    RANK() OVER (ORDER BY SUM(f.sales) DESC) AS product_rank
FROM fact_sales f
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY p.product_name

-- High Sales Low Profit
-- Which products are inefficient?
WITH product_performance AS (
    SELECT 
        p.product_name,
        ROUND(SUM(f.sales),2) AS total_sales,
        ROUND(SUM(f.profit),2) AS total_profit
    FROM fact_sales f
    JOIN dim_product p ON f.product_id = p.product_id
    GROUP BY p.product_name
)
SELECT *
FROM product_performance
WHERE total_sales > 5000 AND total_profit < 500



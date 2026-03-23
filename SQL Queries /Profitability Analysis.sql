-- Total Profit & Margin
-- What is overall profitability?
SELECT
    ROUND(SUM(profit),2) AS total_profit,
    ROUND(100*SUM(profit) / SUM(sales),2) AS profit_margin
FROM fact_sales

-- Profit by Category
-- Which categories contribute most to profit?
SELECT
    category,
    total_profit
FROM (
    SELECT
        p.category,
        ROUND(SUM(f.profit),2) AS total_profit
    FROM fact_sales f
    JOIN dim_product p
    ON f.product_id = p.product_id
    GROUP BY p.category) t
ORDER BY total_profit DESC

-- Profit Margin Ranking
-- Which categories are most efficient?
SELECT 
    p.category,
    SUM(f.profit) / SUM(f.sales) * 100 AS profit_margin,
    RANK() OVER (ORDER BY SUM(f.profit) / SUM(f.sales) DESC) AS rank
FROM fact_sales f
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY p.category

-- Loss Orders
-- How many orders are loss-making?
WITH loss_orders AS (
    SELECT *
    FROM fact_sales
    WHERE profit < 0
)
SELECT COUNT(*) AS total_loss_orders
FROM loss_orders

-- Discount vs Profit
-- How do discounts impact profit?
SELECT 
    discount,
    ROUND(AVG(profit),2) AS avg_profit
FROM fact_sales
GROUP BY discount


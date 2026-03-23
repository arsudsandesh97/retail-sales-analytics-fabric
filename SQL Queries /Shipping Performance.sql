-- Average Shipping Days
-- What is average delivery time?
SELECT AVG(shipping_days) AS Average_Delivery_Days 
FROM fact_sales

-- Shipping Delay Ranking
-- Which regions have highest delays?
SELECT 
    l.region,
    AVG(f.shipping_days) AS avg_shipping,
    RANK() OVER (ORDER BY AVG(f.shipping_days) DESC) AS delay_rank
FROM fact_sales f
JOIN dim_location l ON f.location_id = l.location_id
GROUP BY l.region

-- Delayed Orders
-- How many orders are delayed?
SELECT COUNT(*) AS Delayed_Orders
FROM (
    SELECT *
    FROM fact_sales
    WHERE shipping_days > 5
) t

-- Shipping Mode Analysis
-- Which shipping mode is fastest?
SELECT 
    s.ship_mode,
    AVG(f.shipping_days) AS avg_shipping
FROM fact_sales f
JOIN dim_shipping s ON f.ship_mode_id = s.ship_mode_id
GROUP BY s.ship_mode


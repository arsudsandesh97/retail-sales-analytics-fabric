# End-to-End Retail Sales Analytics using Microsoft Fabric, SQL & Power BI

---

# Project Overview
This project is an end-to-end Retail Sales Analytics solution built using Microsoft Fabric, SQL, and Power BI. It transforms raw transactional data into meaningful business insights through a modern data pipeline and interactive dashboards.

The goal is to enable data-driven decision-making by analyzing sales performance, profitability, shipping efficiency, and customer behavior.

**Business Value:**
- Improves visibility into sales and profit trends  
- Identifies high-performing products and regions  
- Optimizes shipping and delivery efficiency  
- Enhances customer segmentation and targeting  

---

# Problem Statement
Retail businesses often struggle with:

- **Lack of visibility into sales performance** across regions and categories  
- **Profitability challenges** due to hidden cost inefficiencies  
- **Shipping inefficiencies** impacting delivery timelines and customer satisfaction  
- **Customer insights gap**, making it difficult to identify high-value customers  

This project addresses these issues by building a centralized analytics solution.

---

## Dataset

| Attribute | Details |
|-----------|---------|
| Name | Superstore Retail Dataset |
| Source | Kaggle |
| Records | ~9,000 rows |
| Columns | ~20 |
| Type | Structured transactional data |
| Time Period | 2014–2017 |
| Key Columns | Order Date, Ship Date, Customer, Product, Sales, Profit |
| Derived Columns | shipping_days, profit_margin, profit_margin_pct |

---

## Stack

| Tool | What it does here |
|------|------------------|
| Microsoft Fabric | Lakehouse storage, Dataflow Gen2, Direct Lake semantic model |
| SQL | Analysis and querying via SQL endpoint |
| Power BI | Dashboards and KPI tracking |
| DAX | Calculated measures |
| Python (Pandas) | Cleaning and transformation in Fabric Notebooks |

---

## Pipeline

### Bronze — Raw ingestion
Raw CSV loaded directly into the Microsoft Fabric Lakehouse with no transformations. Original format preserved.

---

### Silver — Cleaning and transformation (Pandas in Fabric Notebook)

**Type fixes:**
- `order_date` and `ship_date` converted from object to datetime
- Ship Mode, Segment, Country, City, State, Region, Category, Sub-Category converted to category dtype (less memory, faster groupbys)
- Order ID, Customer ID, Product ID, Postal Code converted to string (stops Pandas from doing math on IDs)

**Column naming:**
All columns renamed to snake_case for consistent use across Pandas, SQL, and Power BI.

**New columns added:**
- `year` and `month` extracted from `order_date`
- `shipping_days` — difference between ship date and order date
- `profit_margin` and `profit_percentage` — for normalized profit comparisons

**Storage:**
Converted to Spark DataFrame, saved as a Delta Table (`silver_sales_cleaned`). Delta was the right call here — ACID transactions, time travel if something breaks, and it scales without fuss.

---

### Gold — Star schema modeling

**Fact table:** `fact_sales`

**Dimension tables:**
- `dim_customer`
- `dim_product`
- `dim_location`
- `dim_shipping`
- `dim_date`

One-to-many relationships between each dimension and the fact table.

---

### SQL Analysis (SQL Endpoint)

15+ queries covering:
- Product and sub-category performance
- Profitability by segment and region
- Shipping delays by mode and geography
- Customer revenue contribution

Techniques used: joins, aggregations, CTEs, window functions, subqueries.

---

### Semantic Model (Direct Lake)

Built on Fabric's Direct Lake mode — queries hit the Delta Tables directly instead of importing data into Power BI. No duplication, no refresh lag.

---

### DAX Measures

- Total Sales
- Total Profit
- Profit Margin %
- Average Order Value
- On-Time Delivery %

---

## Dashboard Pages

**Executive Overview** — Top-level KPIs at a glance

**Profitability Analysis** — Where margins are thin, where discounts are killing profit

**Shipping Performance** — Delay breakdown by region and ship mode

**Customer Insights** — Revenue by segment, top customers, repeat behavior

---

## What the Data Actually Said

- High sales numbers don't always mean high profit. A few sub-categories were consistently in the red.
- Discounts were applied unevenly. Some were appropriate; others just ate into margin with no corresponding volume benefit.
- Shipping delays clustered in specific regions and with specific ship modes — fixable with targeted logistics changes.
- A small group of customers drove a disproportionate share of revenue. They weren't being treated any differently.

---

## Architecture

![End-to-End Retail Sales Analytics using Microsoft Fabric Architecture](https://github.com/arsudsandesh97/retail-sales-analytics-fabric/blob/main/Assets/End-to-End%20Retail%20Sales%20Analytics%20using%20Microsoft%20Fabric.gif?raw=true)

---

## Screenshots

![Overview](https://github.com/arsudsandesh97/retail-sales-analytics-fabric/blob/main/Assets/Retail%20Sales%20Analytics_Page_1.jpg?raw=true)
![Profitability](https://github.com/arsudsandesh97/retail-sales-analytics-fabric/blob/main/Assets/Retail%20Sales%20Analytics_Page_2.jpg?raw=true)
![Shipping](https://github.com/arsudsandesh97/retail-sales-analytics-fabric/blob/main/Assets/Retail%20Sales%20Analytics_Page_3.jpg?raw=true)
![Customer](https://github.com/arsudsandesh97/retail-sales-analytics-fabric/blob/main/Assets/Retail%20Sales%20Analytics_Page_4.jpg?raw=true)

--



## Let's Connect

Built by **Sandesh Arsud**  -  Data Analyst with a focus on turning raw data into Insights

[LinkedIn](https://www.linkedin.com/in/sandesharsud) · [Portfolio](https://arsudsandesh97.github.io/)

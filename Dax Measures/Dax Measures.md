# Power BI DAX Measures 

## 📌 Measures

### Total Sales
```DAX
Total Sales = SUM(fact_sales[sales])
```

### Total Profit
```DAX
Total Profit = SUM(fact_sales[profit])
```

### Profit Margin %
```DAX
Profit Margin % = DIVIDE([Total Profit], [Total Sales])
```

### Average Order Value
```DAX
Average Order Value = DIVIDE([Total Sales], [Total Orders])
```

### Loss Orders
```DAX
Loss Orders = 
CALCULATE(
    COUNT(fact_sales[Order_ID]),
    fact_sales[Profit] < 0
)
```

### Average Profit Margin %
```DAX
Average Profit Margin % = AVERAGE(fact_sales[profit_margin])
```

### On-Time Delivery %
```DAX
On-Time Delivery % = 
DIVIDE(
    CALCULATE(
        COUNT(fact_sales[Order_ID]),
        fact_sales[shipping_days] <= 3
    ),
    [Total Orders]
)
```

### Average Shipping Days
```DAX
Average Shipping Days = AVERAGE(fact_sales[shipping_days])
```

### Late Deliveries
```DAX
Late Deliveries = 
CALCULATE(
    COUNT(fact_sales[Order_ID]),
    fact_sales[shipping_days] > 5
)
```

### Total Customers
```DAX
Total Customers = DISTINCTCOUNT(dim_customer[customer_id])
```

### Avg Revenue per Customer
```DAX
Avg Revenue per Customer = 
DIVIDE([Total Sales], [Total Customers])
```

### Customer Sales
```DAX
Customer Sales = SUM(fact_sales[Sales])
```

### Top Customer Sales
```DAX
Top Customer Sales = 
MAXX(
    VALUES(dim_customer[customer_name]),
    [Customer Sales]
)
```

### Profit and Sales Label Color
```DAX
Profit and Sales Label Color = 
SWITCH(
    TRUE(),
    [Total Profit] < 0, "#E74C3C",
    [Total Sales] > 50000, "#FF7849",
    [Total Sales] > 20000, "#FFB199",
    "#FFE0D6"
)
```

-- 🍕 Pizza Sales Analysis SQL Queries
-- Comprehensive analysis for business intelligence

-- =============================================
-- 1. BASIC KPIs
-- =============================================

-- Total Revenue
SELECT SUM(total_price) AS Total_Revenue 
FROM pizza_sales;

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales;

-- Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizzas_Sold 
FROM pizza_sales;

-- Average Order Value
SELECT 
    SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_Value 
FROM pizza_sales;

-- Average Pizzas Per Order
SELECT 
    CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
    CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) 
    AS Avg_Pizzas_Per_Order 
FROM pizza_sales;

-- =============================================
-- 2. TIME-BASED ANALYSIS
-- =============================================

-- Daily Order Trends
SELECT 
    DATENAME(DW, order_date) AS Order_Day,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)
ORDER BY Total_Orders DESC;

-- Monthly Order Trends
SELECT 
    DATENAME(MONTH, order_date) AS Month_Name,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Total_Orders DESC;

-- =============================================
-- 3. CATEGORY ANALYSIS
-- =============================================

-- Revenue by Pizza Category
SELECT 
    pizza_category,
    SUM(total_price) AS Total_Revenue,
    CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS Percentage
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Revenue DESC;

-- Revenue by Pizza Size
SELECT 
    pizza_size,
    SUM(total_price) AS Total_Revenue,
    CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS Percentage
FROM pizza_sales
GROUP BY pizza_size
ORDER BY Total_Revenue DESC;

-- Pizzas Sold by Category
SELECT 
    pizza_category,
    SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Pizzas_Sold DESC;

-- =============================================
-- 4. TOP & BOTTOM PERFORMERS
-- =============================================

-- Top 5 Pizzas by Revenue
SELECT TOP 5
    pizza_name,
    SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC;

-- Top 5 Pizzas by Quantity
SELECT TOP 5
    pizza_name,
    SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC;

-- Top 5 Pizzas by Total Orders
SELECT TOP 5
    pizza_name,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC;

-- Bottom 5 Pizzas by Revenue
SELECT TOP 5
    pizza_name,
    SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC;

-- Bottom 5 Pizzas by Quantity
SELECT TOP 5
    pizza_name,
    SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC;

-- Bottom 5 Pizzas by Total Orders
SELECT TOP 5
    pizza_name,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC;

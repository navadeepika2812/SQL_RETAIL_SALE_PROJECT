--**Retail Sales Analysis SQL Project**

--Step 1: Create Table

CREATE TABLE Retail_sales (
    Date DATE,
    Region VARCHAR(50),
    State VARCHAR(50),
    City VARCHAR(50),
    Product VARCHAR(100),
    Category VARCHAR(50),
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    TotalPrice DECIMAL(10,2)
);
--Step 2: Insert Data from CSV

BULK INSERT Retail_sales
FROM 'C:\Users\HP\Downloads\SQL - Retail Sales Analysis_utf .csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
--Step 3: View First 10 Records

SELECT * FROM Retail_sales
ORDER BY (SELECT NULL)
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;


--Data Cleaning
--Find records with NULL values in essential columns

SELECT * FROM Retail_sales
WHERE 
     transactions_id IS NULL OR 
     sale_date IS NULL OR
     sale_time IS NULL OR
     customer_id IS NULL OR 
     gender IS NULL OR 
     age IS NULL OR
     category IS NULL OR 
     quantiy IS NULL OR 
     price_per_unit IS NULL OR 
     cogs IS NULL OR
     total_sale IS NULL;
--Delete all records containing NULLs

DELETE FROM Retail_sales
WHERE 
     transactions_id IS NULL OR 
     sale_date IS NULL OR
     sale_time IS NULL OR
     customer_id IS NULL OR 
     gender IS NULL OR 
     age IS NULL OR
     category IS NULL OR 
     quantiy IS NULL OR 
     price_per_unit IS NULL OR 
     cogs IS NULL OR
     total_sale IS NULL;
--*Data Exploration*
--1. How many total sales are there?
SELECT COUNT(*) AS total_sales FROM Retail_sales;

--2. How many unique customers are there?

SELECT COUNT(DISTINCT customer_id) FROM Retail_sales;
--3.What categories are present in the data?
SELECT DISTINCT category FROM Retail_sales;


--*Data Analysis*
--1. What are the sales on 5th November 2022?
SELECT * FROM Retail_sales
WHERE sale_date = '2022-11-05';


--2. Show all transactions from the "Clothing" category with quantity ≥ 4 in November 2022
SELECT * FROM Retail_sales
WHERE category = 'clothing'
  AND quantiy >= 4
  AND YEAR(sale_date) = 2022
  AND MONTH(sale_date) = 11;


--3. Total sales by each category
SELECT category, SUM(total_sale) AS total_sales
FROM Retail_sales
GROUP BY category;

--4.Average age of customers who purchased items from the "Beauty" category
SELECT ROUND(AVG(age), 2) AS avg_age
FROM Retail_sales
WHERE category = 'Beauty';

--5.Transactions where total sale amount is greater than 1000
SELECT * FROM Retail_sales
WHERE total_sale > 1000;

--6. Number of transactions by gender within each category
SELECT category, gender, COUNT(transactions_id) AS number_of_trans
FROM Retail_sales
GROUP BY category, gender;


--7.Find the best selling month in each year (based on average sales)
--Solved using common table expression(CTE)
WITH month_avg AS (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sale
    FROM Retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
),
rank_month AS (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY year ORDER BY avg_sale DESC) AS rn
    FROM month_avg
)
SELECT year, month, avg_sale
FROM rank_month
WHERE rn = 1;


--8.Top 5 customers by total sales
SELECT TOP 5 customer_id, SUM(total_sale) AS sale
FROM Retail_sales
GROUP BY customer_id
ORDER BY sale DESC;

--9. Number of unique customers by category
SELECT COUNT(DISTINCT customer_id) AS customer, category
FROM Retail_sales
GROUP BY category;


--10.Categorize orders by shift (Morning, Afternoon, Evening) and count number of orders

SELECT 
  CASE 
    WHEN DATEPART(HOUR, sale_time) BETWEEN 6 AND 11 THEN 'Morning'
    WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    WHEN DATEPART(HOUR, sale_time) BETWEEN 18 AND 23 THEN 'Evening'
    ELSE 'Night'
  END AS Shift,
  COUNT(*) AS Number_of_Orders
FROM Retail_sales
GROUP BY 
  CASE 
    WHEN DATEPART(HOUR, sale_time) BETWEEN 6 AND 11 THEN 'Morning'
    WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    WHEN DATEPART(HOUR, sale_time) BETWEEN 18 AND 23 THEN 'Evening'
    ELSE 'Night'
  END;




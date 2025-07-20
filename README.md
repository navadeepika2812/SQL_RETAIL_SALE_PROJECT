# SQL_RETAIL_SALE_PROJECT

# 🛒 Retail Sales Analysis using SQL

This project focuses on analyzing retail sales data using SQL Server. The dataset contains information about customer transactions, products, sales, and more. The goal is to perform data cleaning, exploration, and generate business insights.

---

## 📂 Dataset Description

- **Fields Included:**
  - total_sale,price_per_unit,cogs
  - Product, Category
  - Quantity, Unit Price
  - Transaction ID, Customer ID, Age, Gender, Sale Date , Sale_time,

---

## ✅ Project Steps

### 1. Data Loading
- Created a SQL table
- Imported data using `BULK INSERT`

### 2. Data Cleaning
- Identified and removed records with NULLs in critical fields
- Checking for duplicates
- Checking the datatypes
- Checking for invalid values 
- Checking date & time fields

### 3. Data Exploration
- Total number of transactions
- Unique customers
- Available product categories

### 4. Data Analysis (Business Insights)
- Top 5 customers by total sales
- Sales trends by month and year
- High-value transactions (`> ₹1000`)
- Number of purchases by gender and category
- Average age of buyers in the "Beauty" category
- Number of customers by category
- Shift-based transaction analysis (Morning, Afternoon, Evening)

---

## 💡 Key Business Questions Answered

- What is the total sales count?
- Which categories generate the most revenue?
- Who are the top 5 customers?
- Which is the best-selling month each year?
- Are more sales happening in the morning, afternoon, or evening?

---

## 🛠️ Tools Used

- **Database**: SQL Server
- **Query Language**: T-SQL (Transact-SQL)

---

## 📌 How to Run

1. Clone the repository
2. Run `CREATE TABLE` script
3. Import CSV data using `BULK INSERT`
4. Execute queries in SQL Server Management Studio (SSMS)

---

## 📧 Contact

For feedback or questions, feel free to reach out!


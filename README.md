# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `Retail_Sales_db`

The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries.
## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup and Import data 

- **Database Creation**: The project starts by creating a database named `Retail_Sales_db`.
- **Import data**: The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.
### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```SQL
-- Check the data type
SELECT TOP(5) *
FROM Retail_Sales;
-- Check null value from our data
SELECT *
FROM Retail_Sales
WHERE 
      transactions_id IS NULL
   or sale_date IS NULL
   or sale_time IS NULL
   or customer_id is NULL
   or gender is NULL
    or category is NULL
   or quantiy is NULL
   or price_per_unit is NULL
   or cogs is NULL
   or total_sale is NULL;

-- We have to replace or delete the null value 
DELETE 
FROM Retail_Sales
WHERE 
      transactions_id IS NULL
   or sale_date IS NULL
   or sale_time IS NULL
   or customer_id is NULL
   or gender is NULL
    or category is NULL
   or quantiy is NULL
   or price_per_unit is NULL
   or cogs is NULL
   or total_sale is NULL;
   -- Data Exploration 
   -- How many sales record we have 
   SELECT COUNT(total_sale) AS Total_sales
   FROM Retail_Sales;
   -- How many unique customer we have 
   SELECT COUNT(DISTINCT customer_id) AS Total_Customer 
   FROM Retail_Sales;
   -- How many cathegory we have 
      SELECT COUNT(DISTINCT category) AS Total_cathegory
   FROM Retail_Sales;
    -- Product cathegory 
   SELECT DISTINCT category AS Product_cathegory
   FROM Retail_Sales;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **sales made on '2022-11-05**:
```sql
SELECT *
   FROM Retail_Sales
   WHERE sale_date= '2022-11-05'
   ORDER BY category;
```

2. **All transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT *
  FROM retail_sales
  WHERE category = 'Clothing'
      AND FORMAT(sale_date, 'yyyy-MM') = '2022-11'
      AND quantiy >= 4 ;
```

3. **-- Total sales (total_sale) for each category**:
```sql
SELECT
      category ,
      SUM(total_sale) AS Total_Sale ,
      COUNT(quantiy) AS Total_order 
FROM Retail_Sales
GROUP BY category;
```

4. **Average age of customers who purchased items from the 'Beauty' category**:
```SQL
SELECT AVG(age) AS Average_age  
	FROM Retail_Sales
	Where category='Beauty'
```

5. **All transactions where the total_sale is greater than 1000**:
```SQL
SELECT *
	FROM Retail_Sales
	WHERE total_sale > 1000
	ORDER BY total_sale;
```

6. **Total number of transactions (transaction_id) made by each gender in each category**:
```SQL
SELECT 
      category,
      gender,
 COUNT(*) as total_trans
 FROM retail_sales
 GROUP BY 
       category,
       gender ;
```

7. **Calculate the average sale for each month. Find out best selling month in each year**:
```SQL
SELECT * 
 FROM (
    SELECT 
        MONTH(sale_date) AS month,
        YEAR(sale_date) AS year,
        AVG(total_sale) AS avg_sale,
        ROW_NUMBER() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rank
    FROM 
        retail_Sales 
    GROUP BY 
        MONTH(sale_date), 
        YEAR(sale_date)
) AS T1
        WHERE rank = 1
        ORDER BY 
               year DESC, 
               avg_sale DESC;
```

8. **Top 5 customers based on the highest total sales **:
```SQL
SELECT TOP 5 
            customer_id ,
			SUM(total_sale) AS Total_sale 
FROM Retail_Sales 
GROUP BY customer_id
ORDER BY Total_sale DESC;
```

9. **Find the number of unique customers who purchased items from each category**:
```SQL
SELECT 
      COUNT(DISTINCT(customer_id)) AS unique_customers ,
	        category

 FROM Retail_Sales
 GROUP BY category;
```

10. **Create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```SQL
WITH Hourly_sale AS (
    SELECT 
        *,
        CASE 
            WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
            WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS Shift  
    FROM 
        Retail_Sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project covers database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Yonatan Abrham

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, or feedback  and would like to collaborate, feel free to get in touch!

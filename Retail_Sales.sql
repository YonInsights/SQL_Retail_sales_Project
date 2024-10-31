-- Data cleaning 
 
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
   -- Bussiness Cathegory 
   -- sales made on '2022-11-05:
   SELECT *
   FROM Retail_Sales
   WHERE sale_date= '2022-11-05'
   ORDER BY category;
   --All transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
  SELECT *
  FROM retail_sales
  WHERE category = 'Clothing'
      AND FORMAT(sale_date, 'yyyy-MM') = '2022-11'
      AND quantiy >= 4 ;
	-- Total sales (total_sale) for each category
	SELECT  category ,SUM(total_sale) AS Total_Sale ,COUNT(quantiy) AS Total_order 
	FROM Retail_Sales
	GROUP BY category;
	--Average age of customers who purchased items from the 'Beauty' category
	SELECT AVG(age) AS Average_age  
	FROM Retail_Sales
	Where category='Beauty'
	-- All transactions where the total_sale is greater than 1000
    SELECT *
	FROM Retail_Sales
	WHERE total_sale > 1000
	ORDER BY total_sale;
	-- Total number of transactions (transaction_id) made by each gender in each category
	SELECT 
          category,
          gender,
    COUNT(*) as total_trans
    FROM retail_sales
    GROUP BY 
            category,
            gender ;
   -- Calculate the average sale for each month. Find out best selling month in each year:
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
 -- Top 5 customers based on the highest total sales
 SELECT TOP 5 
            customer_id ,
			SUM(total_sale) AS Total_sale 
FROM Retail_Sales 
GROUP BY customer_id
ORDER BY Total_sale DESC;
-- Find the number of unique customers who purchased items from each category

 SELECT 
      COUNT(DISTINCT(customer_id)) AS unique_customers ,
	        category

 FROM Retail_Sales
 GROUP BY category;
 -- Create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
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

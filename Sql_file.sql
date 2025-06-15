-- Sql Retail sales analyses project 
CREATE DATABASE sql_project_p2;

-- Create table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales 
	(
		transactions_id INT PRIMARY KEY,
		sale_date DATE,	
		sale_time TIME,	
		customer_id INT,	
		gender VARCHAR(15),	
		age INT,	
		category VARCHAR(15),	
		quantiy INT,	
		price_per_unit FLOAT,
		cogs FLOAT,	
		total_sale FLOAT
	
	);
-- to count number of records
SELECT 
	COUNT(*)
FROM 
	retail_sales

-- checking for any null values in the table(Data Cleaning)
SELECT *
FROM
	retail_sales
WHERE
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	cogs IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL

-- deleting the null values
DELETE FROM 
	retail_sales
WHERE
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	cogs IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL

-- Data exploration
-- How many sales we have?
SELECT 		
	COUNT (*)
FROM
	retail_sales

-- How many unique customers we have
SELECT	
	COUNT(DISTINCT customer_id)
FROM 
	retail_sales


-- How many distinct catagories we have
SELECT 
	DISTINCT category
FROM
	retail_sales

-- Data Analysis and Business key problems & answers
-- 1. Write a sql query for reteriving all the columns for sales made on "2022-11-05"
SELECT *
FROM 
	retail_sales
WHERE
	sale_date = '2022-11-05'

-- 2. Write a sql query for reteriving all the transactions where the category is 'Clothing' and the quantity sold is equak to or more than 4 in the month of NOV-2022
SELECT *
FROM 
	retail_sales
WHERE
	category = 'Clothing' AND
	quantiy >= '4' AND
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'

-- 3. Write a sql query to calculate total_sale for each category
SELECT
	 category,
	SUM(total_sale)
FROM 
	retail_sales
GROUP BY
	category
	
-- 4.Write a sql query to calculate average age of customers who purchased items from 'Beauty' category
SELECT
	category,
	ROUND(AVG(age),2) AS Average_age    -- Round aggregate funtion for rounding upto 2 decimal places
FROM 
	retail_sales
WHERE 
	category = 'Beauty'
GROUP BY
	category

-- 5.Write a sql query to find all the transactions where the total_sales is greater than 10000
SELECT *
FROM 
	retail_sales
WHERE 
	total_sale > '1000'

-- 6.Write a sql query to find all the transactions (transaction_id) made by each gender in each category
SELECT
	category,
	gender,
	COUNT(*) as total_trans
FROM
	retail_sales
GROUP BY 
	category,
	gender

--  7. Write a sql query to calculate the average sale of each month.
SELECT
	EXTRACT (Year FROM sale_date) as year,
	EXTRACT (MONTH FROM sale_date) as month,
	AVG(total_sale) as Average_sales

FROM
	retail_sales
GROUP BY 
	year,
	month
ORDER BY
	year,
	month

-- 8. Write sql query to find top 5 customers based on the highest total sales 
SELECT 
	customer_id,
	SUM(total_sale) as total_customer_sales
FROM
	retail_sales
GROUP BY 
	customer_id
ORDER BY
	total_customers_sales
LIMIT 5

-- 9.Write sql query to find number of unique customers who purchased from each category
SELECT
	category,
	COUNT(DISTINCT(customer_id))
	
FROM
	retail_sales
GROUP BY
	category

-- 10.Write sql query to create each shift and number of orders (Example Morning <=12, Afternoon between 12 and 17, Evening greater than 17)
WITH hourly_sale
AS (
	SELECT *,
	CASE 
		WHEN EXTRACT(HOUR FROM sale_time) <= 12 THEN 'Morning' 
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon' 
		ELSE 'Evening'
	END AS shift
	FROM
		retail_sales
)
SELECT
	shift,
	COUNT(*) AS total_orders
FROM
	hourly_sale
GROUP BY
	shift
ORDER BY
	total_orders DESC

-- End of the project
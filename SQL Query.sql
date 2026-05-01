# SQL Retail Sales Analysis
CREATE DATABASE sql_project;

# Create TABLE 
CREATE TABLE retail_sales(
	transactions_id  INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(15) ,
	age  INT,
	category VARCHAR(25),
	quantity INT,
	price_per_unit DECIMAL(6 ,2),
	cogs DECIMAL(6 ,2),
	total_sale DECIMAL(6 ,2)
    );
    
SELECT * FROM retail_sales  
LIMIT 10;  

SELECT COUNT(1)
FROM retail_sales;

# Data Cleaning
SELECT * FROM retail_sales
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
    quantity IS NULL
    OR
    price_per_unit IS NULL
    OR 
    cogs IS NULL
    OR 
    total_sale IS NULL	
;  

#Data Exploration 
#How many sales we have
SELECT COUNT(total_sale) total_sale
FROM retail_sales;

#How many customers we have
SELECT COUNT( DISTINCT customer_id) total_customers
FROM retail_sales;

SELECT DISTINCT category as categories
FROM retail_sales;

#Data Analysis 
#Q.1 Write a SQL Query to retrieve all columns for sales made on '2022-11-05'
SELECT * FROM retail_sales 
WHERE sale_date = '2022-11-05';

#Q.2 Write a SQL query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 4 in the month of 'Nov 2022'
SELECT  * FROM retail_sales
WHERE category='clothing'
 AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
AND quantity >=4;

#Q.2 Write a sql query to calculate the total sale for each category 
SELECT category , SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY category;

#Q.4 Write a sql to find the average age of customers who purchased items from the 'beauty' category
SELECT category,round((age),2) Average_age 
FROM retail_sales
WHERE category ='beauty'
GROUP BY category;

#Q.5 Write a query to find all transactions where the total_sale is  greater than 1000
SELECT * FROM retail_sales
WHERE total_sale > 1000;

#Q.6 Write a sql query to find the total number of transactions made by each gender in each category
SELECT category,gender,COUNT(transactions_id) as total_transactions 
FROM retail_sales
GROUP BY category,gender
ORDER BY category;

#Q.7 Write a sql query to calculate the average sale for each month. Find out the best selling month yet
SELECT * FROM 
(
	SELECT year(sale_date) `year`,
	month(sale_date) `month`,AVG(total_sale) avg_sale,
	RANK() OVER(PARTITION BY year(sale_date) ORDER BY AVG(total_sale)DESc) as r_a_n_k
	FROM retail_sales
	GROUP BY 1,2
	) t1
WHERE r_a_n_K = 1;
#ORDER BY 1,3 DESC;

#Q.8 Write a sql query to find the top 5 customers based on the highest total sales 
SELECT customer_id , sum(total_sale) as totalss
FROM retail_sales
GROUP BY customer_id
ORDER BY totalss DESC
LIMIT 5;

#Q.9 Write a sql query to find the number of unique customers who purchased items from each category 
SELECT COUNT(* )as count_unique, category 
FROM (
 SELECT customer_id
 FROM retail_sales 
 GROUP BY customer_id
HAVING count(DISTINCT category) = 3
) AS t;

#Q.10 Write a sql query to create each shift and number of orders 


WITH hourly_sale 
AS (
SELECT *,
CASE 
	WHEN sale_time < '12:00:00' THEN 'Morning Shift'
    WHEN sale_time BETWEEN '12:00:00' AND '18:00:00' THEN 'Afternoon Shift'
  ELSE 'Night Shift' 
END AS Shift
FROM retail_sales) 
SELECT shift ,COUNT(*) as total_orders
FROM hourly_sale 
GROUP BY shift


#End of Project



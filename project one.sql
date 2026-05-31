--Q2 retrieve all transactions where the category is 'clothing 'and the quntitiy sold is more than 4 in the month of Nov-2022
SELECT 
*
FROM retail_sales
WHERE category = 'Clothing'

AND
TO_CHAR(sale_date,'YYYY-MM') = ('2022-11')
 AND
 quantity >= 4

--Q3 calculate the sales for each category
SELECT  category,

		SUM(total_sale) as net_sales,
		COUNT (*) as total_orders
FROM  retail_sales
GROUP BY 1

--Q4 find the average age of the customers who purchased items from the 'beauty' category

SELECT  ROUND(AVG(age),2) as av_age
FROM retail_sales
WHERE category = 'Beauty'

--Q5 find all the transactions where the total_sale is greater than 1000

Select * 
FROM retail_sales 
WHERE total_sale >1000

--Q6 find the total number  of transactions made by each gender in each category

SELECT 
gender,
category,
COUNT(*) as total_trans
FROM retail_sales
GROUP BY 
category,
gender

--Q7 calculate the average sale for each month, find out the best selling month in each year 

SELECT * FROM (
SELECT 
	EXTRACT(YEAR FROM sale_date)as year, 
	EXTRACT(MONTH FROM sale_date)as month,
	ROUND(AVG(total_sale)) as avg_sale,
	RANK() OVER (PARTITION BY EXTRACT (YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1

WHERE rank = 1


--Q8 find the top 5 customers based on the highest total sales


SELECT  
 	 customer_id,
	  SUM(total_sale) as total_sales 
	  FROM retail_sales
	  GROUP BY 1 
	  ORDER BY 2 DESC
	  LIMIT 5

--Q9 find the number of unique customners who purchased items from each category

SELECT  
 	category,
	 COUNT( DISTINCT customer_id)
FROM retail_sales
GROUP BY category

	
--create each shift and number of orders (example morning <= 12 , afternoon between 12 and 17, evening > 17 )


WITH hourly_sales
AS (
SELECT *, 
CASE 
	WHEN EXTRACT (HOUR FROM sale_time) < 12 THEN ' morning'

	WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'afternoon'

	ELSE ' evening'
	END as shift

FROM retail_sales
)

SELECT 
shift,
COUNT (*) as total_orders
FROM hourly_sales
GROUP BY shift


* FROM hourly_sales



	  


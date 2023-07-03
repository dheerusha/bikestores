--Write a SQL Query to get a dataset with fields consisting of order id, 
--customers, city, state, order date, total units, revenue, product name,
--category name, store name and sales representative by bringing data
--from nine seperate but related tables in the BikeStores database.
--The dataset should be such that it can be exported for further anaysis
--in Excel or any BI tools.

SELECT
		ord.order_id,
		CONCAT(cus.first_name, ' ', cus.last_name) AS 'customers',
		cus.city,
		cus.state,
		ord.order_date,
		SUM(ite.quantity) AS 'total_units',
		SUM(ite.quantity * ite.list_price) AS 'revenue',
		pro.product_name,
		cat.category_name,
		sto.store_name,
		CONCAT(sta.first_name, ' ', sta.last_name) AS 'sales_rep'
FROM sales.orders ord
JOIN sales.customers cus
ON ord.customer_id = cus.customer_id
JOIN sales.order_items ite
ON ord.order_id = ite.order_id
JOIN production.products pro
ON ite.product_id = pro.product_id
JOIN production.categories cat
ON pro.category_id = cat.category_id
JOIN sales.stores sto
ON ord.store_id = sto.store_id
JOIN sales.staffs sta
ON ord.staff_id = sta.staff_id
GROUP BY
		ord.order_id,
		CONCAT(cus.first_name, ' ', cus.last_name),
		cus.city,
		cus.state,
		ord.order_date,
		pro.product_name,
		cat.category_name,
		sto.store_name,
		CONCAT(sta.first_name, ' ', sta.last_name)

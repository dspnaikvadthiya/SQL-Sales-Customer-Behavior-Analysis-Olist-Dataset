CREATE DATABASE OLIST;

 select * from olist_orders_dataset;
 select * from olist_order_payments_dataset;
 select * from olist_order_reviews_dataset;

# 1. Weekday Vs Weekend (order_purchase_timestamp) Payment Statistics
select weekday(order_purchase_timestamp) as Dayofpayment, round(sum(payment_value),0) as Payment from olist_orders_dataset od
join olist_order_payments_dataset op on od.order_id=op.order_id
group by Dayofpayment
order by dayofpayment;

# 2. Number of Orders with review score 5 and payment type as credit card
select count(op.order_id) as Total_orders, review_score,payment_type from olist_order_payments_dataset op
join olist_order_reviews_dataset orev on op.order_id=orev.order_id
where op.payment_type ='credit_card' and orev.review_score = 5;


SELECT * FROM olist_products_dataset1;
SELECT * FROM olist_order_items_dataset;
select  * FROM olist_customers_dataset;

# 3. Average number of days taken for order_delivered_customer_date for pet_shop
SELECT pro.product_category_name,  round(avg(datediff(order_delivered_customer_date, order_purchase_timestamp)),0)
as avg_delivery_days
from  olist_orders_dataset od
join olist_order_items_dataset orit  on od.order_id= orit.order_id
join  olist_products_dataset1 pro on orit.product_id = pro.product_id
where product_category_name ="pet_shop"
group by pro.product_category_name;

# 4. Average price and payment values from customers of sao paulo city
SELECT cus.customer_city, round(avg(PRICE),0) as Avg_Price,  round(avg(payment_value),0) as Avg_Payment_value
FROM  olist_orders_dataset od
join olist_customers_dataset cus on od.customer_id=cus.customer_id
join olist_order_items_dataset orit on od.order_id = orit.order_id
join olist_order_payments_dataset op on od.order_id = op.order_id
where customer_city = 'sao paulo'
Group by customer_city;


# 5. Relationship between shipping days (order_delivered_customer_date - order_purchase_timestamp) Vs review scores.
select review_score, round(avg(datediff(order_delivered_customer_date, order_purchase_timestamp)),0) as avg_shipping_days
from olist_orders_dataset od
join olist_order_reviews_dataset orev on od.order_id=orev.order_id
Group by review_score;


# 6. Sales to customers of Top 10 cities in Brazil 
SELECT cus.customer_city, round(sum(PRICE),0) as Sales  
FROM  olist_orders_dataset od
join olist_customers_dataset cus on od.customer_id=cus.customer_id
join olist_order_items_dataset orit on od.order_id = orit.order_id
where customer_city in ('sao paulo', 'rio de janeiro', 'brasilia', 'fortaleza', 'salvador','belo horizonte', 'manaus', 
'curitiba', 'recife', 'goiania') 
Group by customer_city;


# 7. Payment from customers of Top 10 cities in Brazil 
SELECT cus.customer_city, round(sum(payment_value),0) as Customer_Payments  
FROM  olist_orders_dataset od
join olist_customers_dataset cus on od.customer_id=cus.customer_id
join olist_order_payments_dataset op on od.order_id = op.order_id
where customer_city in ('sao paulo', 'rio de janeiro', 'brasilia', 'fortaleza', 'salvador','belo horizonte', 'manaus', 
'curitiba', 'recife', 'goiania') 
Group by customer_city;

# 8. Payment by payment type
select payment_type, round(sum(payment_value),0) as Payment_value from olist_order_payments_dataset
Group by payment_type;

# 9. Top 10 product sales
select product_category_name, round(sum(price),0) as Total_Sales from olist_order_items_dataset orit
join olist_products_dataset1 op on orit.product_id=op.product_id
Group by product_category_name
order by total_sales desc
limit 10;

#10. Total sales, Freight and Payment by Year
select year(order_purchase_timestamp) as Year, round(sum(price),0) as Total_Sales, round(sum(freight_value),0) as Total_Freight,
round(sum(payment_value),0) as Total_Payments from olist_orders_dataset od
join olist_order_items_dataset orit on od.order_id = orit.order_id
join olist_order_payments_dataset op on od.order_id= op.order_id
Group by year


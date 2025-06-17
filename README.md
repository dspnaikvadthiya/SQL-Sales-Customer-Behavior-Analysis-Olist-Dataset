# SQL-Sales-Customer-Behavior-Analysis-Olist-Dataset
# 📦 Olist Sales & Customer Behavior SQL Analysis

## 📝 Project Overview  
This project uses SQL to analyze the **Olist Brazilian e-commerce dataset**, focusing on customer behavior, product trends, city-level performance, and delivery metrics. It reflects common data analyst tasks in real business scenarios.

---

## 🔧 Tools & Technologies  
- **SQL (MySQL)**  
- **Olist E-commerce Dataset**  
- **Joins, Aggregations, Date Functions**

---

## 📁 Datasets Used  
- `olist_orders_dataset`  
- `olist_order_items_dataset`  
- `olist_order_reviews_dataset`  
- `olist_order_payments_dataset`  
- `olist_customers_dataset`  
- `olist_products_dataset1`

---

## 📌 SQL Business Queries Overview  

### 1️⃣ Weekday vs Weekend Payment Analysis  
```sql
SELECT WEEKDAY(order_purchase_timestamp) AS Dayofpayment, 
       ROUND(SUM(payment_value), 0) AS Payment
FROM olist_orders_dataset od
JOIN olist_order_payments_dataset op ON od.order_id = op.order_id
GROUP BY Dayofpayment
ORDER BY Dayofpayment;

2️⃣ Credit Card Orders with 5-Star Review
SELECT COUNT(op.order_id) AS Total_orders, review_score, payment_type
FROM olist_order_payments_dataset op
JOIN olist_order_reviews_dataset orev ON op.order_id = orev.order_id
WHERE op.payment_type = 'credit_card' AND orev.review_score = 5;

3️⃣ Avg Delivery Time for Pet Shop
SELECT pro.product_category_name,  
       ROUND(AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)), 0) AS avg_delivery_days
FROM olist_orders_dataset od
JOIN olist_order_items_dataset orit ON od.order_id = orit.order_id
JOIN olist_products_dataset1 pro ON orit.product_id = pro.product_id
WHERE product_category_name = 'pet_shop'
GROUP BY pro.product_category_name;

4️⃣ Avg Price & Payment from São Paulo Customers
SELECT cus.customer_city, 
       ROUND(AVG(price), 0) AS Avg_Price,  
       ROUND(AVG(payment_value), 0) AS Avg_Payment_value
FROM olist_orders_dataset od
JOIN olist_customers_dataset cus ON od.customer_id = cus.customer_id
JOIN olist_order_items_dataset orit ON od.order_id = orit.order_id
JOIN olist_order_payments_dataset op ON od.order_id = op.order_id
WHERE customer_city = 'sao paulo'
GROUP BY customer_city;

5️⃣ Shipping Days vs Review Scores
SELECT review_score, 
       ROUND(AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)), 0) AS avg_shipping_days
FROM olist_orders_dataset od
JOIN olist_order_reviews_dataset orev ON od.order_id = orev.order_id
GROUP BY review_score;

6️⃣ Sales in Top 10 Cities
SELECT cus.customer_city, ROUND(SUM(price), 0) AS Sales  
FROM olist_orders_dataset od
JOIN olist_customers_dataset cus ON od.customer_id = cus.customer_id
JOIN olist_order_items_dataset orit ON od.order_id = orit.order_id
WHERE customer_city IN ('sao paulo', 'rio de janeiro', 'brasilia', 'fortaleza', 'salvador',
                        'belo horizonte', 'manaus', 'curitiba', 'recife', 'goiania') 
GROUP BY customer_city;

7️⃣ Payments in Top 10 Cities
SELECT cus.customer_city, ROUND(SUM(payment_value), 0) AS Customer_Payments  
FROM olist_orders_dataset od
JOIN olist_customers_dataset cus ON od.customer_id = cus.customer_id
JOIN olist_order_payments_dataset op ON od.order_id = op.order_id
WHERE customer_city IN ('sao paulo', 'rio de janeiro', 'brasilia', 'fortaleza', 'salvador',
                        'belo horizonte', 'manaus', 'curitiba', 'recife', 'goiania') 
GROUP BY customer_city;

8️⃣ Total Payments by Type
SELECT payment_type, ROUND(SUM(payment_value), 0) AS Payment_value 
FROM olist_order_payments_dataset
GROUP BY payment_type;

9️⃣ Top 10 Product Categories by Sales
sql
Copy
Edit
SELECT product_category_name, ROUND(SUM(price), 0) AS Total_Sales 
FROM olist_order_items_dataset orit
JOIN olist_products_dataset1 op ON orit.product_id = op.product_id
GROUP BY product_category_name
ORDER BY Total_Sales DESC
LIMIT 10;
🔟 Yearly Sales Summary
sql
Copy
Edit
SELECT YEAR(order_purchase_timestamp) AS Year, 
       ROUND(SUM(price), 0) AS Total_Sales, 
       ROUND(SUM(freight_value), 0) AS Total_Freight,
       ROUND(SUM(payment_value), 0) AS Total_Payments 
FROM olist_orders_dataset od
JOIN olist_order_items_dataset orit ON od.order_id = orit.order_id
JOIN olist_order_payments_dataset op ON od.order_id = op.order_id
GROUP BY Year;
📚 Key Learning Outcomes
Gained deep insights into customer behavior and logistics efficiency

Strengthened SQL skills with complex joins, filters, and date calculations

Practiced real-time business analytics using structured datasets

📂 File Included
olist_sales_analysis_queries.sql: Contains all SQL queries used for analysis

✍ Author
Sai Prasad Naik












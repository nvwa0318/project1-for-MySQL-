CREATE DATABASE  IF NOT EXISTS `magist` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE magist;

SELECT *
FROM orders ;
SELECT *
FROM products ;
SELECT *
FROM sellers ;
SELECT *
FROM order_items ;
SELECT *
FROM order_payments ;
SELECT *
FROM order_reviews ;
SELECT *
FROM product_category_name_translation ;
SELECT *
FROM geo ;


SELECT  COUNT(*)
FROM orders 
WHERE order_status = 'delivered';  /*96478*/

SELECT  COUNT(*)
FROM orders 
WHERE order_status != 'delivered';  /* '2936'  */

SELECT
EXTRACT(YEAR_MONTH FROM order_purchase_timestamp) AS year_and_month, COUNT(*) 
FROM orders
WHERE order_status = 'delivered'
GROUP BY year_and_month 
ORDER BY year_and_month  ;

SELECT DISTINCT COUNT(*)
FROM products ; /*32951*/

SELECT product_category_name, COUNT(*)
FROM products
GROUP BY product_category_name 
ORDER BY  COUNT(*) DESC;

SELECT 
	count(DISTINCT product_id) AS n_products
FROM
	order_items;
    
 SELECT product_id, MAX(price)     /* problem */
 FROM order_items; /* 2649,99,1,2017-07-04*/  /*min 3.49,1 or 2,2017-07-20  */

/*mostly between 30 to 300*/
SELECT *
FROM order_payments;

 SELECT MAX(payment_value)     /* problem */
 FROM order_payments;         /* 2787,87 */

 SELECT MIN(payment_value) AS min     /* problem */
 FROM order_payments;   /* 0,01 */
 
 SELECT 
	MAX(payment_value) as highest,
    MIN(payment_value) as lowest
FROM
	order_payments;

/* high tech = telephony=telefonia, signaling_and_security=sinalizacao_e_sequguranca, electronics=electronicos, auto=automotivo,computers=pcs */
/* 可作服装，杂货，装饰品香水 , 家用品， 房材， 健康化妆品， */
SELECT product_id, COUNT(orders_item_id)
FROM order_items
LEFT JOIN products
ON orders_item.product_id=products.product_id
LEFT JOIN product_category_name_translation
ON prducts.product_category_name = product_category_name_translation.product_category_name
WHERE product_category_name IN ('telefonia', 'sinalizacao_e_sequguranca', 'electronicos', 'utomotivo', 'pcs')
GROUP BY product_id  
ORDER BY COUNT(orders_item_id) DESC ;




SELECT * 
FROM products p
LEFT JOIN product_category_name_translation pt
ON  p.product_category_name = pt.product_category_name ;

SELECT * 
FROM orders o
LEFT JOIN product_category_name_translation pt
ON  p.product_category_name = pt.product_category_name ;

SELECT DISTINCT(oi.product_id), p.product_id, p.product_category_name, pt.product_category_name, SUM(price)   /* '0433830caca22b01a0f477d31307b043', '13193' */
FROM order_items AS oi /*, products AS p, product_category_name_translation AS pt*/
LEFT JOIN products AS p
ON oi.product_id=p.product_id
INNER JOIN product_category_name_translation pt
ON  p.product_category_name=pt.product_category_name
WHERE product_category_name in ('telefonia','sinalizacao_e_sequguranca', 'electronicos', 'automotivo' 'pcs')
GROUP BY oi.product_id
ORDER BY SUM(price) DESC
LIMIT 200;

SELECT DISTINCT(oi.product_id), p.product_id, p.product_category_name, pt.product_category_name, SUM(price)   /* '0433830caca22b01a0f477d31307b043', '13193' */
FROM order_items AS oi /*, products AS p, product_category_name_translation AS pt*/
LEFT JOIN products AS p
ON oi.product_id=p.product_id
INNER JOIN product_category_name_translation pt
ON  p.product_category_name=pt.product_category_name
WHERE p.product_category_name in ('telefonia' and 'sinalizacao_e_sequguranca'and 'electronicos'and 'automotivo' 'pcs')
GROUP BY oi.product_id
ORDER BY SUM(price) DESC
LIMIT 200;

SELECT DISTINCT(order_purchase_timestamp), SUM(price)   /* '0433830caca22b01a0f477d31307b043', '13193' */
FROM orders
LEFT JOIN order_items 
ON orders.product_id = order_items.product_id
/*INNER JOIN product_category_name_translation pt
ON  p.product_category_name = pt.product_category_name*/
GROUP BY order_purchase_timestamp
ORDER BY order_purchase_timestamp DESC
LIMIT 30;

SELECT  COUNT(*)              /* arrive time   7827 times late */
FROM orders
WHERE order_estimated_delivery_date < order_delivered_customer_date ;

SELECT  COUNT(*)              /* 1 case */
FROM orders 
WHERE order_status != 'delivered' and order_estimated_delivery_date < order_delivered_customer_date;  /* '2936' compare to 1 */


SELECT year_and_month, COUNT(*) 
FROM orders
GROUP BY year_and_month  ;


mysql> use ofs
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> select order_id,product_name,quantity,unit_price,sum(quantity*unit_price) as order_value
    -> from orders where order_status='Completed'
    -> and sum(quantity*unit_price)>(
    -> select sum(quantity*unit_price) as total_spent
    -> select avg(total_spent)
    -> where order_status='Completed'
    -> );
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'select avg(total_spent)
where order_status='Completed'
)' at line 5
mysql> select order_id,product_name,quantity,unit_price,
    -> sum(quantity*unit_price) as order_value
    -> from orders where order_status='Completed'
    -> and sum(quantity*unit_price) >(
    -> select avg(quantity*unit_price)
    -> where order_status='Completed'
    -> group by order_id
    -> );
ERROR 1111 (HY000): Invalid use of group function
mysql> select order_id,product_name,quantity,unit_price, sum(quantity*unit_price) as order_value from orders where order_status='Completed' and sum(quantity*unit_price) >( select avg(quantity*unit_price) where order_status='Completed' );
ERROR 1111 (HY000): Invalid use of group function
mysql> select order_id,product_name,quantity,unit_price, sum(quantity*unit_price) as order_value from orders where order_status='Completed' and sum(quantity*unit_price) >( select avg(quantity*unit_price) where order_status='Completed' );
ERROR 1111 (HY000): Invalid use of group function
mysql> SELECT
    ->     order_id,
    ->     product_name,
    ->     quantity,
    ->     unit_price,
    ->     (quantity * unit_price) AS order_value
    -> FROM orders
    -> WHERE order_status = 'Completed'
    ->   AND (quantity * unit_price) > (
    ->       SELECT AVG(quantity * unit_price)
    ->       FROM orders
    ->       WHERE order_status = 'Completed'
    ->   );
+----------+--------------+----------+------------+-------------+
| order_id | product_name | quantity | unit_price | order_value |
+----------+--------------+----------+------------+-------------+
|        5 | Monitor      |        1 |   12999.00 |    12999.00 |
|        7 | Laptop       |        1 |   55000.00 |    55000.00 |
|        8 | Monitor      |        1 |   12999.00 |    12999.00 |
|       12 | Tablet       |        1 |   22000.00 |    22000.00 |
|       21 | Camera       |        1 |   35000.00 |    35000.00 |
|       26 | Printer      |        1 |    8999.00 |     8999.00 |
|       30 | Smartphone   |        1 |   30000.00 |    30000.00 |
+----------+--------------+----------+------------+-------------+
7 rows in set (0.03 sec)

mysql> c.customer_id,c.full_name,(quantity*unit_price) as order_value 
    -> from customers c inner join orders o on c.customer_id=o.customer_id
    -> where o.order_status='Completed'and order_value>=10000;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'c.customer_id,c.full_name,(quantity*unit_price) as order_value 
from customers c' at line 1
mysql> select select c.customer_id,c.full_name
    -> from customers c 
    -> where exists(
    -> select 
    -> ^C
mysql> select c.customer_id,c.full_name
    -> from customers c
    -> where exists(
    -> select 1
    -> from orders 
    -> where o.customer_id=c.customer_id
    -> and o.order_status='Completed'
    -> and(o.quantity*o.unit_price)>10000;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '' at line 8
mysql> select c.customer_id,c.full_name from customers c where exists( select 1 from orders  where o.customer_id=c.customer_id and o.order_status='Completed' and(o.quantity*o.unit_price)>10000);
ERROR 1054 (42S22): Unknown column 'o.customer_id' in 'where clause'
mysql> select c.customer_id,c.full_name from customers c where exists( select 1 from orders o  where o.customer_id=c.customer_id and o.order_status='Completed' and(o.quantity*o.unit_price)>10000);
+-------------+-------------+
| customer_id | full_name   |
+-------------+-------------+
|           2 | Priya Reddy |
|           3 | Rahul Verma |
|           4 | Ananya Rao  |
|           8 | Neha Singh  |
|          13 | Riya Das    |
+-------------+-------------+
5 rows in set (0.03 sec)

mysql> select c.customer_id,c.full_name,c.city,count(order_id) as count
    -> ^C
mysql> select c.customer_id,c.full_name,c.city,count(o.order_id) as count
    -> from customers c inner join orders o on c.customer_id=o.customer_id where o.order_status='Completed';
ERROR 1140 (42000): In aggregated query without GROUP BY, expression #1 of SELECT list contains nonaggregated column 'ofs.c.customer_id'; this is incompatible with sql_mode=only_full_group_by
mysql> select c.customer_id,c.full_name,c.city,count(o.order_id) as count from customers c inner join orders o on c.customer_id=o.customer_id where o.order_status='Completed' group by c.customer_id,c.full_name,c.city;
+-------------+--------------+-----------+-------+
| customer_id | full_name    | city      | count |
+-------------+--------------+-----------+-------+
|           1 | Aarav Sharma | Hyderabad |     3 |
|           2 | Priya Reddy  | Hyderabad |     2 |
|           3 | Rahul Verma  | Bengaluru |     5 |
|           4 | Ananya Rao   | Bengaluru |     1 |
|           5 | Rohan Mehta  | Pune      |     3 |
|           6 | Sneha Patel  | Pune      |     1 |
|           7 | Arjun Kumar  | Hyderabad |     3 |
|           8 | Neha Singh   | Chennai   |     1 |
|           9 | Raj Malhotra | Pune      |     3 |
|          10 | Kavya Nair   | Chennai   |     2 |
|          11 | Aditi Kapoor | Mumbai    |     1 |
|          13 | Riya Das     | Hyderabad |     2 |
|          15 | Aman Khan    | Delhi     |     1 |
+-------------+--------------+-----------+-------+
13 rows in set (0.01 sec)

mysql> select customer_id,full_name,city
    -> from customers 
    -> where customer_id in(
    -> select customer_id,from orders 
    -> where order_status='Completed'
    -> );
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'from orders 
where order_status='Completed'
)' at line 4
mysql> select customer_id,full_name,city from customers  where customer_id in( select customer_id from orders  where order_status='Completed' );
+-------------+--------------+-----------+
| customer_id | full_name    | city      |
+-------------+--------------+-----------+
|           1 | Aarav Sharma | Hyderabad |
|           2 | Priya Reddy  | Hyderabad |
|           3 | Rahul Verma  | Bengaluru |
|           4 | Ananya Rao   | Bengaluru |
|           5 | Rohan Mehta  | Pune      |
|           6 | Sneha Patel  | Pune      |
|           7 | Arjun Kumar  | Hyderabad |
|           8 | Neha Singh   | Chennai   |
|           9 | Raj Malhotra | Pune      |
|          10 | Kavya Nair   | Chennai   |
|          11 | Aditi Kapoor | Mumbai    |
|          13 | Riya Das     | Hyderabad |
|          15 | Aman Khan    | Delhi     |
+-------------+--------------+-----------+
13 rows in set (0.00 sec)

mysql> select customer_id,full_name,city
    -> from customers c
    -> where not exists(
    -> select 5 
    -> from orders o 
    -> where c.customer_id=o.customer_id
    -> and order_status is not 'Completed'
    -> );
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ''Completed'
)' at line 7
mysql> select customer_id,full_name,city from customers c where not exists( select 5  from orders o  where c.customer_id=o.customer_id and order_status='Completed' );
+-------------+--------------+--------+
| customer_id | full_name    | city   |
+-------------+--------------+--------+
|          12 | Vikram Joshi | Mumbai |
|          14 | Nisha Gupta  | Pune   |
+-------------+--------------+--------+
2 rows in set (0.00 sec)

mysql> select c.customer_id,c.full_name,o.product_name,o.unit_price 
    -> from customers c inner join 
    -> orders o
    -> where o.order_status='Completed'
    -> and o.unit_price=(
    -> select max(o.unit_price)
    -> from orders o2
    -> where o.customer_id=o2.customer_id
    -> and o2.order_status='Completed'
    -> );
+-------------+--------------+-------------------+------------+
| customer_id | full_name    | product_name      | unit_price |
+-------------+--------------+-------------------+------------+
|           1 | Aarav Sharma | Bluetooth Speaker |    3999.00 |
|           1 | Aarav Sharma | Phone Case        |     599.00 |
|           1 | Aarav Sharma | Smartphone        |   30000.00 |
|           1 | Aarav Sharma | Desk Lamp         |    1299.00 |
|           1 | Aarav Sharma | Ink Cartridge     |    1499.00 |
|           1 | Aarav Sharma | Printer           |    8999.00 |
|           1 | Aarav Sharma | Gaming Headset    |    5999.00 |
|           1 | Aarav Sharma | Gaming Keyboard   |    4999.00 |
|           1 | Aarav Sharma | Gaming Mouse      |    2999.00 |
|           1 | Aarav Sharma | Camera            |   35000.00 |
|           1 | Aarav Sharma | USB Cable         |     399.00 |
|           1 | Aarav Sharma | Power Bank        |    1999.00 |
|           1 | Aarav Sharma | Backpack          |    2499.00 |
|           1 | Aarav Sharma | Yoga Mat          |    1299.00 |
|           1 | Aarav Sharma | Sports Bag        |    1999.00 |
|           1 | Aarav Sharma | Running Shoes     |    3499.00 |
|           1 | Aarav Sharma | Smart Watch       |    7999.00 |
|           1 | Aarav Sharma | Tablet            |   22000.00 |
|           1 | Aarav Sharma | Webcam            |    3999.00 |
|           1 | Aarav Sharma | Headphones        |    2499.00 |
|           1 | Aarav Sharma | Keyboard          |    1499.00 |
|           1 | Aarav Sharma | Monitor           |   12999.00 |
|           1 | Aarav Sharma | Laptop            |   55000.00 |
|           1 | Aarav Sharma | Mouse Pad         |     499.00 |
|           1 | Aarav Sharma | Monitor           |   12999.00 |
|           1 | Aarav Sharma | Headphones        |    2499.00 |
|           1 | Aarav Sharma | Keyboard          |    1499.00 |
|           1 | Aarav Sharma | Wireless Mouse    |     799.00 |
|           2 | Priya Reddy  | Bluetooth Speaker |    3999.00 |
|           2 | Priya Reddy  | Phone Case        |     599.00 |
|           2 | Priya Reddy  | Smartphone        |   30000.00 |
|           2 | Priya Reddy  | Desk Lamp         |    1299.00 |
|           2 | Priya Reddy  | Ink Cartridge     |    1499.00 |
|           2 | Priya Reddy  | Printer           |    8999.00 |
|           2 | Priya Reddy  | Gaming Headset    |    5999.00 |
|           2 | Priya Reddy  | Gaming Keyboard   |    4999.00 |
|           2 | Priya Reddy  | Gaming Mouse      |    2999.00 |
|           2 | Priya Reddy  | Camera            |   35000.00 |
|           2 | Priya Reddy  | USB Cable         |     399.00 |
|           2 | Priya Reddy  | Power Bank        |    1999.00 |
|           2 | Priya Reddy  | Backpack          |    2499.00 |
|           2 | Priya Reddy  | Yoga Mat          |    1299.00 |
|           2 | Priya Reddy  | Sports Bag        |    1999.00 |
|           2 | Priya Reddy  | Running Shoes     |    3499.00 |
|           2 | Priya Reddy  | Smart Watch       |    7999.00 |
|           2 | Priya Reddy  | Tablet            |   22000.00 |
|           2 | Priya Reddy  | Webcam            |    3999.00 |
|           2 | Priya Reddy  | Headphones        |    2499.00 |
|           2 | Priya Reddy  | Keyboard          |    1499.00 |
|           2 | Priya Reddy  | Monitor           |   12999.00 |
|           2 | Priya Reddy  | Laptop            |   55000.00 |
|           2 | Priya Reddy  | Mouse Pad         |     499.00 |
|           2 | Priya Reddy  | Monitor           |   12999.00 |
|           2 | Priya Reddy  | Headphones        |    2499.00 |
|           2 | Priya Reddy  | Keyboard          |    1499.00 |
|           2 | Priya Reddy  | Wireless Mouse    |     799.00 |
|           3 | Rahul Verma  | Bluetooth Speaker |    3999.00 |
|           3 | Rahul Verma  | Phone Case        |     599.00 |
|           3 | Rahul Verma  | Smartphone        |   30000.00 |
|           3 | Rahul Verma  | Desk Lamp         |    1299.00 |
|           3 | Rahul Verma  | Ink Cartridge     |    1499.00 |
|           3 | Rahul Verma  | Printer           |    8999.00 |
|           3 | Rahul Verma  | Gaming Headset    |    5999.00 |
|           3 | Rahul Verma  | Gaming Keyboard   |    4999.00 |
|           3 | Rahul Verma  | Gaming Mouse      |    2999.00 |
|           3 | Rahul Verma  | Camera            |   35000.00 |
|           3 | Rahul Verma  | USB Cable         |     399.00 |
|           3 | Rahul Verma  | Power Bank        |    1999.00 |
|           3 | Rahul Verma  | Backpack          |    2499.00 |
|           3 | Rahul Verma  | Yoga Mat          |    1299.00 |
|           3 | Rahul Verma  | Sports Bag        |    1999.00 |
|           3 | Rahul Verma  | Running Shoes     |    3499.00 |
|           3 | Rahul Verma  | Smart Watch       |    7999.00 |
|           3 | Rahul Verma  | Tablet            |   22000.00 |
|           3 | Rahul Verma  | Webcam            |    3999.00 |
|           3 | Rahul Verma  | Headphones        |    2499.00 |
|           3 | Rahul Verma  | Keyboard          |    1499.00 |
|           3 | Rahul Verma  | Monitor           |   12999.00 |
|           3 | Rahul Verma  | Laptop            |   55000.00 |
|           3 | Rahul Verma  | Mouse Pad         |     499.00 |
|           3 | Rahul Verma  | Monitor           |   12999.00 |
|           3 | Rahul Verma  | Headphones        |    2499.00 |
|           3 | Rahul Verma  | Keyboard          |    1499.00 |
|           3 | Rahul Verma  | Wireless Mouse    |     799.00 |
|           4 | Ananya Rao   | Bluetooth Speaker |    3999.00 |
|           4 | Ananya Rao   | Phone Case        |     599.00 |
|           4 | Ananya Rao   | Smartphone        |   30000.00 |
|           4 | Ananya Rao   | Desk Lamp         |    1299.00 |
|           4 | Ananya Rao   | Ink Cartridge     |    1499.00 |
|           4 | Ananya Rao   | Printer           |    8999.00 |
|           4 | Ananya Rao   | Gaming Headset    |    5999.00 |
|           4 | Ananya Rao   | Gaming Keyboard   |    4999.00 |
|           4 | Ananya Rao   | Gaming Mouse      |    2999.00 |
|           4 | Ananya Rao   | Camera            |   35000.00 |
|           4 | Ananya Rao   | USB Cable         |     399.00 |
|           4 | Ananya Rao   | Power Bank        |    1999.00 |
|           4 | Ananya Rao   | Backpack          |    2499.00 |
|           4 | Ananya Rao   | Yoga Mat          |    1299.00 |
|           4 | Ananya Rao   | Sports Bag        |    1999.00 |
|           4 | Ananya Rao   | Running Shoes     |    3499.00 |
|           4 | Ananya Rao   | Smart Watch       |    7999.00 |
|           4 | Ananya Rao   | Tablet            |   22000.00 |
|           4 | Ananya Rao   | Webcam            |    3999.00 |
|           4 | Ananya Rao   | Headphones        |    2499.00 |
|           4 | Ananya Rao   | Keyboard          |    1499.00 |
|           4 | Ananya Rao   | Monitor           |   12999.00 |
|           4 | Ananya Rao   | Laptop            |   55000.00 |
|           4 | Ananya Rao   | Mouse Pad         |     499.00 |
|           4 | Ananya Rao   | Monitor           |   12999.00 |
|           4 | Ananya Rao   | Headphones        |    2499.00 |
|           4 | Ananya Rao   | Keyboard          |    1499.00 |
|           4 | Ananya Rao   | Wireless Mouse    |     799.00 |
|           5 | Rohan Mehta  | Bluetooth Speaker |    3999.00 |
|           5 | Rohan Mehta  | Phone Case        |     599.00 |
|           5 | Rohan Mehta  | Smartphone        |   30000.00 |
|           5 | Rohan Mehta  | Desk Lamp         |    1299.00 |
|           5 | Rohan Mehta  | Ink Cartridge     |    1499.00 |
|           5 | Rohan Mehta  | Printer           |    8999.00 |
|           5 | Rohan Mehta  | Gaming Headset    |    5999.00 |
|           5 | Rohan Mehta  | Gaming Keyboard   |    4999.00 |
|           5 | Rohan Mehta  | Gaming Mouse      |    2999.00 |
|           5 | Rohan Mehta  | Camera            |   35000.00 |
|           5 | Rohan Mehta  | USB Cable         |     399.00 |
|           5 | Rohan Mehta  | Power Bank        |    1999.00 |
|           5 | Rohan Mehta  | Backpack          |    2499.00 |
|           5 | Rohan Mehta  | Yoga Mat          |    1299.00 |
|           5 | Rohan Mehta  | Sports Bag        |    1999.00 |
|           5 | Rohan Mehta  | Running Shoes     |    3499.00 |
|           5 | Rohan Mehta  | Smart Watch       |    7999.00 |
|           5 | Rohan Mehta  | Tablet            |   22000.00 |
|           5 | Rohan Mehta  | Webcam            |    3999.00 |
|           5 | Rohan Mehta  | Headphones        |    2499.00 |
|           5 | Rohan Mehta  | Keyboard          |    1499.00 |
|           5 | Rohan Mehta  | Monitor           |   12999.00 |
|           5 | Rohan Mehta  | Laptop            |   55000.00 |
|           5 | Rohan Mehta  | Mouse Pad         |     499.00 |
|           5 | Rohan Mehta  | Monitor           |   12999.00 |
|           5 | Rohan Mehta  | Headphones        |    2499.00 |
|           5 | Rohan Mehta  | Keyboard          |    1499.00 |
|           5 | Rohan Mehta  | Wireless Mouse    |     799.00 |
|           6 | Sneha Patel  | Bluetooth Speaker |    3999.00 |
|           6 | Sneha Patel  | Phone Case        |     599.00 |
|           6 | Sneha Patel  | Smartphone        |   30000.00 |
|           6 | Sneha Patel  | Desk Lamp         |    1299.00 |
|           6 | Sneha Patel  | Ink Cartridge     |    1499.00 |
|           6 | Sneha Patel  | Printer           |    8999.00 |
|           6 | Sneha Patel  | Gaming Headset    |    5999.00 |
|           6 | Sneha Patel  | Gaming Keyboard   |    4999.00 |
|           6 | Sneha Patel  | Gaming Mouse      |    2999.00 |
|           6 | Sneha Patel  | Camera            |   35000.00 |
|           6 | Sneha Patel  | USB Cable         |     399.00 |
|           6 | Sneha Patel  | Power Bank        |    1999.00 |
|           6 | Sneha Patel  | Backpack          |    2499.00 |
|           6 | Sneha Patel  | Yoga Mat          |    1299.00 |
|           6 | Sneha Patel  | Sports Bag        |    1999.00 |
|           6 | Sneha Patel  | Running Shoes     |    3499.00 |
|           6 | Sneha Patel  | Smart Watch       |    7999.00 |
|           6 | Sneha Patel  | Tablet            |   22000.00 |
|           6 | Sneha Patel  | Webcam            |    3999.00 |
|           6 | Sneha Patel  | Headphones        |    2499.00 |
|           6 | Sneha Patel  | Keyboard          |    1499.00 |
|           6 | Sneha Patel  | Monitor           |   12999.00 |
|           6 | Sneha Patel  | Laptop            |   55000.00 |
|           6 | Sneha Patel  | Mouse Pad         |     499.00 |
|           6 | Sneha Patel  | Monitor           |   12999.00 |
|           6 | Sneha Patel  | Headphones        |    2499.00 |
|           6 | Sneha Patel  | Keyboard          |    1499.00 |
|           6 | Sneha Patel  | Wireless Mouse    |     799.00 |
|           7 | Arjun Kumar  | Bluetooth Speaker |    3999.00 |
|           7 | Arjun Kumar  | Phone Case        |     599.00 |
|           7 | Arjun Kumar  | Smartphone        |   30000.00 |
|           7 | Arjun Kumar  | Desk Lamp         |    1299.00 |
|           7 | Arjun Kumar  | Ink Cartridge     |    1499.00 |
|           7 | Arjun Kumar  | Printer           |    8999.00 |
|           7 | Arjun Kumar  | Gaming Headset    |    5999.00 |
|           7 | Arjun Kumar  | Gaming Keyboard   |    4999.00 |
|           7 | Arjun Kumar  | Gaming Mouse      |    2999.00 |
|           7 | Arjun Kumar  | Camera            |   35000.00 |
|           7 | Arjun Kumar  | USB Cable         |     399.00 |
|           7 | Arjun Kumar  | Power Bank        |    1999.00 |
|           7 | Arjun Kumar  | Backpack          |    2499.00 |
|           7 | Arjun Kumar  | Yoga Mat          |    1299.00 |
|           7 | Arjun Kumar  | Sports Bag        |    1999.00 |
|           7 | Arjun Kumar  | Running Shoes     |    3499.00 |
|           7 | Arjun Kumar  | Smart Watch       |    7999.00 |
|           7 | Arjun Kumar  | Tablet            |   22000.00 |
|           7 | Arjun Kumar  | Webcam            |    3999.00 |
|           7 | Arjun Kumar  | Headphones        |    2499.00 |
|           7 | Arjun Kumar  | Keyboard          |    1499.00 |
|           7 | Arjun Kumar  | Monitor           |   12999.00 |
|           7 | Arjun Kumar  | Laptop            |   55000.00 |
|           7 | Arjun Kumar  | Mouse Pad         |     499.00 |
|           7 | Arjun Kumar  | Monitor           |   12999.00 |
|           7 | Arjun Kumar  | Headphones        |    2499.00 |
|           7 | Arjun Kumar  | Keyboard          |    1499.00 |
|           7 | Arjun Kumar  | Wireless Mouse    |     799.00 |
|           8 | Neha Singh   | Bluetooth Speaker |    3999.00 |
|           8 | Neha Singh   | Phone Case        |     599.00 |
|           8 | Neha Singh   | Smartphone        |   30000.00 |
|           8 | Neha Singh   | Desk Lamp         |    1299.00 |
|           8 | Neha Singh   | Ink Cartridge     |    1499.00 |
|           8 | Neha Singh   | Printer           |    8999.00 |
|           8 | Neha Singh   | Gaming Headset    |    5999.00 |
|           8 | Neha Singh   | Gaming Keyboard   |    4999.00 |
|           8 | Neha Singh   | Gaming Mouse      |    2999.00 |
|           8 | Neha Singh   | Camera            |   35000.00 |
|           8 | Neha Singh   | USB Cable         |     399.00 |
|           8 | Neha Singh   | Power Bank        |    1999.00 |
|           8 | Neha Singh   | Backpack          |    2499.00 |
|           8 | Neha Singh   | Yoga Mat          |    1299.00 |
|           8 | Neha Singh   | Sports Bag        |    1999.00 |
|           8 | Neha Singh   | Running Shoes     |    3499.00 |
|           8 | Neha Singh   | Smart Watch       |    7999.00 |
|           8 | Neha Singh   | Tablet            |   22000.00 |
|           8 | Neha Singh   | Webcam            |    3999.00 |
|           8 | Neha Singh   | Headphones        |    2499.00 |
|           8 | Neha Singh   | Keyboard          |    1499.00 |
|           8 | Neha Singh   | Monitor           |   12999.00 |
|           8 | Neha Singh   | Laptop            |   55000.00 |
|           8 | Neha Singh   | Mouse Pad         |     499.00 |
|           8 | Neha Singh   | Monitor           |   12999.00 |
|           8 | Neha Singh   | Headphones        |    2499.00 |
|           8 | Neha Singh   | Keyboard          |    1499.00 |
|           8 | Neha Singh   | Wireless Mouse    |     799.00 |
|           9 | Raj Malhotra | Bluetooth Speaker |    3999.00 |
|           9 | Raj Malhotra | Phone Case        |     599.00 |
|           9 | Raj Malhotra | Smartphone        |   30000.00 |
|           9 | Raj Malhotra | Desk Lamp         |    1299.00 |
|           9 | Raj Malhotra | Ink Cartridge     |    1499.00 |
|           9 | Raj Malhotra | Printer           |    8999.00 |
|           9 | Raj Malhotra | Gaming Headset    |    5999.00 |
|           9 | Raj Malhotra | Gaming Keyboard   |    4999.00 |
|           9 | Raj Malhotra | Gaming Mouse      |    2999.00 |
|           9 | Raj Malhotra | Camera            |   35000.00 |
|           9 | Raj Malhotra | USB Cable         |     399.00 |
|           9 | Raj Malhotra | Power Bank        |    1999.00 |
|           9 | Raj Malhotra | Backpack          |    2499.00 |
|           9 | Raj Malhotra | Yoga Mat          |    1299.00 |
|           9 | Raj Malhotra | Sports Bag        |    1999.00 |
|           9 | Raj Malhotra | Running Shoes     |    3499.00 |
|           9 | Raj Malhotra | Smart Watch       |    7999.00 |
|           9 | Raj Malhotra | Tablet            |   22000.00 |
|           9 | Raj Malhotra | Webcam            |    3999.00 |
|           9 | Raj Malhotra | Headphones        |    2499.00 |
|           9 | Raj Malhotra | Keyboard          |    1499.00 |
|           9 | Raj Malhotra | Monitor           |   12999.00 |
|           9 | Raj Malhotra | Laptop            |   55000.00 |
|           9 | Raj Malhotra | Mouse Pad         |     499.00 |
|           9 | Raj Malhotra | Monitor           |   12999.00 |
|           9 | Raj Malhotra | Headphones        |    2499.00 |
|           9 | Raj Malhotra | Keyboard          |    1499.00 |
|           9 | Raj Malhotra | Wireless Mouse    |     799.00 |
|          10 | Kavya Nair   | Bluetooth Speaker |    3999.00 |
|          10 | Kavya Nair   | Phone Case        |     599.00 |
|          10 | Kavya Nair   | Smartphone        |   30000.00 |
|          10 | Kavya Nair   | Desk Lamp         |    1299.00 |
|          10 | Kavya Nair   | Ink Cartridge     |    1499.00 |
|          10 | Kavya Nair   | Printer           |    8999.00 |
|          10 | Kavya Nair   | Gaming Headset    |    5999.00 |
|          10 | Kavya Nair   | Gaming Keyboard   |    4999.00 |
|          10 | Kavya Nair   | Gaming Mouse      |    2999.00 |
|          10 | Kavya Nair   | Camera            |   35000.00 |
|          10 | Kavya Nair   | USB Cable         |     399.00 |
|          10 | Kavya Nair   | Power Bank        |    1999.00 |
|          10 | Kavya Nair   | Backpack          |    2499.00 |
|          10 | Kavya Nair   | Yoga Mat          |    1299.00 |
|          10 | Kavya Nair   | Sports Bag        |    1999.00 |
|          10 | Kavya Nair   | Running Shoes     |    3499.00 |
|          10 | Kavya Nair   | Smart Watch       |    7999.00 |
|          10 | Kavya Nair   | Tablet            |   22000.00 |
|          10 | Kavya Nair   | Webcam            |    3999.00 |
|          10 | Kavya Nair   | Headphones        |    2499.00 |
|          10 | Kavya Nair   | Keyboard          |    1499.00 |
|          10 | Kavya Nair   | Monitor           |   12999.00 |
|          10 | Kavya Nair   | Laptop            |   55000.00 |
|          10 | Kavya Nair   | Mouse Pad         |     499.00 |
|          10 | Kavya Nair   | Monitor           |   12999.00 |
|          10 | Kavya Nair   | Headphones        |    2499.00 |
|          10 | Kavya Nair   | Keyboard          |    1499.00 |
|          10 | Kavya Nair   | Wireless Mouse    |     799.00 |
|          11 | Aditi Kapoor | Bluetooth Speaker |    3999.00 |
|          11 | Aditi Kapoor | Phone Case        |     599.00 |
|          11 | Aditi Kapoor | Smartphone        |   30000.00 |
|          11 | Aditi Kapoor | Desk Lamp         |    1299.00 |
|          11 | Aditi Kapoor | Ink Cartridge     |    1499.00 |
|          11 | Aditi Kapoor | Printer           |    8999.00 |
|          11 | Aditi Kapoor | Gaming Headset    |    5999.00 |
|          11 | Aditi Kapoor | Gaming Keyboard   |    4999.00 |
|          11 | Aditi Kapoor | Gaming Mouse      |    2999.00 |
|          11 | Aditi Kapoor | Camera            |   35000.00 |
|          11 | Aditi Kapoor | USB Cable         |     399.00 |
|          11 | Aditi Kapoor | Power Bank        |    1999.00 |
|          11 | Aditi Kapoor | Backpack          |    2499.00 |
|          11 | Aditi Kapoor | Yoga Mat          |    1299.00 |
|          11 | Aditi Kapoor | Sports Bag        |    1999.00 |
|          11 | Aditi Kapoor | Running Shoes     |    3499.00 |
|          11 | Aditi Kapoor | Smart Watch       |    7999.00 |
|          11 | Aditi Kapoor | Tablet            |   22000.00 |
|          11 | Aditi Kapoor | Webcam            |    3999.00 |
|          11 | Aditi Kapoor | Headphones        |    2499.00 |
|          11 | Aditi Kapoor | Keyboard          |    1499.00 |
|          11 | Aditi Kapoor | Monitor           |   12999.00 |
|          11 | Aditi Kapoor | Laptop            |   55000.00 |
|          11 | Aditi Kapoor | Mouse Pad         |     499.00 |
|          11 | Aditi Kapoor | Monitor           |   12999.00 |
|          11 | Aditi Kapoor | Headphones        |    2499.00 |
|          11 | Aditi Kapoor | Keyboard          |    1499.00 |
|          11 | Aditi Kapoor | Wireless Mouse    |     799.00 |
|          12 | Vikram Joshi | Bluetooth Speaker |    3999.00 |
|          12 | Vikram Joshi | Phone Case        |     599.00 |
|          12 | Vikram Joshi | Smartphone        |   30000.00 |
|          12 | Vikram Joshi | Desk Lamp         |    1299.00 |
|          12 | Vikram Joshi | Ink Cartridge     |    1499.00 |
|          12 | Vikram Joshi | Printer           |    8999.00 |
|          12 | Vikram Joshi | Gaming Headset    |    5999.00 |
|          12 | Vikram Joshi | Gaming Keyboard   |    4999.00 |
|          12 | Vikram Joshi | Gaming Mouse      |    2999.00 |
|          12 | Vikram Joshi | Camera            |   35000.00 |
|          12 | Vikram Joshi | USB Cable         |     399.00 |
|          12 | Vikram Joshi | Power Bank        |    1999.00 |
|          12 | Vikram Joshi | Backpack          |    2499.00 |
|          12 | Vikram Joshi | Yoga Mat          |    1299.00 |
|          12 | Vikram Joshi | Sports Bag        |    1999.00 |
|          12 | Vikram Joshi | Running Shoes     |    3499.00 |
|          12 | Vikram Joshi | Smart Watch       |    7999.00 |
|          12 | Vikram Joshi | Tablet            |   22000.00 |
|          12 | Vikram Joshi | Webcam            |    3999.00 |
|          12 | Vikram Joshi | Headphones        |    2499.00 |
|          12 | Vikram Joshi | Keyboard          |    1499.00 |
|          12 | Vikram Joshi | Monitor           |   12999.00 |
|          12 | Vikram Joshi | Laptop            |   55000.00 |
|          12 | Vikram Joshi | Mouse Pad         |     499.00 |
|          12 | Vikram Joshi | Monitor           |   12999.00 |
|          12 | Vikram Joshi | Headphones        |    2499.00 |
|          12 | Vikram Joshi | Keyboard          |    1499.00 |
|          12 | Vikram Joshi | Wireless Mouse    |     799.00 |
|          13 | Riya Das     | Bluetooth Speaker |    3999.00 |
|          13 | Riya Das     | Phone Case        |     599.00 |
|          13 | Riya Das     | Smartphone        |   30000.00 |
|          13 | Riya Das     | Desk Lamp         |    1299.00 |
|          13 | Riya Das     | Ink Cartridge     |    1499.00 |
|          13 | Riya Das     | Printer           |    8999.00 |
|          13 | Riya Das     | Gaming Headset    |    5999.00 |
|          13 | Riya Das     | Gaming Keyboard   |    4999.00 |
|          13 | Riya Das     | Gaming Mouse      |    2999.00 |
|          13 | Riya Das     | Camera            |   35000.00 |
|          13 | Riya Das     | USB Cable         |     399.00 |
|          13 | Riya Das     | Power Bank        |    1999.00 |
|          13 | Riya Das     | Backpack          |    2499.00 |
|          13 | Riya Das     | Yoga Mat          |    1299.00 |
|          13 | Riya Das     | Sports Bag        |    1999.00 |
|          13 | Riya Das     | Running Shoes     |    3499.00 |
|          13 | Riya Das     | Smart Watch       |    7999.00 |
|          13 | Riya Das     | Tablet            |   22000.00 |
|          13 | Riya Das     | Webcam            |    3999.00 |
|          13 | Riya Das     | Headphones        |    2499.00 |
|          13 | Riya Das     | Keyboard          |    1499.00 |
|          13 | Riya Das     | Monitor           |   12999.00 |
|          13 | Riya Das     | Laptop            |   55000.00 |
|          13 | Riya Das     | Mouse Pad         |     499.00 |
|          13 | Riya Das     | Monitor           |   12999.00 |
|          13 | Riya Das     | Headphones        |    2499.00 |
|          13 | Riya Das     | Keyboard          |    1499.00 |
|          13 | Riya Das     | Wireless Mouse    |     799.00 |
|          14 | Nisha Gupta  | Bluetooth Speaker |    3999.00 |
|          14 | Nisha Gupta  | Phone Case        |     599.00 |
|          14 | Nisha Gupta  | Smartphone        |   30000.00 |
|          14 | Nisha Gupta  | Desk Lamp         |    1299.00 |
|          14 | Nisha Gupta  | Ink Cartridge     |    1499.00 |
|          14 | Nisha Gupta  | Printer           |    8999.00 |
|          14 | Nisha Gupta  | Gaming Headset    |    5999.00 |
|          14 | Nisha Gupta  | Gaming Keyboard   |    4999.00 |
|          14 | Nisha Gupta  | Gaming Mouse      |    2999.00 |
|          14 | Nisha Gupta  | Camera            |   35000.00 |
|          14 | Nisha Gupta  | USB Cable         |     399.00 |
|          14 | Nisha Gupta  | Power Bank        |    1999.00 |
|          14 | Nisha Gupta  | Backpack          |    2499.00 |
|          14 | Nisha Gupta  | Yoga Mat          |    1299.00 |
|          14 | Nisha Gupta  | Sports Bag        |    1999.00 |
|          14 | Nisha Gupta  | Running Shoes     |    3499.00 |
|          14 | Nisha Gupta  | Smart Watch       |    7999.00 |
|          14 | Nisha Gupta  | Tablet            |   22000.00 |
|          14 | Nisha Gupta  | Webcam            |    3999.00 |
|          14 | Nisha Gupta  | Headphones        |    2499.00 |
|          14 | Nisha Gupta  | Keyboard          |    1499.00 |
|          14 | Nisha Gupta  | Monitor           |   12999.00 |
|          14 | Nisha Gupta  | Laptop            |   55000.00 |
|          14 | Nisha Gupta  | Mouse Pad         |     499.00 |
|          14 | Nisha Gupta  | Monitor           |   12999.00 |
|          14 | Nisha Gupta  | Headphones        |    2499.00 |
|          14 | Nisha Gupta  | Keyboard          |    1499.00 |
|          14 | Nisha Gupta  | Wireless Mouse    |     799.00 |
|          15 | Aman Khan    | Bluetooth Speaker |    3999.00 |
|          15 | Aman Khan    | Phone Case        |     599.00 |
|          15 | Aman Khan    | Smartphone        |   30000.00 |
|          15 | Aman Khan    | Desk Lamp         |    1299.00 |
|          15 | Aman Khan    | Ink Cartridge     |    1499.00 |
|          15 | Aman Khan    | Printer           |    8999.00 |
|          15 | Aman Khan    | Gaming Headset    |    5999.00 |
|          15 | Aman Khan    | Gaming Keyboard   |    4999.00 |
|          15 | Aman Khan    | Gaming Mouse      |    2999.00 |
|          15 | Aman Khan    | Camera            |   35000.00 |
|          15 | Aman Khan    | USB Cable         |     399.00 |
|          15 | Aman Khan    | Power Bank        |    1999.00 |
|          15 | Aman Khan    | Backpack          |    2499.00 |
|          15 | Aman Khan    | Yoga Mat          |    1299.00 |
|          15 | Aman Khan    | Sports Bag        |    1999.00 |
|          15 | Aman Khan    | Running Shoes     |    3499.00 |
|          15 | Aman Khan    | Smart Watch       |    7999.00 |
|          15 | Aman Khan    | Tablet            |   22000.00 |
|          15 | Aman Khan    | Webcam            |    3999.00 |
|          15 | Aman Khan    | Headphones        |    2499.00 |
|          15 | Aman Khan    | Keyboard          |    1499.00 |
|          15 | Aman Khan    | Monitor           |   12999.00 |
|          15 | Aman Khan    | Laptop            |   55000.00 |
|          15 | Aman Khan    | Mouse Pad         |     499.00 |
|          15 | Aman Khan    | Monitor           |   12999.00 |
|          15 | Aman Khan    | Headphones        |    2499.00 |
|          15 | Aman Khan    | Keyboard          |    1499.00 |
|          15 | Aman Khan    | Wireless Mouse    |     799.00 |
+-------------+--------------+-------------------+------------+
420 rows in set (0.05 sec)

mysql> select c.customer_id,c.full_name,o.product_name,o.unit_price  from customers c inner join  orders o where o.order_status='Completed' and o.unit_price=( select max(o.unit_price) from orders o2 where o.customer_id=o2.customer_id and o2.order_status='Completed' group by o2.customer_id);
+-------------+--------------+-------------------+------------+
| customer_id | full_name    | product_name      | unit_price |
+-------------+--------------+-------------------+------------+
|           1 | Aarav Sharma | Bluetooth Speaker |    3999.00 |
|           1 | Aarav Sharma | Phone Case        |     599.00 |
|           1 | Aarav Sharma | Smartphone        |   30000.00 |
|           1 | Aarav Sharma | Desk Lamp         |    1299.00 |
|           1 | Aarav Sharma | Ink Cartridge     |    1499.00 |
|           1 | Aarav Sharma | Printer           |    8999.00 |
|           1 | Aarav Sharma | Gaming Headset    |    5999.00 |
|           1 | Aarav Sharma | Gaming Keyboard   |    4999.00 |
|           1 | Aarav Sharma | Gaming Mouse      |    2999.00 |
|           1 | Aarav Sharma | Camera            |   35000.00 |
|           1 | Aarav Sharma | USB Cable         |     399.00 |
|           1 | Aarav Sharma | Power Bank        |    1999.00 |
|           1 | Aarav Sharma | Backpack          |    2499.00 |
|           1 | Aarav Sharma | Yoga Mat          |    1299.00 |
|           1 | Aarav Sharma | Sports Bag        |    1999.00 |
|           1 | Aarav Sharma | Running Shoes     |    3499.00 |
|           1 | Aarav Sharma | Smart Watch       |    7999.00 |
|           1 | Aarav Sharma | Tablet            |   22000.00 |
|           1 | Aarav Sharma | Webcam            |    3999.00 |
|           1 | Aarav Sharma | Headphones        |    2499.00 |
|           1 | Aarav Sharma | Keyboard          |    1499.00 |
|           1 | Aarav Sharma | Monitor           |   12999.00 |
|           1 | Aarav Sharma | Laptop            |   55000.00 |
|           1 | Aarav Sharma | Mouse Pad         |     499.00 |
|           1 | Aarav Sharma | Monitor           |   12999.00 |
|           1 | Aarav Sharma | Headphones        |    2499.00 |
|           1 | Aarav Sharma | Keyboard          |    1499.00 |
|           1 | Aarav Sharma | Wireless Mouse    |     799.00 |
|           2 | Priya Reddy  | Bluetooth Speaker |    3999.00 |
|           2 | Priya Reddy  | Phone Case        |     599.00 |
|           2 | Priya Reddy  | Smartphone        |   30000.00 |
|           2 | Priya Reddy  | Desk Lamp         |    1299.00 |
|           2 | Priya Reddy  | Ink Cartridge     |    1499.00 |
|           2 | Priya Reddy  | Printer           |    8999.00 |
|           2 | Priya Reddy  | Gaming Headset    |    5999.00 |
|           2 | Priya Reddy  | Gaming Keyboard   |    4999.00 |
|           2 | Priya Reddy  | Gaming Mouse      |    2999.00 |
|           2 | Priya Reddy  | Camera            |   35000.00 |
|           2 | Priya Reddy  | USB Cable         |     399.00 |
|           2 | Priya Reddy  | Power Bank        |    1999.00 |
|           2 | Priya Reddy  | Backpack          |    2499.00 |
|           2 | Priya Reddy  | Yoga Mat          |    1299.00 |
|           2 | Priya Reddy  | Sports Bag        |    1999.00 |
|           2 | Priya Reddy  | Running Shoes     |    3499.00 |
|           2 | Priya Reddy  | Smart Watch       |    7999.00 |
|           2 | Priya Reddy  | Tablet            |   22000.00 |
|           2 | Priya Reddy  | Webcam            |    3999.00 |
|           2 | Priya Reddy  | Headphones        |    2499.00 |
|           2 | Priya Reddy  | Keyboard          |    1499.00 |
|           2 | Priya Reddy  | Monitor           |   12999.00 |
|           2 | Priya Reddy  | Laptop            |   55000.00 |
|           2 | Priya Reddy  | Mouse Pad         |     499.00 |
|           2 | Priya Reddy  | Monitor           |   12999.00 |
|           2 | Priya Reddy  | Headphones        |    2499.00 |
|           2 | Priya Reddy  | Keyboard          |    1499.00 |
|           2 | Priya Reddy  | Wireless Mouse    |     799.00 |
|           3 | Rahul Verma  | Bluetooth Speaker |    3999.00 |
|           3 | Rahul Verma  | Phone Case        |     599.00 |
|           3 | Rahul Verma  | Smartphone        |   30000.00 |
|           3 | Rahul Verma  | Desk Lamp         |    1299.00 |
|           3 | Rahul Verma  | Ink Cartridge     |    1499.00 |
|           3 | Rahul Verma  | Printer           |    8999.00 |
|           3 | Rahul Verma  | Gaming Headset    |    5999.00 |
|           3 | Rahul Verma  | Gaming Keyboard   |    4999.00 |
|           3 | Rahul Verma  | Gaming Mouse      |    2999.00 |
|           3 | Rahul Verma  | Camera            |   35000.00 |
|           3 | Rahul Verma  | USB Cable         |     399.00 |
|           3 | Rahul Verma  | Power Bank        |    1999.00 |
|           3 | Rahul Verma  | Backpack          |    2499.00 |
|           3 | Rahul Verma  | Yoga Mat          |    1299.00 |
|           3 | Rahul Verma  | Sports Bag        |    1999.00 |
|           3 | Rahul Verma  | Running Shoes     |    3499.00 |
|           3 | Rahul Verma  | Smart Watch       |    7999.00 |
|           3 | Rahul Verma  | Tablet            |   22000.00 |
|           3 | Rahul Verma  | Webcam            |    3999.00 |
|           3 | Rahul Verma  | Headphones        |    2499.00 |
|           3 | Rahul Verma  | Keyboard          |    1499.00 |
|           3 | Rahul Verma  | Monitor           |   12999.00 |
|           3 | Rahul Verma  | Laptop            |   55000.00 |
|           3 | Rahul Verma  | Mouse Pad         |     499.00 |
|           3 | Rahul Verma  | Monitor           |   12999.00 |
|           3 | Rahul Verma  | Headphones        |    2499.00 |
|           3 | Rahul Verma  | Keyboard          |    1499.00 |
|           3 | Rahul Verma  | Wireless Mouse    |     799.00 |
|           4 | Ananya Rao   | Bluetooth Speaker |    3999.00 |
|           4 | Ananya Rao   | Phone Case        |     599.00 |
|           4 | Ananya Rao   | Smartphone        |   30000.00 |
|           4 | Ananya Rao   | Desk Lamp         |    1299.00 |
|           4 | Ananya Rao   | Ink Cartridge     |    1499.00 |
|           4 | Ananya Rao   | Printer           |    8999.00 |
|           4 | Ananya Rao   | Gaming Headset    |    5999.00 |
|           4 | Ananya Rao   | Gaming Keyboard   |    4999.00 |
|           4 | Ananya Rao   | Gaming Mouse      |    2999.00 |
|           4 | Ananya Rao   | Camera            |   35000.00 |
|           4 | Ananya Rao   | USB Cable         |     399.00 |
|           4 | Ananya Rao   | Power Bank        |    1999.00 |
|           4 | Ananya Rao   | Backpack          |    2499.00 |
|           4 | Ananya Rao   | Yoga Mat          |    1299.00 |
|           4 | Ananya Rao   | Sports Bag        |    1999.00 |
|           4 | Ananya Rao   | Running Shoes     |    3499.00 |
|           4 | Ananya Rao   | Smart Watch       |    7999.00 |
|           4 | Ananya Rao   | Tablet            |   22000.00 |
|           4 | Ananya Rao   | Webcam            |    3999.00 |
|           4 | Ananya Rao   | Headphones        |    2499.00 |
|           4 | Ananya Rao   | Keyboard          |    1499.00 |
|           4 | Ananya Rao   | Monitor           |   12999.00 |
|           4 | Ananya Rao   | Laptop            |   55000.00 |
|           4 | Ananya Rao   | Mouse Pad         |     499.00 |
|           4 | Ananya Rao   | Monitor           |   12999.00 |
|           4 | Ananya Rao   | Headphones        |    2499.00 |
|           4 | Ananya Rao   | Keyboard          |    1499.00 |
|           4 | Ananya Rao   | Wireless Mouse    |     799.00 |
|           5 | Rohan Mehta  | Bluetooth Speaker |    3999.00 |
|           5 | Rohan Mehta  | Phone Case        |     599.00 |
|           5 | Rohan Mehta  | Smartphone        |   30000.00 |
|           5 | Rohan Mehta  | Desk Lamp         |    1299.00 |
|           5 | Rohan Mehta  | Ink Cartridge     |    1499.00 |
|           5 | Rohan Mehta  | Printer           |    8999.00 |
|           5 | Rohan Mehta  | Gaming Headset    |    5999.00 |
|           5 | Rohan Mehta  | Gaming Keyboard   |    4999.00 |
|           5 | Rohan Mehta  | Gaming Mouse      |    2999.00 |
|           5 | Rohan Mehta  | Camera            |   35000.00 |
|           5 | Rohan Mehta  | USB Cable         |     399.00 |
|           5 | Rohan Mehta  | Power Bank        |    1999.00 |
|           5 | Rohan Mehta  | Backpack          |    2499.00 |
|           5 | Rohan Mehta  | Yoga Mat          |    1299.00 |
|           5 | Rohan Mehta  | Sports Bag        |    1999.00 |
|           5 | Rohan Mehta  | Running Shoes     |    3499.00 |
|           5 | Rohan Mehta  | Smart Watch       |    7999.00 |
|           5 | Rohan Mehta  | Tablet            |   22000.00 |
|           5 | Rohan Mehta  | Webcam            |    3999.00 |
|           5 | Rohan Mehta  | Headphones        |    2499.00 |
|           5 | Rohan Mehta  | Keyboard          |    1499.00 |
|           5 | Rohan Mehta  | Monitor           |   12999.00 |
|           5 | Rohan Mehta  | Laptop            |   55000.00 |
|           5 | Rohan Mehta  | Mouse Pad         |     499.00 |
|           5 | Rohan Mehta  | Monitor           |   12999.00 |
|           5 | Rohan Mehta  | Headphones        |    2499.00 |
|           5 | Rohan Mehta  | Keyboard          |    1499.00 |
|           5 | Rohan Mehta  | Wireless Mouse    |     799.00 |
|           6 | Sneha Patel  | Bluetooth Speaker |    3999.00 |
|           6 | Sneha Patel  | Phone Case        |     599.00 |
|           6 | Sneha Patel  | Smartphone        |   30000.00 |
|           6 | Sneha Patel  | Desk Lamp         |    1299.00 |
|           6 | Sneha Patel  | Ink Cartridge     |    1499.00 |
|           6 | Sneha Patel  | Printer           |    8999.00 |
|           6 | Sneha Patel  | Gaming Headset    |    5999.00 |
|           6 | Sneha Patel  | Gaming Keyboard   |    4999.00 |
|           6 | Sneha Patel  | Gaming Mouse      |    2999.00 |
|           6 | Sneha Patel  | Camera            |   35000.00 |
|           6 | Sneha Patel  | USB Cable         |     399.00 |
|           6 | Sneha Patel  | Power Bank        |    1999.00 |
|           6 | Sneha Patel  | Backpack          |    2499.00 |
|           6 | Sneha Patel  | Yoga Mat          |    1299.00 |
|           6 | Sneha Patel  | Sports Bag        |    1999.00 |
|           6 | Sneha Patel  | Running Shoes     |    3499.00 |
|           6 | Sneha Patel  | Smart Watch       |    7999.00 |
|           6 | Sneha Patel  | Tablet            |   22000.00 |
|           6 | Sneha Patel  | Webcam            |    3999.00 |
|           6 | Sneha Patel  | Headphones        |    2499.00 |
|           6 | Sneha Patel  | Keyboard          |    1499.00 |
|           6 | Sneha Patel  | Monitor           |   12999.00 |
|           6 | Sneha Patel  | Laptop            |   55000.00 |
|           6 | Sneha Patel  | Mouse Pad         |     499.00 |
|           6 | Sneha Patel  | Monitor           |   12999.00 |
|           6 | Sneha Patel  | Headphones        |    2499.00 |
|           6 | Sneha Patel  | Keyboard          |    1499.00 |
|           6 | Sneha Patel  | Wireless Mouse    |     799.00 |
|           7 | Arjun Kumar  | Bluetooth Speaker |    3999.00 |
|           7 | Arjun Kumar  | Phone Case        |     599.00 |
|           7 | Arjun Kumar  | Smartphone        |   30000.00 |
|           7 | Arjun Kumar  | Desk Lamp         |    1299.00 |
|           7 | Arjun Kumar  | Ink Cartridge     |    1499.00 |
|           7 | Arjun Kumar  | Printer           |    8999.00 |
|           7 | Arjun Kumar  | Gaming Headset    |    5999.00 |
|           7 | Arjun Kumar  | Gaming Keyboard   |    4999.00 |
|           7 | Arjun Kumar  | Gaming Mouse      |    2999.00 |
|           7 | Arjun Kumar  | Camera            |   35000.00 |
|           7 | Arjun Kumar  | USB Cable         |     399.00 |
|           7 | Arjun Kumar  | Power Bank        |    1999.00 |
|           7 | Arjun Kumar  | Backpack          |    2499.00 |
|           7 | Arjun Kumar  | Yoga Mat          |    1299.00 |
|           7 | Arjun Kumar  | Sports Bag        |    1999.00 |
|           7 | Arjun Kumar  | Running Shoes     |    3499.00 |
|           7 | Arjun Kumar  | Smart Watch       |    7999.00 |
|           7 | Arjun Kumar  | Tablet            |   22000.00 |
|           7 | Arjun Kumar  | Webcam            |    3999.00 |
|           7 | Arjun Kumar  | Headphones        |    2499.00 |
|           7 | Arjun Kumar  | Keyboard          |    1499.00 |
|           7 | Arjun Kumar  | Monitor           |   12999.00 |
|           7 | Arjun Kumar  | Laptop            |   55000.00 |
|           7 | Arjun Kumar  | Mouse Pad         |     499.00 |
|           7 | Arjun Kumar  | Monitor           |   12999.00 |
|           7 | Arjun Kumar  | Headphones        |    2499.00 |
|           7 | Arjun Kumar  | Keyboard          |    1499.00 |
|           7 | Arjun Kumar  | Wireless Mouse    |     799.00 |
|           8 | Neha Singh   | Bluetooth Speaker |    3999.00 |
|           8 | Neha Singh   | Phone Case        |     599.00 |
|           8 | Neha Singh   | Smartphone        |   30000.00 |
|           8 | Neha Singh   | Desk Lamp         |    1299.00 |
|           8 | Neha Singh   | Ink Cartridge     |    1499.00 |
|           8 | Neha Singh   | Printer           |    8999.00 |
|           8 | Neha Singh   | Gaming Headset    |    5999.00 |
|           8 | Neha Singh   | Gaming Keyboard   |    4999.00 |
|           8 | Neha Singh   | Gaming Mouse      |    2999.00 |
|           8 | Neha Singh   | Camera            |   35000.00 |
|           8 | Neha Singh   | USB Cable         |     399.00 |
|           8 | Neha Singh   | Power Bank        |    1999.00 |
|           8 | Neha Singh   | Backpack          |    2499.00 |
|           8 | Neha Singh   | Yoga Mat          |    1299.00 |
|           8 | Neha Singh   | Sports Bag        |    1999.00 |
|           8 | Neha Singh   | Running Shoes     |    3499.00 |
|           8 | Neha Singh   | Smart Watch       |    7999.00 |
|           8 | Neha Singh   | Tablet            |   22000.00 |
|           8 | Neha Singh   | Webcam            |    3999.00 |
|           8 | Neha Singh   | Headphones        |    2499.00 |
|           8 | Neha Singh   | Keyboard          |    1499.00 |
|           8 | Neha Singh   | Monitor           |   12999.00 |
|           8 | Neha Singh   | Laptop            |   55000.00 |
|           8 | Neha Singh   | Mouse Pad         |     499.00 |
|           8 | Neha Singh   | Monitor           |   12999.00 |
|           8 | Neha Singh   | Headphones        |    2499.00 |
|           8 | Neha Singh   | Keyboard          |    1499.00 |
|           8 | Neha Singh   | Wireless Mouse    |     799.00 |
|           9 | Raj Malhotra | Bluetooth Speaker |    3999.00 |
|           9 | Raj Malhotra | Phone Case        |     599.00 |
|           9 | Raj Malhotra | Smartphone        |   30000.00 |
|           9 | Raj Malhotra | Desk Lamp         |    1299.00 |
|           9 | Raj Malhotra | Ink Cartridge     |    1499.00 |
|           9 | Raj Malhotra | Printer           |    8999.00 |
|           9 | Raj Malhotra | Gaming Headset    |    5999.00 |
|           9 | Raj Malhotra | Gaming Keyboard   |    4999.00 |
|           9 | Raj Malhotra | Gaming Mouse      |    2999.00 |
|           9 | Raj Malhotra | Camera            |   35000.00 |
|           9 | Raj Malhotra | USB Cable         |     399.00 |
|           9 | Raj Malhotra | Power Bank        |    1999.00 |
|           9 | Raj Malhotra | Backpack          |    2499.00 |
|           9 | Raj Malhotra | Yoga Mat          |    1299.00 |
|           9 | Raj Malhotra | Sports Bag        |    1999.00 |
|           9 | Raj Malhotra | Running Shoes     |    3499.00 |
|           9 | Raj Malhotra | Smart Watch       |    7999.00 |
|           9 | Raj Malhotra | Tablet            |   22000.00 |
|           9 | Raj Malhotra | Webcam            |    3999.00 |
|           9 | Raj Malhotra | Headphones        |    2499.00 |
|           9 | Raj Malhotra | Keyboard          |    1499.00 |
|           9 | Raj Malhotra | Monitor           |   12999.00 |
|           9 | Raj Malhotra | Laptop            |   55000.00 |
|           9 | Raj Malhotra | Mouse Pad         |     499.00 |
|           9 | Raj Malhotra | Monitor           |   12999.00 |
|           9 | Raj Malhotra | Headphones        |    2499.00 |
|           9 | Raj Malhotra | Keyboard          |    1499.00 |
|           9 | Raj Malhotra | Wireless Mouse    |     799.00 |
|          10 | Kavya Nair   | Bluetooth Speaker |    3999.00 |
|          10 | Kavya Nair   | Phone Case        |     599.00 |
|          10 | Kavya Nair   | Smartphone        |   30000.00 |
|          10 | Kavya Nair   | Desk Lamp         |    1299.00 |
|          10 | Kavya Nair   | Ink Cartridge     |    1499.00 |
|          10 | Kavya Nair   | Printer           |    8999.00 |
|          10 | Kavya Nair   | Gaming Headset    |    5999.00 |
|          10 | Kavya Nair   | Gaming Keyboard   |    4999.00 |
|          10 | Kavya Nair   | Gaming Mouse      |    2999.00 |
|          10 | Kavya Nair   | Camera            |   35000.00 |
|          10 | Kavya Nair   | USB Cable         |     399.00 |
|          10 | Kavya Nair   | Power Bank        |    1999.00 |
|          10 | Kavya Nair   | Backpack          |    2499.00 |
|          10 | Kavya Nair   | Yoga Mat          |    1299.00 |
|          10 | Kavya Nair   | Sports Bag        |    1999.00 |
|          10 | Kavya Nair   | Running Shoes     |    3499.00 |
|          10 | Kavya Nair   | Smart Watch       |    7999.00 |
|          10 | Kavya Nair   | Tablet            |   22000.00 |
|          10 | Kavya Nair   | Webcam            |    3999.00 |
|          10 | Kavya Nair   | Headphones        |    2499.00 |
|          10 | Kavya Nair   | Keyboard          |    1499.00 |
|          10 | Kavya Nair   | Monitor           |   12999.00 |
|          10 | Kavya Nair   | Laptop            |   55000.00 |
|          10 | Kavya Nair   | Mouse Pad         |     499.00 |
|          10 | Kavya Nair   | Monitor           |   12999.00 |
|          10 | Kavya Nair   | Headphones        |    2499.00 |
|          10 | Kavya Nair   | Keyboard          |    1499.00 |
|          10 | Kavya Nair   | Wireless Mouse    |     799.00 |
|          11 | Aditi Kapoor | Bluetooth Speaker |    3999.00 |
|          11 | Aditi Kapoor | Phone Case        |     599.00 |
|          11 | Aditi Kapoor | Smartphone        |   30000.00 |
|          11 | Aditi Kapoor | Desk Lamp         |    1299.00 |
|          11 | Aditi Kapoor | Ink Cartridge     |    1499.00 |
|          11 | Aditi Kapoor | Printer           |    8999.00 |
|          11 | Aditi Kapoor | Gaming Headset    |    5999.00 |
|          11 | Aditi Kapoor | Gaming Keyboard   |    4999.00 |
|          11 | Aditi Kapoor | Gaming Mouse      |    2999.00 |
|          11 | Aditi Kapoor | Camera            |   35000.00 |
|          11 | Aditi Kapoor | USB Cable         |     399.00 |
|          11 | Aditi Kapoor | Power Bank        |    1999.00 |
|          11 | Aditi Kapoor | Backpack          |    2499.00 |
|          11 | Aditi Kapoor | Yoga Mat          |    1299.00 |
|          11 | Aditi Kapoor | Sports Bag        |    1999.00 |
|          11 | Aditi Kapoor | Running Shoes     |    3499.00 |
|          11 | Aditi Kapoor | Smart Watch       |    7999.00 |
|          11 | Aditi Kapoor | Tablet            |   22000.00 |
|          11 | Aditi Kapoor | Webcam            |    3999.00 |
|          11 | Aditi Kapoor | Headphones        |    2499.00 |
|          11 | Aditi Kapoor | Keyboard          |    1499.00 |
|          11 | Aditi Kapoor | Monitor           |   12999.00 |
|          11 | Aditi Kapoor | Laptop            |   55000.00 |
|          11 | Aditi Kapoor | Mouse Pad         |     499.00 |
|          11 | Aditi Kapoor | Monitor           |   12999.00 |
|          11 | Aditi Kapoor | Headphones        |    2499.00 |
|          11 | Aditi Kapoor | Keyboard          |    1499.00 |
|          11 | Aditi Kapoor | Wireless Mouse    |     799.00 |
|          12 | Vikram Joshi | Bluetooth Speaker |    3999.00 |
|          12 | Vikram Joshi | Phone Case        |     599.00 |
|          12 | Vikram Joshi | Smartphone        |   30000.00 |
|          12 | Vikram Joshi | Desk Lamp         |    1299.00 |
|          12 | Vikram Joshi | Ink Cartridge     |    1499.00 |
|          12 | Vikram Joshi | Printer           |    8999.00 |
|          12 | Vikram Joshi | Gaming Headset    |    5999.00 |
|          12 | Vikram Joshi | Gaming Keyboard   |    4999.00 |
|          12 | Vikram Joshi | Gaming Mouse      |    2999.00 |
|          12 | Vikram Joshi | Camera            |   35000.00 |
|          12 | Vikram Joshi | USB Cable         |     399.00 |
|          12 | Vikram Joshi | Power Bank        |    1999.00 |
|          12 | Vikram Joshi | Backpack          |    2499.00 |
|          12 | Vikram Joshi | Yoga Mat          |    1299.00 |
|          12 | Vikram Joshi | Sports Bag        |    1999.00 |
|          12 | Vikram Joshi | Running Shoes     |    3499.00 |
|          12 | Vikram Joshi | Smart Watch       |    7999.00 |
|          12 | Vikram Joshi | Tablet            |   22000.00 |
|          12 | Vikram Joshi | Webcam            |    3999.00 |
|          12 | Vikram Joshi | Headphones        |    2499.00 |
|          12 | Vikram Joshi | Keyboard          |    1499.00 |
|          12 | Vikram Joshi | Monitor           |   12999.00 |
|          12 | Vikram Joshi | Laptop            |   55000.00 |
|          12 | Vikram Joshi | Mouse Pad         |     499.00 |
|          12 | Vikram Joshi | Monitor           |   12999.00 |
|          12 | Vikram Joshi | Headphones        |    2499.00 |
|          12 | Vikram Joshi | Keyboard          |    1499.00 |
|          12 | Vikram Joshi | Wireless Mouse    |     799.00 |
|          13 | Riya Das     | Bluetooth Speaker |    3999.00 |
|          13 | Riya Das     | Phone Case        |     599.00 |
|          13 | Riya Das     | Smartphone        |   30000.00 |
|          13 | Riya Das     | Desk Lamp         |    1299.00 |
|          13 | Riya Das     | Ink Cartridge     |    1499.00 |
|          13 | Riya Das     | Printer           |    8999.00 |
|          13 | Riya Das     | Gaming Headset    |    5999.00 |
|          13 | Riya Das     | Gaming Keyboard   |    4999.00 |
|          13 | Riya Das     | Gaming Mouse      |    2999.00 |
|          13 | Riya Das     | Camera            |   35000.00 |
|          13 | Riya Das     | USB Cable         |     399.00 |
|          13 | Riya Das     | Power Bank        |    1999.00 |
|          13 | Riya Das     | Backpack          |    2499.00 |
|          13 | Riya Das     | Yoga Mat          |    1299.00 |
|          13 | Riya Das     | Sports Bag        |    1999.00 |
|          13 | Riya Das     | Running Shoes     |    3499.00 |
|          13 | Riya Das     | Smart Watch       |    7999.00 |
|          13 | Riya Das     | Tablet            |   22000.00 |
|          13 | Riya Das     | Webcam            |    3999.00 |
|          13 | Riya Das     | Headphones        |    2499.00 |
|          13 | Riya Das     | Keyboard          |    1499.00 |
|          13 | Riya Das     | Monitor           |   12999.00 |
|          13 | Riya Das     | Laptop            |   55000.00 |
|          13 | Riya Das     | Mouse Pad         |     499.00 |
|          13 | Riya Das     | Monitor           |   12999.00 |
|          13 | Riya Das     | Headphones        |    2499.00 |
|          13 | Riya Das     | Keyboard          |    1499.00 |
|          13 | Riya Das     | Wireless Mouse    |     799.00 |
|          14 | Nisha Gupta  | Bluetooth Speaker |    3999.00 |
|          14 | Nisha Gupta  | Phone Case        |     599.00 |
|          14 | Nisha Gupta  | Smartphone        |   30000.00 |
|          14 | Nisha Gupta  | Desk Lamp         |    1299.00 |
|          14 | Nisha Gupta  | Ink Cartridge     |    1499.00 |
|          14 | Nisha Gupta  | Printer           |    8999.00 |
|          14 | Nisha Gupta  | Gaming Headset    |    5999.00 |
|          14 | Nisha Gupta  | Gaming Keyboard   |    4999.00 |
|          14 | Nisha Gupta  | Gaming Mouse      |    2999.00 |
|          14 | Nisha Gupta  | Camera            |   35000.00 |
|          14 | Nisha Gupta  | USB Cable         |     399.00 |
|          14 | Nisha Gupta  | Power Bank        |    1999.00 |
|          14 | Nisha Gupta  | Backpack          |    2499.00 |
|          14 | Nisha Gupta  | Yoga Mat          |    1299.00 |
|          14 | Nisha Gupta  | Sports Bag        |    1999.00 |
|          14 | Nisha Gupta  | Running Shoes     |    3499.00 |
|          14 | Nisha Gupta  | Smart Watch       |    7999.00 |
|          14 | Nisha Gupta  | Tablet            |   22000.00 |
|          14 | Nisha Gupta  | Webcam            |    3999.00 |
|          14 | Nisha Gupta  | Headphones        |    2499.00 |
|          14 | Nisha Gupta  | Keyboard          |    1499.00 |
|          14 | Nisha Gupta  | Monitor           |   12999.00 |
|          14 | Nisha Gupta  | Laptop            |   55000.00 |
|          14 | Nisha Gupta  | Mouse Pad         |     499.00 |
|          14 | Nisha Gupta  | Monitor           |   12999.00 |
|          14 | Nisha Gupta  | Headphones        |    2499.00 |
|          14 | Nisha Gupta  | Keyboard          |    1499.00 |
|          14 | Nisha Gupta  | Wireless Mouse    |     799.00 |
|          15 | Aman Khan    | Bluetooth Speaker |    3999.00 |
|          15 | Aman Khan    | Phone Case        |     599.00 |
|          15 | Aman Khan    | Smartphone        |   30000.00 |
|          15 | Aman Khan    | Desk Lamp         |    1299.00 |
|          15 | Aman Khan    | Ink Cartridge     |    1499.00 |
|          15 | Aman Khan    | Printer           |    8999.00 |
|          15 | Aman Khan    | Gaming Headset    |    5999.00 |
|          15 | Aman Khan    | Gaming Keyboard   |    4999.00 |
|          15 | Aman Khan    | Gaming Mouse      |    2999.00 |
|          15 | Aman Khan    | Camera            |   35000.00 |
|          15 | Aman Khan    | USB Cable         |     399.00 |
|          15 | Aman Khan    | Power Bank        |    1999.00 |
|          15 | Aman Khan    | Backpack          |    2499.00 |
|          15 | Aman Khan    | Yoga Mat          |    1299.00 |
|          15 | Aman Khan    | Sports Bag        |    1999.00 |
|          15 | Aman Khan    | Running Shoes     |    3499.00 |
|          15 | Aman Khan    | Smart Watch       |    7999.00 |
|          15 | Aman Khan    | Tablet            |   22000.00 |
|          15 | Aman Khan    | Webcam            |    3999.00 |
|          15 | Aman Khan    | Headphones        |    2499.00 |
|          15 | Aman Khan    | Keyboard          |    1499.00 |
|          15 | Aman Khan    | Monitor           |   12999.00 |
|          15 | Aman Khan    | Laptop            |   55000.00 |
|          15 | Aman Khan    | Mouse Pad         |     499.00 |
|          15 | Aman Khan    | Monitor           |   12999.00 |
|          15 | Aman Khan    | Headphones        |    2499.00 |
|          15 | Aman Khan    | Keyboard          |    1499.00 |
|          15 | Aman Khan    | Wireless Mouse    |     799.00 |
+-------------+--------------+-------------------+------------+
420 rows in set (0.00 sec)

mysql> select c.customer_id,c.full_name,o.product_name,o.unit_price  from customers c inner join  orders o where o.order_status='Completed' and o.unit_price=( select max(o2.unit_price) from orders o2 where o.customer_id=o2.customer_id and o2.order_status='Completed' group by o2.customer_id);
+-------------+--------------+-------------------+------------+
| customer_id | full_name    | product_name      | unit_price |
+-------------+--------------+-------------------+------------+
|           1 | Aarav Sharma | Bluetooth Speaker |    3999.00 |
|           1 | Aarav Sharma | Smartphone        |   30000.00 |
|           1 | Aarav Sharma | Desk Lamp         |    1299.00 |
|           1 | Aarav Sharma | Printer           |    8999.00 |
|           1 | Aarav Sharma | Gaming Headset    |    5999.00 |
|           1 | Aarav Sharma | Camera            |   35000.00 |
|           1 | Aarav Sharma | Backpack          |    2499.00 |
|           1 | Aarav Sharma | Yoga Mat          |    1299.00 |
|           1 | Aarav Sharma | Smart Watch       |    7999.00 |
|           1 | Aarav Sharma | Tablet            |   22000.00 |
|           1 | Aarav Sharma | Laptop            |   55000.00 |
|           1 | Aarav Sharma | Monitor           |   12999.00 |
|           1 | Aarav Sharma | Headphones        |    2499.00 |
|           2 | Priya Reddy  | Bluetooth Speaker |    3999.00 |
|           2 | Priya Reddy  | Smartphone        |   30000.00 |
|           2 | Priya Reddy  | Desk Lamp         |    1299.00 |
|           2 | Priya Reddy  | Printer           |    8999.00 |
|           2 | Priya Reddy  | Gaming Headset    |    5999.00 |
|           2 | Priya Reddy  | Camera            |   35000.00 |
|           2 | Priya Reddy  | Backpack          |    2499.00 |
|           2 | Priya Reddy  | Yoga Mat          |    1299.00 |
|           2 | Priya Reddy  | Smart Watch       |    7999.00 |
|           2 | Priya Reddy  | Tablet            |   22000.00 |
|           2 | Priya Reddy  | Laptop            |   55000.00 |
|           2 | Priya Reddy  | Monitor           |   12999.00 |
|           2 | Priya Reddy  | Headphones        |    2499.00 |
|           3 | Rahul Verma  | Bluetooth Speaker |    3999.00 |
|           3 | Rahul Verma  | Smartphone        |   30000.00 |
|           3 | Rahul Verma  | Desk Lamp         |    1299.00 |
|           3 | Rahul Verma  | Printer           |    8999.00 |
|           3 | Rahul Verma  | Gaming Headset    |    5999.00 |
|           3 | Rahul Verma  | Camera            |   35000.00 |
|           3 | Rahul Verma  | Backpack          |    2499.00 |
|           3 | Rahul Verma  | Yoga Mat          |    1299.00 |
|           3 | Rahul Verma  | Smart Watch       |    7999.00 |
|           3 | Rahul Verma  | Tablet            |   22000.00 |
|           3 | Rahul Verma  | Laptop            |   55000.00 |
|           3 | Rahul Verma  | Monitor           |   12999.00 |
|           3 | Rahul Verma  | Headphones        |    2499.00 |
|           4 | Ananya Rao   | Bluetooth Speaker |    3999.00 |
|           4 | Ananya Rao   | Smartphone        |   30000.00 |
|           4 | Ananya Rao   | Desk Lamp         |    1299.00 |
|           4 | Ananya Rao   | Printer           |    8999.00 |
|           4 | Ananya Rao   | Gaming Headset    |    5999.00 |
|           4 | Ananya Rao   | Camera            |   35000.00 |
|           4 | Ananya Rao   | Backpack          |    2499.00 |
|           4 | Ananya Rao   | Yoga Mat          |    1299.00 |
|           4 | Ananya Rao   | Smart Watch       |    7999.00 |
|           4 | Ananya Rao   | Tablet            |   22000.00 |
|           4 | Ananya Rao   | Laptop            |   55000.00 |
|           4 | Ananya Rao   | Monitor           |   12999.00 |
|           4 | Ananya Rao   | Headphones        |    2499.00 |
|           5 | Rohan Mehta  | Bluetooth Speaker |    3999.00 |
|           5 | Rohan Mehta  | Smartphone        |   30000.00 |
|           5 | Rohan Mehta  | Desk Lamp         |    1299.00 |
|           5 | Rohan Mehta  | Printer           |    8999.00 |
|           5 | Rohan Mehta  | Gaming Headset    |    5999.00 |
|           5 | Rohan Mehta  | Camera            |   35000.00 |
|           5 | Rohan Mehta  | Backpack          |    2499.00 |
|           5 | Rohan Mehta  | Yoga Mat          |    1299.00 |
|           5 | Rohan Mehta  | Smart Watch       |    7999.00 |
|           5 | Rohan Mehta  | Tablet            |   22000.00 |
|           5 | Rohan Mehta  | Laptop            |   55000.00 |
|           5 | Rohan Mehta  | Monitor           |   12999.00 |
|           5 | Rohan Mehta  | Headphones        |    2499.00 |
|           6 | Sneha Patel  | Bluetooth Speaker |    3999.00 |
|           6 | Sneha Patel  | Smartphone        |   30000.00 |
|           6 | Sneha Patel  | Desk Lamp         |    1299.00 |
|           6 | Sneha Patel  | Printer           |    8999.00 |
|           6 | Sneha Patel  | Gaming Headset    |    5999.00 |
|           6 | Sneha Patel  | Camera            |   35000.00 |
|           6 | Sneha Patel  | Backpack          |    2499.00 |
|           6 | Sneha Patel  | Yoga Mat          |    1299.00 |
|           6 | Sneha Patel  | Smart Watch       |    7999.00 |
|           6 | Sneha Patel  | Tablet            |   22000.00 |
|           6 | Sneha Patel  | Laptop            |   55000.00 |
|           6 | Sneha Patel  | Monitor           |   12999.00 |
|           6 | Sneha Patel  | Headphones        |    2499.00 |
|           7 | Arjun Kumar  | Bluetooth Speaker |    3999.00 |
|           7 | Arjun Kumar  | Smartphone        |   30000.00 |
|           7 | Arjun Kumar  | Desk Lamp         |    1299.00 |
|           7 | Arjun Kumar  | Printer           |    8999.00 |
|           7 | Arjun Kumar  | Gaming Headset    |    5999.00 |
|           7 | Arjun Kumar  | Camera            |   35000.00 |
|           7 | Arjun Kumar  | Backpack          |    2499.00 |
|           7 | Arjun Kumar  | Yoga Mat          |    1299.00 |
|           7 | Arjun Kumar  | Smart Watch       |    7999.00 |
|           7 | Arjun Kumar  | Tablet            |   22000.00 |
|           7 | Arjun Kumar  | Laptop            |   55000.00 |
|           7 | Arjun Kumar  | Monitor           |   12999.00 |
|           7 | Arjun Kumar  | Headphones        |    2499.00 |
|           8 | Neha Singh   | Bluetooth Speaker |    3999.00 |
|           8 | Neha Singh   | Smartphone        |   30000.00 |
|           8 | Neha Singh   | Desk Lamp         |    1299.00 |
|           8 | Neha Singh   | Printer           |    8999.00 |
|           8 | Neha Singh   | Gaming Headset    |    5999.00 |
|           8 | Neha Singh   | Camera            |   35000.00 |
|           8 | Neha Singh   | Backpack          |    2499.00 |
|           8 | Neha Singh   | Yoga Mat          |    1299.00 |
|           8 | Neha Singh   | Smart Watch       |    7999.00 |
|           8 | Neha Singh   | Tablet            |   22000.00 |
|           8 | Neha Singh   | Laptop            |   55000.00 |
|           8 | Neha Singh   | Monitor           |   12999.00 |
|           8 | Neha Singh   | Headphones        |    2499.00 |
|           9 | Raj Malhotra | Bluetooth Speaker |    3999.00 |
|           9 | Raj Malhotra | Smartphone        |   30000.00 |
|           9 | Raj Malhotra | Desk Lamp         |    1299.00 |
|           9 | Raj Malhotra | Printer           |    8999.00 |
|           9 | Raj Malhotra | Gaming Headset    |    5999.00 |
|           9 | Raj Malhotra | Camera            |   35000.00 |
|           9 | Raj Malhotra | Backpack          |    2499.00 |
|           9 | Raj Malhotra | Yoga Mat          |    1299.00 |
|           9 | Raj Malhotra | Smart Watch       |    7999.00 |
|           9 | Raj Malhotra | Tablet            |   22000.00 |
|           9 | Raj Malhotra | Laptop            |   55000.00 |
|           9 | Raj Malhotra | Monitor           |   12999.00 |
|           9 | Raj Malhotra | Headphones        |    2499.00 |
|          10 | Kavya Nair   | Bluetooth Speaker |    3999.00 |
|          10 | Kavya Nair   | Smartphone        |   30000.00 |
|          10 | Kavya Nair   | Desk Lamp         |    1299.00 |
|          10 | Kavya Nair   | Printer           |    8999.00 |
|          10 | Kavya Nair   | Gaming Headset    |    5999.00 |
|          10 | Kavya Nair   | Camera            |   35000.00 |
|          10 | Kavya Nair   | Backpack          |    2499.00 |
|          10 | Kavya Nair   | Yoga Mat          |    1299.00 |
|          10 | Kavya Nair   | Smart Watch       |    7999.00 |
|          10 | Kavya Nair   | Tablet            |   22000.00 |
|          10 | Kavya Nair   | Laptop            |   55000.00 |
|          10 | Kavya Nair   | Monitor           |   12999.00 |
|          10 | Kavya Nair   | Headphones        |    2499.00 |
|          11 | Aditi Kapoor | Bluetooth Speaker |    3999.00 |
|          11 | Aditi Kapoor | Smartphone        |   30000.00 |
|          11 | Aditi Kapoor | Desk Lamp         |    1299.00 |
|          11 | Aditi Kapoor | Printer           |    8999.00 |
|          11 | Aditi Kapoor | Gaming Headset    |    5999.00 |
|          11 | Aditi Kapoor | Camera            |   35000.00 |
|          11 | Aditi Kapoor | Backpack          |    2499.00 |
|          11 | Aditi Kapoor | Yoga Mat          |    1299.00 |
|          11 | Aditi Kapoor | Smart Watch       |    7999.00 |
|          11 | Aditi Kapoor | Tablet            |   22000.00 |
|          11 | Aditi Kapoor | Laptop            |   55000.00 |
|          11 | Aditi Kapoor | Monitor           |   12999.00 |
|          11 | Aditi Kapoor | Headphones        |    2499.00 |
|          12 | Vikram Joshi | Bluetooth Speaker |    3999.00 |
|          12 | Vikram Joshi | Smartphone        |   30000.00 |
|          12 | Vikram Joshi | Desk Lamp         |    1299.00 |
|          12 | Vikram Joshi | Printer           |    8999.00 |
|          12 | Vikram Joshi | Gaming Headset    |    5999.00 |
|          12 | Vikram Joshi | Camera            |   35000.00 |
|          12 | Vikram Joshi | Backpack          |    2499.00 |
|          12 | Vikram Joshi | Yoga Mat          |    1299.00 |
|          12 | Vikram Joshi | Smart Watch       |    7999.00 |
|          12 | Vikram Joshi | Tablet            |   22000.00 |
|          12 | Vikram Joshi | Laptop            |   55000.00 |
|          12 | Vikram Joshi | Monitor           |   12999.00 |
|          12 | Vikram Joshi | Headphones        |    2499.00 |
|          13 | Riya Das     | Bluetooth Speaker |    3999.00 |
|          13 | Riya Das     | Smartphone        |   30000.00 |
|          13 | Riya Das     | Desk Lamp         |    1299.00 |
|          13 | Riya Das     | Printer           |    8999.00 |
|          13 | Riya Das     | Gaming Headset    |    5999.00 |
|          13 | Riya Das     | Camera            |   35000.00 |
|          13 | Riya Das     | Backpack          |    2499.00 |
|          13 | Riya Das     | Yoga Mat          |    1299.00 |
|          13 | Riya Das     | Smart Watch       |    7999.00 |
|          13 | Riya Das     | Tablet            |   22000.00 |
|          13 | Riya Das     | Laptop            |   55000.00 |
|          13 | Riya Das     | Monitor           |   12999.00 |
|          13 | Riya Das     | Headphones        |    2499.00 |
|          14 | Nisha Gupta  | Bluetooth Speaker |    3999.00 |
|          14 | Nisha Gupta  | Smartphone        |   30000.00 |
|          14 | Nisha Gupta  | Desk Lamp         |    1299.00 |
|          14 | Nisha Gupta  | Printer           |    8999.00 |
|          14 | Nisha Gupta  | Gaming Headset    |    5999.00 |
|          14 | Nisha Gupta  | Camera            |   35000.00 |
|          14 | Nisha Gupta  | Backpack          |    2499.00 |
|          14 | Nisha Gupta  | Yoga Mat          |    1299.00 |
|          14 | Nisha Gupta  | Smart Watch       |    7999.00 |
|          14 | Nisha Gupta  | Tablet            |   22000.00 |
|          14 | Nisha Gupta  | Laptop            |   55000.00 |
|          14 | Nisha Gupta  | Monitor           |   12999.00 |
|          14 | Nisha Gupta  | Headphones        |    2499.00 |
|          15 | Aman Khan    | Bluetooth Speaker |    3999.00 |
|          15 | Aman Khan    | Smartphone        |   30000.00 |
|          15 | Aman Khan    | Desk Lamp         |    1299.00 |
|          15 | Aman Khan    | Printer           |    8999.00 |
|          15 | Aman Khan    | Gaming Headset    |    5999.00 |
|          15 | Aman Khan    | Camera            |   35000.00 |
|          15 | Aman Khan    | Backpack          |    2499.00 |
|          15 | Aman Khan    | Yoga Mat          |    1299.00 |
|          15 | Aman Khan    | Smart Watch       |    7999.00 |
|          15 | Aman Khan    | Tablet            |   22000.00 |
|          15 | Aman Khan    | Laptop            |   55000.00 |
|          15 | Aman Khan    | Monitor           |   12999.00 |
|          15 | Aman Khan    | Headphones        |    2499.00 |
+-------------+--------------+-------------------+------------+
195 rows in set (0.01 sec)

mysql> select customer_id,full_name,city from customers 
    -> where customer_id not in(
    -> from orders o
    -> where order_Status='Completed'
    -> );
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'from orders o
where order_Status='Completed'
)' at line 3
mysql> select customer_id,full_name,city from customers  where customer_id not in( from orders o where order_status='Completed' );
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'from orders o where order_status='Completed' )' at line 1
mysql> select customer_id,full_name,city from customers  where customer_id not in( from orders  where order_status='Completed' );
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'from orders  where order_status='Completed' )' at line 1
mysql> select customer_id,full_name,city from customers  where customer_id not in(select customer_id  from orders  where order_status='Completed' );
+-------------+--------------+--------+
| customer_id | full_name    | city   |
+-------------+--------------+--------+
|          12 | Vikram Joshi | Mumbai |
|          14 | Nisha Gupta  | Pune   |
+-------------+--------------+--------+
2 rows in set (0.00 sec)

mysql> select c.customer_id,c.full_name,sum(o.quantity*o.unit_price) as total_spent 
    -> from customers c inner join orders o
    -> where o.order_status='Completed'
    -> group by c.customer_id
    -> having ^C
mysql> select c.customer_id,c.full_name,(quantity*unit_price) as total_spent 
    -> from customer c innner join orders o
    -> where o.order_status='Completed'
    -> group by c.customer_id
    -> having (quantity*unit_price) >10000
    -> ^C
mysql> SELECT 
    ->     c.customer_id,
    ->     c.full_name,
    ->     SUM(o.quantity * o.unit_price) AS total_spent
    -> FROM customers c
    -> INNER JOIN orders o
    ->     ON c.customer_id = o.customer_id
    -> WHERE o.order_status = 'Completed'
    -> GROUP BY c.customer_id, c.full_name
    -> HAVING SUM(o.quantity * o.unit_price) > 10000
    -> ORDER BY total_spent DESC;
+-------------+--------------+-------------+
| customer_id | full_name    | total_spent |
+-------------+--------------+-------------+
|           3 | Rahul Verma  |    77495.00 |
|           8 | Neha Singh   |    35000.00 |
|          13 | Riya Das     |    31198.00 |
|           4 | Ananya Rao   |    22000.00 |
|           5 | Rohan Mehta  |    16996.00 |
|           2 | Priya Reddy  |    13997.00 |
|           9 | Raj Malhotra |    13997.00 |
|          10 | Kavya Nair   |    11997.00 |
+-------------+--------------+-------------+
8 rows in set (0.05 sec)

mysql> select c.city,(o.quantity*o.unit_price) as order_value 
    -> from customers c inner join orders o 
    -> on c.customer_id=o.customer_id 
    -> where order_status='Compmleted'
    -> group by c.city
    -> having avg(o.quantity*o.unit_price)>
    -> select avg(quantity*unit_price)
    -> from orders 
    -> where order_status='Completed'
    -> );
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'select avg(quantity*unit_price)
from orders 
where order_status='Completed'
)' at line 7
mysql> select c.city,(o.quantity*o.unit_price) as order_value  from customers c inner join orders o  on c.customer_id=o.customer_id  where order_status='Compmleted' group by c.city having avg(o.quantity*o.unit_price)>( select avg(quantity*unit_price) from orders  where order_status='Completed' );
ERROR 1055 (42000): Expression #2 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'ofs.o.quantity' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
mysql> SELECT 
    ->     c.city,
    ->     AVG(o.quantity * o.unit_price) AS average_order_value
    -> FROM customers c
    -> INNER JOIN orders o
    ->     ON c.customer_id = o.customer_id
    -> WHERE o.order_status = 'Completed'
    -> GROUP BY c.city
    -> HAVING AVG(o.quantity * o.unit_price) > (
    ->     SELECT AVG(quantity * unit_price)
    ->     FROM orders
    ->     WHERE order_status = 'Completed'
    -> );
+-----------+---------------------+
| city      | average_order_value |
+-----------+---------------------+
| Bengaluru |        16582.500000 |
| Chennai   |        15665.666667 |
+-----------+---------------------+
2 rows in set (0.02 sec)

mysql> select 
    -> c.customer_id,
    -> c.full_name,
    -> c.city,
    -> sum(o.quantity*o.unit_price) as total_spent
    -> from customers c 
    -> inner join orders o
    -> on c.customer_id=o.customer_id
    -> where o.order_status='Completed'
    -> group by c.customer_id,c.full_name,c.city
    -> having sum(o.quantity*o.unit_price) >(
    -> select avg(city_customer_spending)
    -> from (
    -> select 
    -> c2.customer_id,
    -> c2.city,
    -> sum(o2.quantity*o2.unit_price) as city_customer_spending 
    -> from customer c2 
    -> inner join orders o2
    -> on c2.customer_id=o2.customer_id
    -> where o2.order_status='Completed'
    -> and c2.city=c.city
    -> group by c2.customer_id,c2.city
    -> ) as city_totals
    -> ) order by total_spent desc;
ERROR 1146 (42S02): Table 'ofs.customer' doesn't exist
mysql> select  c.customer_id, c.full_name, c.city, sum(o.quantity*o.unit_price) as total_spent from customers c  inner join orders o on c.customer_id=o.customer_id where o.order_status='Completed' group by c.customer_id,c.full_name,c.city having sum(o.quantity*o.unit_price) >( select avg(city_customer_spending) from ( select  c2.customer_id, c2.city, sum(o2.quantity*o2.unit_price) as city_customer_spending  from customers c2  inner join orders o2 on c2.customer_id=o2.customer_id where o2.order_status='Completed' and c2.city=c.city group by c2.customer_id,c2.city ) as city_totals ) order by total_spent desc;
+-------------+--------------+-----------+-------------+
| customer_id | full_name    | city      | total_spent |
+-------------+--------------+-----------+-------------+
|           3 | Rahul Verma  | Bengaluru |    77495.00 |
|           8 | Neha Singh   | Chennai   |    35000.00 |
|          13 | Riya Das     | Hyderabad |    31198.00 |
|           5 | Rohan Mehta  | Pune      |    16996.00 |
|           9 | Raj Malhotra | Pune      |    13997.00 |
+-------------+--------------+-----------+-------------+
5 rows in set (0.02 sec)

mysql> 

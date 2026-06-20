-- pizza analytical project --

-- 1 Count the total number of orders of january 2015
select 
	count(order_id) 
from orders 
where order_date 
between 
	'2015-01-01' and '2015-01-31';

-- 2 List all orders where a large pizza was sold.
SELECT 
    pt.name,
    o.order_id,
    o.order_date,
    o.order_time
FROM orders AS o
JOIN order_details AS od 
    ON od.order_id = o.order_id
JOIN pizzas AS p 
    ON od.pizza_id = p.pizza_id
JOIN pizza_types AS pt 
    ON pt.pizza_type_id = p.pizza_type_id
WHERE p.size = 'L';


-- 3 Show order_id, pizza name, and quantity for all orders.
select 
	o.order_id, 
    pt.name , 
    od.quantity
from orders o 
join order_details od
	on o.order_id = od.order_id 
join pizzas as p 
	on od.pizza_id = p.pizza_id
join pizza_types pt 
	on p.pizza_type_id = pt.pizza_type_id;

-- 4 List orders that included “Cheese” in pizza ingredients.

select 
	o.order_id, 
    pt.name, 
    o.order_date, 
    o.order_time 
from orders o 
join order_details od
	on o.order_id = od.order_id
join pizzas p 
	on od.pizza_id = p.pizza_id
join pizza_types pt
	on p.pizza_type_id = pt.pizza_type_id
where pt.ingredients 
like '%cheese%' ;

-- 5 Calculate total revenue per order.

select 
	o.order_id , 
    ROUND(SUM(od.quantity * p.price), 2) AS revenue
from orders o 
join order_details od
	on o.order_id = od.order_id
join pizzas p 
	on od.pizza_id = p.pizza_id
group by o.order_id;

-- 6 Calculate total revenue per day, ordered by highest revenue first.

select 
	round(sum( quantity * price ) , 2) as revenue, 
    o.order_date 
from orders o
join order_details od
	on o.order_id = od.order_id
join pizzas p 
	on od.pizza_id = p.pizza_id
group by o.order_date
order by revenue desc;

-- 7 Find the pizza with the highest total quantity sold.
select p.pizza_id, 
	sum(quantity) as highest_quantity_sold
from pizzas p
join order_details od 
	on p.pizza_id = od.pizza_id
group by p.pizza_id
order by sum(quantity) desc
limit 1;

-- 8 Calculate total quantity sold and total revenue per pizza category.
select 
	category,
	sum(quantity) as total_quantity, 
	round(sum(price * quantity), 1 )
    as total_revenue 
from orders o 
join order_details od
	on o.order_id = od.order_id
join pizzas p 
	on od.pizza_id = p.pizza_id
join pizza_types pt
	on p.pizza_type_id = pt.pizza_type_id
group by category; 

-- 9 Categorize orders by time of day (Morning, Afternoon, Evening, Night) and count orders in each slot.
select 
	count(order_id), 
    case
		when order_time 
        >= '06:00:00' 
		and order_time <= '11:59:00' 
        then 'morning'
        
        when order_time 
        >= '12:00:00' 
        and order_time <= '16:59:00' 
        then 'afternoon'
        
        when order_time 
        >= '17:00:00' 
        and order_time <= '21:59:00'
        then 'evening'
        
        else 'night'
	end time_of_the_day
from orders
group by time_of_the_day;


-- 10 Calculate average pizza price by size, rounded to 2 decimals.
select 
	round(avg(price), 2), 
    size
    from pizzas
    group by size;
    
-- 11 Find orders where pizza price is NULL.
select
	od.order_id,
    price 
from order_details od
join pizzas p 
	on od.pizza_id = p.pizza_id
where price is null;

-- 12 Rank pizzas by total quantity sold from most to least.

SELECT 
    pizza_id,
    SUM(quantity) AS total_quantity,
    RANK() OVER (ORDER BY SUM(quantity) DESC) AS quantity_rank
FROM order_details
GROUP BY pizza_id;

-- 13 Running Total of Quantity by Order ID
select 
	order_id,
    sum(quantity) over(order by order_id rows between unbounded preceding and current row) as running_total
    from order_details;

-- 14 Rank Pizzas Within Each Category by Price
    
select
    p.pizza_id,
    pt.category,
    p.price,
    rank() over (
        partition by pt.category
        order by p.price desc
    ) as rank_in_category
from pizzas p
join pizza_types pt
    on p.pizza_type_id = pt.pizza_type_id;
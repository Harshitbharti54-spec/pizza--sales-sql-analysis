
**Pizza Sales Analytics — SQL Project**

A SQL-based analytical project exploring pizza sales data to uncover trends in orders, revenue, customer preferences, and time-of-day patterns.

---

##  Dataset

Four relational tables:

| Table | Columns |
|-------|---------|
| `orders` | order_id, order_date, order_time |
| `order_details` | order_id, pizza_id, quantity |
| `pizzas` | pizza_id, pizza_type_id, size, price |
| `pizza_types` | pizza_type_id, name, category, ingredients |

---

##  Project Goals

- Validate data quality (NULL prices, missing fields)
- Compute key business metrics (revenue, order counts, top sellers)
- Analyse time-of-day ordering patterns
- Use advanced SQL features like window functions and CASE statements

---

##  Queries Covered

| # | Query |
|---|-------|
| 1 | Count total orders in January 2015 |
| 2 | List all orders where a large pizza was sold |
| 3 | Show order ID, pizza name, and quantity for all orders |
| 4 | Find orders that included "Cheese" in ingredients |
| 5 | Calculate total revenue per order |
| 6 | Calculate daily revenue, ordered by highest first |
| 7 | Find the pizza with the highest total quantity sold |
| 8 | Total quantity and revenue per pizza category |
| 9 | Categorise orders by time of day (Morning / Afternoon / Evening / Night) |
| 10 | Average pizza price by size |
| 11 | Find orders where pizza price is NULL |
| 12 | Rank pizzas by total quantity sold (window function) |
| 13 | Running total of quantity by order ID (window function) |
| 14 | Rank pizzas within each category by price (window function) |

---

##  Key Insights

- **Evening (17:00–21:59)** is the busiest time slot with ~1,430 orders
- **Morning (06:00–11:59)** sees surprisingly high volume at ~1,240 orders
- Revenue calculations require NULL price checks to avoid skewed results
- Window functions like `RANK()` and running totals add powerful ranking capabilities

---

##  SQL Concepts Used

- `JOIN` (multi-table)
- `GROUP BY` + aggregate functions (`SUM`, `COUNT`, `AVG`, `ROUND`)
- `CASE` statements
- Window functions: `RANK() OVER`, `SUM() OVER`
- `LIKE` for pattern matching
- `NULL` checks with `IS NULL`

---

##  How to Run

1. Import the four CSV files into your SQL environment (MySQL / PostgreSQL)
2. Run `pizza_code.sql` query by query or all at once
3. Adjust date filters or size values as needed for exploration

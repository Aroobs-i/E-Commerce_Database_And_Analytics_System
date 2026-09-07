--Rank customers by number of completed orders

WITH completed_orders AS (
    SELECT
        o.customer_id,
        c.first_name,
        c.last_name,
        SUM(
            oi.quantity * p.price
        ) AS total_spent
    FROM orders o
    JOIN customers c
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.status = 'completed'
    GROUP BY
        o.customer_id,
        c.first_name,
        c.last_name
)

SELECT
    customer_id,
    first_name,
    last_name,
    total_spent,
    RANK() OVER (
        ORDER BY total_spent DESC
    ) AS customer_rank,
    ROUND(
        (total_spent / SUM(total_spent) OVER ()) * 100,
        2
    ) AS percentage_of_total_revenue
FROM completed_orders
ORDER BY total_spent DESC
LIMIT 10;

-- Rank customers by number of completed orders

WITH customer_orders AS (
    SELECT
        o.customer_id,
        COUNT(*) AS orders_count

    FROM orders o

    WHERE o.status = 'completed'

    GROUP BY o.customer_id
)

SELECT
    customer_id,
    orders_count,

    RANK() OVER (
        ORDER BY orders_count DESC
    ) AS customer_rank

FROM customer_orders

ORDER BY customer_rank;

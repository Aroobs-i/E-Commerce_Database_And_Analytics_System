-- CTE — customer spending

WITH customer_spending AS (
    SELECT
        o.customer_id,

        SUM(
            oi.quantity * p.price
        ) AS total_spent

    FROM orders o

    JOIN order_items oi
        ON o.order_id = oi.order_id

    JOIN products p
        ON oi.product_id = p.product_id

    WHERE o.status = 'completed'

    GROUP BY o.customer_id
)

SELECT *
FROM customer_spending
ORDER BY total_spent DESC;

-- Customers spending above average

WITH customer_spending AS (
    SELECT
        o.customer_id,

        SUM(
            oi.quantity * p.price
        ) AS total_spent

    FROM orders o

    JOIN order_items oi
        ON o.order_id = oi.order_id

    JOIN products p
        ON oi.product_id = p.product_id

    WHERE o.status = 'completed'

    GROUP BY o.customer_id
)

SELECT
    customer_id,
    total_spent

FROM customer_spending

WHERE total_spent > (
    SELECT AVG(total_spent)
    FROM customer_spending
)

ORDER BY total_spent DESC;

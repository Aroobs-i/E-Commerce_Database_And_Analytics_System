-- What percentage of the company's total revenue came from each month?

WITH monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', o.order_date) AS month,
        SUM(oi.quantity * p.price) AS revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN products p
        ON oi.product_id = p.product_id
    WHERE o.status = 'completed'
    GROUP BY DATE_TRUNC('month', o.order_date)
)
SELECT
    month,
    revenue,
    ROUND(
        (revenue / SUM(revenue) OVER ()) * 100,
        2
    ) AS percentage_of_total
FROM monthly_revenue
ORDER BY month;

-- Monthly revenue

SELECT
    DATE_TRUNC(
        'month',
        o.order_date
    ) AS month,

    SUM(
        oi.quantity * p.price
    ) AS revenue

FROM orders o

JOIN order_items oi
    ON o.order_id = oi.order_id

JOIN products p
    ON oi.product_id = p.product_id

WHERE o.status = 'completed'

GROUP BY
    DATE_TRUNC(
        'month',
        o.order_date
    )

ORDER BY month;

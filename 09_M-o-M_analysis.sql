-- Month-over-month revenue

WITH monthly_revenue AS (
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
),

revenue_with_previous AS (
    SELECT
        month,
        revenue,

        LAG(revenue) OVER (
            ORDER BY month
        ) AS previous_revenue

    FROM monthly_revenue
)

SELECT
    month,
    revenue,
    previous_revenue,

    ROUND(
        (
            (revenue - previous_revenue)
            / previous_revenue
        ) * 100,
        2
    ) AS growth_percentage

FROM revenue_with_previous

ORDER BY month;

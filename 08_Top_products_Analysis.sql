-- Top products by category

WITH product_sales AS (
    SELECT
        p.product_id,
        p.product_name,
        c.category_name,

        SUM(oi.quantity) AS units_sold

    FROM products p

    JOIN categories c
        ON p.category_id = c.category_id

    JOIN order_items oi
        ON p.product_id = oi.product_id

    JOIN orders o
        ON oi.order_id = o.order_id

    WHERE o.status = 'completed'

    GROUP BY
        p.product_id,
        p.product_name,
        c.category_name
),

ranked_products AS (
    SELECT
        product_name,
        category_name,
        units_sold,

        RANK() OVER (
            PARTITION BY category_name
            ORDER BY units_sold DESC
        ) AS category_rank

    FROM product_sales
)

SELECT *

FROM ranked_products

WHERE category_rank <= 2

ORDER BY
    category_name,
    category_rank;

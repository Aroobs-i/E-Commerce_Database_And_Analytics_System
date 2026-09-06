-- ============================================================
-- CATEGORIES DATA
-- ============================================================

INSERT INTO categories (category_name)
VALUES
    ('Laptops'),
    ('Phones'),
    ('Keyboards'),
    ('Monitors'),
    ('Headphones');
    
    -- ============================================================
-- PRODUCTS DATA
-- ============================================================

INSERT INTO products (
    product_name,
    category_id,
    price
)
VALUES
    ('ThinkPad X1', 1, 999.00),
    ('MacBook Air', 1, 1200.00),
    ('iPhone 17', 2, 1500.00),
    ('Mechanical Keyboard', 3, 80.00),
    ('Dell Monitor', 4, 200.00),
    ('AirPods Pro', 5, 95.50);
    
    -- ============================================================
-- CUSTOMERS DATA
-- ============================================================

INSERT INTO customers (
    first_name,
    last_name,
    email,
    phone
)
SELECT
    'Customer' || gs,
    'User' || gs,
    'customer' || gs || '@example.com',
    '0300' || LPAD(gs::TEXT, 7, '0')
FROM generate_series(1, 10000) AS gs;

-- ============================================================
-- GENERATE 100,000 ORDERS
-- ============================================================

WITH numbered_customers AS (
    SELECT
        customer_id,
        ROW_NUMBER() OVER (
            ORDER BY customer_id
        ) AS rn
    FROM customers
),

generated_orders AS (
    SELECT
        FLOOR(RANDOM() * 10000 + 1)::BIGINT AS customer_rn,

        NOW() -
            (RANDOM() * INTERVAL '2 years') AS order_date,

        (
            ARRAY[
                'completed',
                'completed',
                'completed',
                'shipped',
                'pending',
                'cancelled'
            ]
        )[FLOOR(RANDOM() * 6 + 1)::INTEGER] AS status

    FROM generate_series(1, 100000)
)

INSERT INTO orders (
    customer_id,
    order_date,
    status
)

SELECT
    c.customer_id,
    g.order_date,
    g.status

FROM generated_orders g

JOIN numbered_customers c
    ON c.rn = g.customer_rn;
    
    -- ============================================================
-- GENERATE ORDER ITEMS
-- ============================================================

INSERT INTO order_items (
    order_id,
    product_id,
    quantity
)

SELECT
    o.order_id,

    FLOOR(
        RANDOM() * 6 + 2
    )::BIGINT,

    FLOOR(
        RANDOM() * 5 + 1
    )::INTEGER

FROM orders o

CROSS JOIN LATERAL generate_series(
    1,
    FLOOR(RANDOM() * 5 + 1)::INTEGER
);

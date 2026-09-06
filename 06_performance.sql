-- ============================================================
-- PERFORMANCE TESTING
-- ============================================================


-- Customer lookup
EXPLAIN ANALYZE
SELECT *
FROM orders
WHERE customer_id = 1;


-- Customer + date filtering
EXPLAIN ANALYZE
SELECT *
FROM orders
WHERE customer_id = 1
  AND order_date >= NOW() - INTERVAL '6 months';


-- Order item lookup
EXPLAIN ANALYZE
SELECT *
FROM order_items
WHERE order_id = 1;


-- Product lookup
EXPLAIN ANALYZE
SELECT *
FROM order_items
WHERE product_id = 2;

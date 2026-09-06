-- Average product price by category

SELECT
    c.category_name,
    COUNT(*) AS product_count,
    AVG(p.price) AS average_price
FROM products p
JOIN categories c
    ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY average_price DESC;


-- SHOPFLOW INDEXES

-- Find orders belonging to a customer
CREATE INDEX idx_orders_customer_id
ON orders(customer_id);


-- Find a customer's orders within a date range
CREATE INDEX idx_orders_customer_date
ON orders(customer_id, order_date);


-- Find items belonging to a particular order
CREATE INDEX idx_order_items_order_id
ON order_items(order_id);


-- Find orders containing a particular product
CREATE INDEX idx_order_items_product_id
ON order_items(product_id);

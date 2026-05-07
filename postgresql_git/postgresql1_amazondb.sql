/*Top Categories by Rating*/
SELECT main_category, AVG(rating) AS avg_rating
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY main_category
ORDER BY avg_rating DESC;

/* Discount vs Rating */
SELECT 
    FLOOR(discount_percentage) AS discount_bucket,
    AVG(rating) AS avg_rating
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY discount_bucket
ORDER BY discount_bucket;

/*3. Top Rated Products*/
SELECT product_name, AVG(rating) AS avg_rating
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY product_name
ORDER BY avg_rating DESC
LIMIT 10;

/*Review Behavior*/
SELECT 
    CASE 
        WHEN review_length < 100 THEN 'Short'
        WHEN review_length < 300 THEN 'Medium'
        ELSE 'Long'
    END AS review_type,
    AVG(rating) AS avg_rating
FROM reviews
GROUP BY review_type;

/*Add rating category - just for my reference*/
SELECT
CASE 
    WHEN rating >= 4 THEN 'High'
    WHEN rating >= 3 THEN 'Medium'
    ELSE 'Low'
END AS rating_category
FROM reviews

/* For clear final view */
CREATE OR REPLACE VIEW final_dataset AS
SELECT 
    p.product_id,
    p.product_name,
    p.main_category,
    p.category,
    p.actual_price,
    p.discounted_price,
    p.discount_percentage,
    p.discounted_value,
    r.review_id,
    r.user_id,
    r.rating,
    r.rating_count,
    r.review_length,

	CASE 
        WHEN r.rating >= 4 THEN 'High'
        WHEN r.rating >= 3 THEN 'Medium'
        ELSE 'Low'
    END AS rating_category
	
FROM products p
JOIN reviews r 
ON p.product_id = r.product_id;


/*verifying the view */
SELECT * FROM final_dataset LIMIT 10;
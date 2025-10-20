-------------------------------------------------------------------------------------
-- 1. Find all records where Size is missing and the purchase_amount is greater than
-- 50.
-- Expected Columns: Customer ID, Size, purchase_amount, Item
-- Purchased
SELECT CUSTOMER_ID,
       SIZE,
       PURCHASE_AMOUNT,
       ITEM_PURCHASED
FROM PRACTICAL3.SHOP.SHOPPING_TRENDS
WHERE SIZE IS NULL AND PURCHASE_AMOUNT > 50;
-------------------------------------------------------------------------------------
-- 2. List the total number of purchases grouped by Season, treating NULL values a
-- s 'Unknown Season'.
-- Expected Columns: Season, Total Purchases
SELECT COALESCE(SEASON, 'UNKNOWN_SEASON') AS SEASON,
       COUNT (*) AS TOTAL_PURCHASES
FROM PRACTICAL3.SHOP.SHOPPING_TRENDS
GROUP BY SEASON;
-------------------------------------------------------------------------------------
-- 3. Count how many customers used each Payment Method, treating NULLs as
-- 'Not Provided'.
-- Expected Columns: Payment Method, Customer Count
SELECT COALESCE(PAYMENT_METHOD, 'NOT_PROVIDED') AS PAYMENT_METHOD,
       COUNT (DISTINCT CUSTOMER_ID) AS CUSTOMER_COUNT
FROM PRACTICAL3.SHOP.SHOPPING_TRENDS
GROUP BY PAYMENT_METHOD;
-------------------------------------------------------------------------------------
-- 4. Show customers where Promo Code Used is NULL and Review Rating is below
-- 3.0.
-- Expected Columns: Customer ID, Promo Code Used, Review Rating, Item Purchased
SELECT CUSTOMER_ID,
       PROMO_CODE_USED,
       REVIEW_RATING,
       ITEM_PURCHASED
FROM PRACTICAL3.SHOP.SHOPPING_TRENDS
WHERE PROMO_CODE_USED IS NULL AND REVIEW_RATING <3.0;
-------------------------------------------------------------------------------------
-- 5. Group customers by Shipping
-- Type, and return the average purchase_amount, treating missing values as 0.
-- Expected Columns: Shipping Type, Average purchase_amount
SELECT SHIPPING_TYPE,
    AVG(COALESCE(PURCHASE_AMOUNT, 0)) AS AVERAGE_PURCHASE_AMOUNT
FROM PRACTICAL3.SHOP.SHOPPING_TRENDS
GROUP BY SHIPPING_TYPE;
-------------------------------------------------------------------------------------
-- 6. Display the number of purchases per Location only for those with more than
-- 5 purchases and no NULL Payment Method.
-- Expected Columns: Location, Total Purchases
SELECT LOCATION,
       COUNT(*) AS TOTAL_PURCHASES
FROM PRACTICAL3.SHOP.SHOPPING_TRENDS
WHERE PAYMENT_METHOD IS NOT NULL 
GROUP BY LOCATION
HAVING TOTAL_PURCHASES > 5
-------------------------------------------------------------------------------------
-- 7. Create a column Spender Category that classifies customers using CASE:
-- 'High' if amount > 80, 'Medium' if BETWEEN 50 AND 80,
-- 'Low' otherwise. Replace NULLs in purchase_amount with 0.
-- Expected Columns: Customer ID, purchase_amount, Spender Category
SELECT CUSTOMER_ID,
       COALESCE(PURCHASE_AMOUNT, 0) AS PURCHASE_AMOUNT,
    CASE
        WHEN COALESCE(PURCHASE_AMOUNT, 0) > 80 THEN 'High'
        WHEN COALESCE(PURCHASE_AMOUNT, 0) BETWEEN 50 AND 80 THEN 'Medium'
        ELSE 'Low'
    END AS SPENDER_CATEGORY
FROM PRACTICAL3.SHOP.SHOPPING_TRENDS;
-------------------------------------------------------------------------------------
-- 8. Find customers who have no Previous
-- Purchases value but whose Color is not NULL.
-- Expected Columns: Customer ID, Color, Previous Purchases
SELECT CUSTOMER_ID,
       COLOR,
       PREVIOUS_PURCHASES
FROM PRACTICAL3.SHOP.SHOPPING_TRENDS
WHERE PREVIOUS_PURCHASES IS NULL AND COLOR IS NOT NULL;
-------------------------------------------------------------------------------------
-- 9. Group records by Frequency of
-- Purchases and show the total amount spent per group, treating NULL frequenc
-- ies as 'Unknown'.
-- Expected Columns: Frequency of Purchases, Total purchase_amount

SELECT COALESCE(FREQUENCY_OF_PURCHASES, 'Unknown') AS FREQUENCY_OF_PURCHASES,
        SUM(COALESCE(PURCHASE_AMOUNT, 0)) AS TOTAL_PURCHASE_AMOUNT
FROM PRACTICAL3.SHOP.SHOPPING_TRENDS
GROUP BY FREQUENCY_OF_PURCHASES;
-------------------------------------------------------------------------------------
-- 10. Display a list of all Category values with the number of times each was purcha
-- sed, excluding rows where Categoryis NULL.
-- Expected Columns: Category, Total Purchases
SELECT CATEGORY,
    COUNT(*) AS TOTAL_PURCHASES
FROM PRACTICAL3.SHOP.SHOPPING_TRENDS
WHERE CATEGORY IS NOT NULL
GROUP BY CATEGORY;
-------------------------------------------------------------------------------------
-- 11. Return the top
-- 5 Locations with the highest total purchase_amount, replacing NULLs in amount
-- with 0.
-- Expected Columns: Location, Total purchase_amount
SELECT LOCATION,
       SUM(COALESCE(PURCHASE_AMOUNT, 0)) AS TOTAL_PURCHASE_AMOUNT
FROM PRACTICAL3.SHOP.SHOPPING_TRENDS
GROUP BY LOCATION
ORDER BY TOTAL_PURCHASE_AMOUNT DESC
LIMIT 5;
-------------------------------------------------------------------------------------
-- 12. Group customers by Gender and Size, and count how many entries have a NUL
-- L Color.
-- Expected Columns: Gender, Size, Null Color Count
SELECT GENDER,
       SIZE,
    COUNT(*) AS NULL_COLOR_COUNT
FROM PRACTICAL3.SHOP.SHOPPING_TRENDS
WHERE COLOR IS NULL
GROUP BY GENDER,
         SIZE;
-------------------------------------------------------------------------------------
-- 13. Identify all Item Purchased where more than 3 purchases had NULL Shipping
-- Type.
-- Expected Columns: Item Purchased, NULL Shipping Type Count
SELECT ITEM_PURCHASED,
       COUNT(*) AS NULL_SHIPPING_TYPE_COUNT
FROM PRACTICAL3.SHOP.SHOPPING_TRENDS
WHERE SHIPPING_TYPE IS NULL
GROUP BY ITEM_PURCHASED
HAVING NULL_SHIPPING_TYPE_COUNT > 3;
-------------------------------------------------------------------------------------
-- 14. Show a count of how many customers per Payment Method have NULL Review
-- Rating.
-- Expected Columns: Payment Method, Missing Review Rating Count
SELECT PAYMENT_METHOD, 
       COUNT(*) AS MISSING_REVIEW_RATING_COUNT
FROM PRACTICAL3.SHOP.SHOPPING_TRENDS
WHERE REVIEW_RATING IS NULL
GROUP BY PAYMENT_METHOD;
-------------------------------------------------------------------------------------
-- 15. Group by Category and return the average Review Rating, replacing NULLs with
-- 0, and filter only where average is greater than 3.5.
-- Expected Columns: Category, Average Review Rating
SELECT CATEGORY,
       AVG(COALESCE(REVIEW_RATING, 0)) AS AVERAGE_REVIEW_RATING
FROM PRACTICAL3.SHOP.SHOPPING_TRENDS
GROUP BY CATEGORY
HAVING AVERAGE_REVIEW_RATING > 3.5;
-------------------------------------------------------------------------------------
-- 16. List all Colors that are missing (NULL) in at least
-- 2 rows and the average Age of customers for those rows.
-- Expected Columns: Color, Average Age
SELECT COLOR,
       AVG (AGE) AS AVERAGE_AGE
FROM PRACTICAL3.SHOP.SHOPPING_TRENDS
WHERE COLOR IS NULL
GROUP BY COLOR
HAVING AVERAGE_AGE >= 2;
-------------------------------------------------------------------------------------
-- 17. Use CASE to create a column Delivery Speed: 'Fast' if Shipping Type is 'Express' or
-- 'Next Day Air', 'Slow' if 'Standard',
-- 'Other' for all else including NULL. Then count how many customers fall into
-- each category.
-- Expected Columns: Delivery Speed, Customer Count
SELECT 
    CASE 
        WHEN SHIPPING_TYPE IN ('Express', 'Next Day Air') THEN 'Fast'
        WHEN SHIPPING_TYPE = 'Standard' THEN 'Slow'
        ELSE 'Other'
    END AS DELIVERY_SPEED,
    COUNT(DISTINCT CUSTOMER_ID) AS CUSTOMER_COUNT
FROM PRACTICAL3.SHOP.SHOPPING_TRENDS
GROUP BY DELIVERY_SPEED;
-------------------------------------------------------------------------------------
-- 18. Find customers whose purchase_amount is NULL and whose Promo Code Used is
-- 'Yes'.
-- Expected Columns: Customer ID, purchase_amount, Promo Code Used
SELECT CUSTOMER_ID,
       PURCHASE_AMOUNT,
       PROMO_CODE_USED
FROM PRACTICAL3.SHOP.SHOPPING_TRENDS
WHERE PURCHASE_AMOUNT IS NULL AND PROMO_CODE_USED = 'YES';
-------------------------------------------------------------------------------------
-- 19. Group by Location and show the maximum Previous
-- Purchases, replacing NULLs with 0, only where the average rating is above 4.0.
-- Expected Columns: Location, Max Previous Purchases, Average
-- Review Rating
SELECT LOCATION,
       MAX(COALESCE(PREVIOUS_PURCHASES, 0)) AS MAX_PREVIOUS_PURCHASE,
       AVG(REVIEW_RATING) AS AVERAGE_REVIEW_RATING
FROM PRACTICAL3.SHOP.SHOPPING_TRENDS
GROUP BY LOCATION
HAVING AVERAGE_REVIEW_RATING > 4.0;
-------------------------------------------------------------------------------------
-- 20. Show customers who have a NULL Shipping
-- Type but made a purchase in the range of 30 to 70 USD.
-- Expected Columns: Customer ID, Shipping
-- Type, purchase_amount, Item Purchased
SELECT CUSTOMER_ID,
       SHIPPING_TYPE,
       PURCHASE_AMOUNT,
       ITEM_PURCHASED
FROM PRACTICAL3.SHOP.SHOPPING_TRENDS
WHERE SHIPPING_TYPE IS NULL 
AND PURCHASE_AMOUNT BETWEEN 30 AND 70;
-------------------------------------------------------------------------------------

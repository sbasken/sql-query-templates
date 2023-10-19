-- Database Schema

-- page_visits
-- name	type
-- page_name	TEXT
-- timestamp	TEXT
-- user_id	INTEGER
-- utm_campaign	TEXT
-- utm_source	TEXT
-- Rows: 5692

-- first-touch query

WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
        pv.utm_campaign
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp;

-- one for the number of distinct campaigns,
-- one for the number of distinct sources,
-- one to find how they are related.

SELECT COUNT(DISTINCT utm_campaign) AS campaign_num
FROM page_visits;

SELECT COUNT(DISTINCT utm_source) AS source_num
FROM page_visits;

SELECT DISTINCT utm_campaign, utm_source
FROM page_visits;

-- pages on the website?
SELECT DISTINCT page_name
FROM page_visits;


-- How many first touches is each campaign responsible
WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
    pv.utm_campaign,
    COUNT(pv.utm_campaign)
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
GROUP BY utm_campaign
ORDER BY 5 DESC;

-- How many last touches is each campaign responsible for

WITH last_touch AS (
    SELECT user_id,
        MIN(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
    pv.utm_campaign,
    COUNT(pv.utm_campaign)
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY utm_campaign
ORDER BY 5 DESC;

-- How many visitors make a purchase?
SELECT page_name, COUNT(DISTINCT user_id)
FROM page_visits
WHERE page_name = '4 - purchase';


-- How many last touches on the purchase page is each campaign responsible for?
WITH last_touch AS (
    SELECT user_id,
        MIN(timestamp) as last_touch_at
    FROM page_visits
    WHERE page_name = '4 - purchase'
    GROUP BY user_id)
SELECT lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
    pv.utm_campaign,
    COUNT(pv.utm_campaign)
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY utm_campaign
ORDER BY 5 DESC;


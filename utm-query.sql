-- step 1: Check the table schema by viewing 10 rows

 SELECT *
 FROM page_visits

-- step 2A: Find June’s rows relating to utm source, 'buzzfeed'

 SELECT *
 FROM page_visits
 WHERE (user_id = 10069) AND (utm_source = 'buzzfeed');

-- step 2B: Or check what are June's first- and last-touch

 SELECT *
 FROM page_visits
 WHERE user_id = 10069;

-- step 3: Find first- and last-touch for each user:

  SELECT user_id,
    MIN(timestamp) AS 'first_touch_at',
     MAX(timestamp) AS 'last_touch_at'
  FROM page_visits
  GROUP BY user_id;

-- step 4: Join two tables and show user_id, last_touch, and utm_source

  WITH last_touch AS (
    SELECT user_id,
       MAX(timestamp) AS 'last_touch_at'
    FROM page_visits
    GROUP BY user_id)
  SELECT lt.user_id,
     lt.last_touch_at,
     pv.utm_source
  FROM last_touch AS 'lt'
  JOIN page_visits AS 'pv'
     ON lt.user_id = pv.user_id
     AND lt.last_touch_at = pv.timestamp;



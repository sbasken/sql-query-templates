WITH months AS
(SELECT
  '2017-01-01' as first_day,
  '2017-01-31' as last_day
UNION
SELECT
  '2017-02-01' as first_day,
  '2017-02-28' as last_day
UNION
SELECT
  '2017-03-01' as first_day,
  '2017-03-31' as last_day
),
-- add data from subscriptions table as cross_join to months table.
cross_join as (
  SELECT *
  FROM subscriptions
  CROSS JOIN months
)

SELECT *
FROM cross_join
LIMIT 100;

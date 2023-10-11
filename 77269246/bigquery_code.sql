WITH
  day_table AS (
  SELECT
    day
  FROM
    UNNEST( GENERATE_DATE_ARRAY(DATE('2022-01-01'), CURRENT_DATE(), INTERVAL 1 DAY) ) AS day ),
  orders AS (
  SELECT
    PARSE_DATE("%x", FORMAT_DATE("%x", order_created_date_time)) AS order_date,
    sub_total_excluding_tax AS order_total
  FROM
    `order_table`)
SELECT
  day_table.day order_date,
  sum(IFNULL(order_total,0)) order_totals
FROM
  orders
RIGHT OUTER JOIN
  day_table
ON
  order_date = day_table.day
GROUP BY 1
ORDER BY
  1 DESC;

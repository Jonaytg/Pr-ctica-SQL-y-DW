WITH calls_dates AS (

SELECT
      calls_ivr_id
      , calls_phone_number
      , MIN(calls_start_date) AS calls_start_date
      , MAX(calls_end_date) AS calls_end_date
FROM `keepcoding.ivr_detail`
GROUP BY calls_ivr_id, calls_phone_number
ORDER BY calls_start_date ASC
)

SELECT
    calls_ivr_id
  , calls_phone_number
  , calls_start_date
  ,IF( DATETIME_DIFF(calls_start_date , LAG(calls_end_date) OVER (PARTITION BY calls_phone_number ORDER BY calls_start_date), HOUR)<24, 1, 0) AS repeated_phone_24H
  ,IF( DATETIME_DIFF(calls_end_date , LEAD(calls_start_date) OVER (PARTITION BY calls_phone_number ORDER BY calls_start_date), HOUR)>-24,1,0) AS cause_recall_phone_24H
FROM `calls_dates`
ORDER BY calls_phone_number, calls_start_date

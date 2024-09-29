SELECT
   calls_ivr_id
  ,MAX(  CASE WHEN calls_vdn_label LIKE "ATC%" THEN "FRONT"
          WHEN calls_vdn_label LIKE "TECH%" THEN "TECH"
          WHEN calls_vdn_label = "ABSORPTION" THEN "ABSORPTION"
          ELSE "RESTO"
        END ) AS calls_vdn_aggregation
FROM `keepcoding.ivr_detail`
GROUP BY calls_ivr_id

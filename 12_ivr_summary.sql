CREATE OR REPLACE TABLE `keepcoding.ivr_summary` AS
  SELECT
      calls_ivr_id AS ivr_id
    , MAX(calls_phone_number) AS phone_number
    , MAX(calls_ivr_result) AS ivr_result
    , MAX(calls_vdn_label) AS vdn_aggregation
    , MIN(calls_start_date) AS start_date
    , MAX(calls_end_date) AS end_date
    , MAX(calls_total_duration) AS total_duration
    , MAX(calls_customer_segment) AS customer_segment
    , MAX(calls_ivr_language) AS ivr_language
    , MAX(calls_steps_module) AS steps_module
    , MAX(calls_module_aggregation) AS module_aggregation
    , MAX(IF(step_document_type = 'UNKNOWN' OR step_document_type = 'DESCONOCIDO' , NULL , step_document_type)) AS document_type
    , MAX(IF(step_document_identification = 'UNKNOWN' OR step_document_identification= 'DESCONOCIDO', NULL , step_document_identification  )) AS document_identification
    , MAX(IF(step_customer_phone = 'UNKNOWN' OR step_customer_phone = 'DESCONOCIDO' , NULL , step_customer_phone)) AS customer_phone
    , MAX(IF(step_billing_account_id = 'UNKNOWN' OR step_billing_account_id = 'DESCONOCIDO' , NULL , step_billing_account_id)) AS billing_account_id
    , MAX(IF(module_name = "AVERIA_MASIVA" , 1 , 0)) AS masiva_lg
    , MAX(IF(step_name = "CUSTOMERINFOBYPHONE.TX" AND step_result = "OK" , 1 , 0)) AS info_by_phone_lg
    , MAX(IF(step_name = "CUSTOMERINFOBYDNI.TX" AND step_result = "OK" , 1 , 0)) AS info_by_dni_lg

    ,IF(DATETIME_DIFF(MIN(calls_start_date) , LAG(MAX(calls_end_date)) OVER (PARTITION BY MAX(calls_phone_number) ORDER BY  MIN(calls_start_date)), HOUR)<24, 1, 0) AS repeated_phone_24H
    ,IF(DATETIME_DIFF(MAX(calls_end_date) , LEAD(MIN(calls_start_date)) OVER (PARTITION BY MAX(calls_phone_number) ORDER BY MIN(calls_start_date)), HOUR)>-24,1,0) AS cause_recall_phone_24H

FROM `keepcoding.ivr_detail`
GROUP BY calls_ivr_id
ORDER BY phone_number, start_date



SELECT
    cast(vendorid as int) as vendor_id,
    cast(tpep_pickup_datetime as timestamp) as pickup_datetime,
    cast(tpep_dropoff_datetime as timestamp) as dropoff_datetime,
    cast(store_and_fwd_flag as string) as store_and_fwd_flag,
    cast(ratecodeid as int) as rate_code_id,
    cast(pulocationid as int) as pickup_location_id,
    cast(dolocationid as int) as dropoff_location_id,
    cast(passenger_count as int) as passenger_count,
    cast(trip_distance as numeric) as trip_distance,
    cast(fare_amount as numeric) as fare_amount,
    cast(extra as numeric) as extra,
    cast(mta_tax as numeric) as mta_tax,
    cast(tip_amount as numeric) as tip_amount,
    cast(tolls_amount as numeric) as tolls_amount,
    0 as ehail_fee,
    cast(improvement_surcharge as numeric) as improvement_surcharge,
    cast(total_amount as numeric) as total_amount,
    cast(payment_type as int) as payment_type,
    1 as trip_type,
    cast(congestion_surcharge as numeric) as congestion_surcharge
FROM {{ source('raw_data', 'yellow_tripdata_partitioned') }}
WHERE vendorid is not null
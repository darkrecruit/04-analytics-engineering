## Setup

* Grant your gcloud user permission to create access tokens (for impersonation)
* Then run ```gcloud auth application-default login```


## Build and run load script

```
docker build -t dezoomcamp:hw4 .
```

```
docker run -it --rm \
    -v ~/.config/gcloud:/root/.config/gcloud \
    -e GOOGLE_APPLICATION_CREDENTIALS=/root/.config/gcloud/application_default_credentials.json \
    dezoomcamp:hw4
    load_taxi_data.py
```

or replace `load_taxi_data.py` with `load_fhv_data.py`

## Queries for homework

```sql
-- Question 3
SELECT COUNT(1)  FROM `project-d79af39f-8a71-4f5d-812.nytaxi_prod.fct_monthly_zone_revenue`;


-- Question 4
with r as (
  SELECT 
    pickup_zone,
    SUM(revenue_monthly_total_amount) as rt
  FROM `project-d79af39f-8a71-4f5d-812.nytaxi_prod.fct_monthly_zone_revenue`
  WHERE service_type = 'Green' AND DATETIME_DIFF(revenue_month, DATETIME(2020, 1, 1, 0, 0, 0), YEAR) = 0
  GROUP BY pickup_zone
),
ranked as (
  SELECT
    pickup_zone,
    ROW_NUMBER() OVER (ORDER BY r.rt DESC) AS rank,
    r.rt
  FROM r
)
select pickup_zone, rank, ranked.rt
FROM ranked
WHERE ranked.rank in (1, 2);

-- Question 5
SELECT SUM(total_monthly_trips)
FROM `project-d79af39f-8a71-4f5d-812.nytaxi_prod.fct_monthly_zone_revenue`
WHERE service_type = 'Green' AND DATETIME_DIFF(revenue_month, DATETIME(2019, 10, 1, 0, 0, 0), MONTH) = 0;


-- Question 6
-- Query to create table in bigquery
LOAD DATA OVERWRITE `nytaxi.fhv_tripdata_partitioned`
PARTITION BY DATE(dropoff_datetime)
FROM FILES (
  format = 'CSV',
  uris = ['gs://hw4-project-d79af39f-8a71-4f5d-812/fhv_tripdata*.csv.gz']
);

-- query to count # of records
SELECT COUNT(1) FROM `nytaxi.stg_fhv_tripdata`;
```
USE urban_stress_intelligence;
CREATE TABLE staging_environmental_anomaly (
    city VARCHAR(50),
    date VARCHAR(20),

    temperature VARCHAR(50),
    temperature_min VARCHAR(50),
    temperature_max VARCHAR(50),
    precipitation VARCHAR(50),
    wind_speed VARCHAR(50),
    pressure VARCHAR(50),

    pm25 VARCHAR(50),
    sensor_count VARCHAR(20),
    coverage_status VARCHAR(50),
    data_quality_score VARCHAR(50),

    fire_detection_count VARCHAR(20),
    total_frp VARCHAR(50),
    nearest_fire_km VARCHAR(50),

    temperature_z VARCHAR(50),
    pm25_z VARCHAR(50),
    wind_z VARCHAR(50),

    heat_anomaly VARCHAR(10),
    pm25_anomaly VARCHAR(10),
    wind_anomaly VARCHAR(10),
    fire_anomaly VARCHAR(10),

    compound_score VARCHAR(20),
    anomaly_level VARCHAR(50),
    persistence_days VARCHAR(20),
    drivers VARCHAR(100)
);
SELECT count(*) as total_rows
from staging_environmental_anomaly;

SELECT *
FROM staging_environmental_anomaly
LIMIT 5;

INSERT INTO fact_environmental_anomaly (
    city,
    date,
    temperature,
    temperature_min,
    temperature_max,
    precipitation,
    wind_speed,
    pressure,
    pm25,
    sensor_count,
    coverage_status,
    data_quality_score,
    fire_detection_count,
    total_frp,
    nearest_fire_km,
    temperature_z,
    pm25_z,
    wind_z,
    heat_anomaly,
    pm25_anomaly,
    wind_anomaly,
    fire_anomaly,
    compound_score,
    anomaly_level,
    persistence_days,
    drivers
)
SELECT
    city,
    STR_TO_DATE(NULLIF(date, '\\N'), '%Y-%m-%d'),

    NULLIF(NULLIF(temperature, '\\N'), ''),
    NULLIF(NULLIF(temperature_min, '\\N'), ''),
    NULLIF(NULLIF(temperature_max, '\\N'), ''),
    NULLIF(NULLIF(precipitation, '\\N'), ''),
    NULLIF(NULLIF(wind_speed, '\\N'), ''),
    NULLIF(NULLIF(pressure, '\\N'), ''),

    NULLIF(NULLIF(pm25, '\\N'), ''),
    NULLIF(NULLIF(sensor_count, '\\N'), ''),
    NULLIF(NULLIF(coverage_status, '\\N'), ''),
    NULLIF(NULLIF(data_quality_score, '\\N'), ''),

    NULLIF(NULLIF(fire_detection_count, '\\N'), ''),
    NULLIF(NULLIF(total_frp, '\\N'), ''),
    NULLIF(NULLIF(nearest_fire_km, '\\N'), ''),

    NULLIF(NULLIF(temperature_z, '\\N'), ''),
    NULLIF(NULLIF(pm25_z, '\\N'), ''),
    NULLIF(NULLIF(wind_z, '\\N'), ''),

    CASE
        WHEN heat_anomaly IN ('1', 'True', 'TRUE') THEN 1
        ELSE 0
    END,

    CASE
        WHEN pm25_anomaly IN ('1', 'True', 'TRUE') THEN 1
        ELSE 0
    END,

    CASE
        WHEN wind_anomaly IN ('1', 'True', 'TRUE') THEN 1
        ELSE 0
    END,

    CASE
        WHEN fire_anomaly IN ('1', 'True', 'TRUE') THEN 1
        ELSE 0
    END,

    NULLIF(NULLIF(compound_score, '\\N'), ''),
    NULLIF(NULLIF(anomaly_level, '\\N'), ''),
    NULLIF(NULLIF(persistence_days, '\\N'), ''),
    NULLIF(NULLIF(drivers, '\\N'), '')
FROM staging_environmental_anomaly;
USE urban_stress_intelligence;

SELECT COUNT(*) AS final_rows
FROM fact_environmental_anomaly;

SELECT COUNT(*) AS staging_rows
FROM staging_environmental_anomaly;
SELECT *
FROM staging_environmental_anomaly
LIMIT 5;
USE urban_stress_intelligence;

TRUNCATE TABLE fact_environmental_anomaly;
TRUNCATE TABLE staging_environmental_anomaly;

SELECT COUNT(*) AS final_rows
FROM fact_environmental_anomaly;

SELECT COUNT(*) AS staging_rows
FROM staging_environmental_anomaly;
SELECT
    city,
    COUNT(*) AS rows_loaded,
    MIN(date) AS first_date,
    MAX(date) AS last_date
FROM staging_environmental_anomaly
GROUP BY city;
USE urban_stress_intelligence;

TRUNCATE TABLE fact_environmental_anomaly;

INSERT INTO fact_environmental_anomaly (
    city,
    date,
    temperature,
    temperature_min,
    temperature_max,
    precipitation,
    wind_speed,
    pressure,
    pm25,
    sensor_count,
    coverage_status,
    data_quality_score,
    fire_detection_count,
    total_frp,
    nearest_fire_km,
    temperature_z,
    pm25_z,
    wind_z,
    heat_anomaly,
    pm25_anomaly,
    wind_anomaly,
    fire_anomaly,
    compound_score,
    anomaly_level,
    persistence_days,
    drivers
)
SELECT
    city,
    STR_TO_DATE(NULLIF(date, '\\N'), '%Y-%m-%d'),

    NULLIF(NULLIF(temperature, '\\N'), ''),
    NULLIF(NULLIF(temperature_min, '\\N'), ''),
    NULLIF(NULLIF(temperature_max, '\\N'), ''),
    NULLIF(NULLIF(precipitation, '\\N'), ''),
    NULLIF(NULLIF(wind_speed, '\\N'), ''),
    NULLIF(NULLIF(pressure, '\\N'), ''),

    NULLIF(NULLIF(pm25, '\\N'), ''),
    NULLIF(NULLIF(sensor_count, '\\N'), ''),
    NULLIF(NULLIF(coverage_status, '\\N'), ''),
    NULLIF(NULLIF(data_quality_score, '\\N'), ''),

    NULLIF(NULLIF(fire_detection_count, '\\N'), ''),
    NULLIF(NULLIF(total_frp, '\\N'), ''),
    NULLIF(NULLIF(nearest_fire_km, '\\N'), ''),

    NULLIF(NULLIF(temperature_z, '\\N'), ''),
    NULLIF(NULLIF(pm25_z, '\\N'), ''),
    NULLIF(NULLIF(wind_z, '\\N'), ''),

    CASE
        WHEN heat_anomaly = '1' THEN 1
        ELSE 0
    END,

    CASE
        WHEN pm25_anomaly = '1' THEN 1
        ELSE 0
    END,

    CASE
        WHEN wind_anomaly = '1' THEN 1
        ELSE 0
    END,

    CASE
        WHEN fire_anomaly = '1' THEN 1
        ELSE 0
    END,

    NULLIF(NULLIF(compound_score, '\\N'), ''),
    NULLIF(NULLIF(anomaly_level, '\\N'), ''),
    NULLIF(NULLIF(persistence_days, '\\N'), ''),
    NULLIF(NULLIF(drivers, '\\N'), '')
FROM staging_environmental_anomaly;
SELECT COUNT(*) AS total_rows
FROM fact_environmental_anomaly;
SELECT
    city,
    COUNT(*) AS rows_loaded
FROM fact_environmental_anomaly
GROUP BY city
ORDER BY city;
SELECT
    COUNT(*) AS rows_total,
    SUM(pm25 IS NULL) AS pm25_missing,
    SUM(nearest_fire_km IS NULL) AS fire_distance_missing
FROM fact_environmental_anomaly;
SELECT
    city,
    COUNT(*) AS total_rows,
    SUM(pm25 IS NULL) AS pm25_missing,
    COUNT(pm25) AS pm25_present
FROM fact_environmental_anomaly
GROUP BY city;
SELECT
    city,
    COUNT(*) AS rows_in_staging,
    SUM(
        pm25 IS NULL
        OR TRIM(pm25) = ''
        OR TRIM(pm25) = '\\N'
    ) AS pm25_missing_in_staging,
    COUNT(
        NULLIF(
            NULLIF(TRIM(pm25), '\\N'),
            ''
        )
    ) AS pm25_nonempty
FROM staging_environmental_anomaly
GROUP BY city;
USE urban_stress_intelligence;

TRUNCATE TABLE fact_environmental_anomaly;
TRUNCATE TABLE staging_environmental_anomaly;
select count(*) as total_rows
from staging_environmental_anomaly;
USE urban_stress_intelligence;

INSERT INTO fact_environmental_anomaly (
    city,
    date,
    temperature,
    temperature_min,
    temperature_max,
    precipitation,
    wind_speed,
    pressure,
    pm25,
    sensor_count,
    coverage_status,
    data_quality_score,
    fire_detection_count,
    total_frp,
    nearest_fire_km,
    temperature_z,
    pm25_z,
    wind_z,
    heat_anomaly,
    pm25_anomaly,
    wind_anomaly,
    fire_anomaly,
    compound_score,
    anomaly_level,
    persistence_days,
    drivers
)
SELECT
    city,
    STR_TO_DATE(NULLIF(TRIM(date), '\\N'), '%Y-%m-%d'),

    CAST(NULLIF(NULLIF(TRIM(temperature), '\\N'), '') AS DOUBLE),
    CAST(NULLIF(NULLIF(TRIM(temperature_min), '\\N'), '') AS DOUBLE),
    CAST(NULLIF(NULLIF(TRIM(temperature_max), '\\N'), '') AS DOUBLE),
    CAST(NULLIF(NULLIF(TRIM(precipitation), '\\N'), '') AS DOUBLE),
    CAST(NULLIF(NULLIF(TRIM(wind_speed), '\\N'), '') AS DOUBLE),
    CAST(NULLIF(NULLIF(TRIM(pressure), '\\N'), '') AS DOUBLE),

    CAST(NULLIF(NULLIF(TRIM(pm25), '\\N'), '') AS DOUBLE),
    CAST(NULLIF(NULLIF(TRIM(sensor_count), '\\N'), '') AS UNSIGNED),
    NULLIF(NULLIF(TRIM(coverage_status), '\\N'), ''),
    CAST(NULLIF(NULLIF(TRIM(data_quality_score), '\\N'), '') AS DOUBLE),

    CAST(NULLIF(NULLIF(TRIM(fire_detection_count), '\\N'), '') AS UNSIGNED),
    CAST(NULLIF(NULLIF(TRIM(total_frp), '\\N'), '') AS DOUBLE),
    CAST(NULLIF(NULLIF(TRIM(nearest_fire_km), '\\N'), '') AS DOUBLE),

    CAST(NULLIF(NULLIF(TRIM(temperature_z), '\\N'), '') AS DOUBLE),
    CAST(NULLIF(NULLIF(TRIM(pm25_z), '\\N'), '') AS DOUBLE),
    CAST(NULLIF(NULLIF(TRIM(wind_z), '\\N'), '') AS DOUBLE),

    CAST(NULLIF(NULLIF(TRIM(heat_anomaly), '\\N'), '') AS UNSIGNED),
    CAST(NULLIF(NULLIF(TRIM(pm25_anomaly), '\\N'), '') AS UNSIGNED),
    CAST(NULLIF(NULLIF(TRIM(wind_anomaly), '\\N'), '') AS UNSIGNED),
    CAST(NULLIF(NULLIF(TRIM(fire_anomaly), '\\N'), '') AS UNSIGNED),

    CAST(NULLIF(NULLIF(TRIM(compound_score), '\\N'), '') AS UNSIGNED),
    NULLIF(NULLIF(TRIM(anomaly_level), '\\N'), ''),
    CAST(NULLIF(NULLIF(TRIM(persistence_days), '\\N'), '') AS UNSIGNED),
    NULLIF(NULLIF(TRIM(drivers), '\\N'), '')
FROM staging_environmental_anomaly;
TRUNCATE TABLE fact_environmental_anomaly;

INSERT INTO fact_environmental_anomaly (
    city,
    date,
    temperature,
    temperature_min,
    temperature_max,
    precipitation,
    wind_speed,
    pressure,
    pm25,
    sensor_count,
    coverage_status,
    data_quality_score,
    fire_detection_count,
    total_frp,
    nearest_fire_km,
    temperature_z,
    pm25_z,
    wind_z,
    heat_anomaly,
    pm25_anomaly,
    wind_anomaly,
    fire_anomaly,
    compound_score,
    anomaly_level,
    persistence_days,
    drivers
)
SELECT
    city,

    STR_TO_DATE(
        NULLIF(TRIM(date), '\\N'),
        '%Y-%m-%d'
    ),

    CAST(NULLIF(NULLIF(TRIM(temperature), '\\N'), '') AS DECIMAL(20,6)),
    CAST(NULLIF(NULLIF(TRIM(temperature_min), '\\N'), '') AS DECIMAL(20,6)),
    CAST(NULLIF(NULLIF(TRIM(temperature_max), '\\N'), '') AS DECIMAL(20,6)),
    CAST(NULLIF(NULLIF(TRIM(precipitation), '\\N'), '') AS DECIMAL(20,6)),
    CAST(NULLIF(NULLIF(TRIM(wind_speed), '\\N'), '') AS DECIMAL(20,6)),
    CAST(NULLIF(NULLIF(TRIM(pressure), '\\N'), '') AS DECIMAL(20,6)),

    CAST(NULLIF(NULLIF(TRIM(pm25), '\\N'), '') AS DECIMAL(20,6)),

    FLOOR(
        CAST(
            NULLIF(NULLIF(TRIM(sensor_count), '\\N'), '')
            AS DECIMAL(20,6)
        )
    ),

    NULLIF(NULLIF(TRIM(coverage_status), '\\N'), ''),

    CAST(
        NULLIF(NULLIF(TRIM(data_quality_score), '\\N'), '')
        AS DECIMAL(20,6)
    ),

    FLOOR(
        CAST(
            NULLIF(NULLIF(TRIM(fire_detection_count), '\\N'), '')
            AS DECIMAL(20,6)
        )
    ),

    CAST(
        NULLIF(NULLIF(TRIM(total_frp), '\\N'), '')
        AS DECIMAL(20,6)
    ),

    CAST(
        NULLIF(NULLIF(TRIM(nearest_fire_km), '\\N'), '')
        AS DECIMAL(20,6)
    ),

    CAST(
        NULLIF(NULLIF(TRIM(temperature_z), '\\N'), '')
        AS DECIMAL(20,6)
    ),

    CAST(
        NULLIF(NULLIF(TRIM(pm25_z), '\\N'), '')
        AS DECIMAL(20,6)
    ),

    CAST(
        NULLIF(NULLIF(TRIM(wind_z), '\\N'), '')
        AS DECIMAL(20,6)
    ),

    FLOOR(
        CAST(
            NULLIF(NULLIF(TRIM(heat_anomaly), '\\N'), '')
            AS DECIMAL(20,6)
        )
    ),

    FLOOR(
        CAST(
            NULLIF(NULLIF(TRIM(pm25_anomaly), '\\N'), '')
            AS DECIMAL(20,6)
        )
    ),

    FLOOR(
        CAST(
            NULLIF(NULLIF(TRIM(wind_anomaly), '\\N'), '')
            AS DECIMAL(20,6)
        )
    ),

    FLOOR(
        CAST(
            NULLIF(NULLIF(TRIM(fire_anomaly), '\\N'), '')
            AS DECIMAL(20,6)
        )
    ),

    FLOOR(
        CAST(
            NULLIF(NULLIF(TRIM(compound_score), '\\N'), '')
            AS DECIMAL(20,6)
        )
    ),

    NULLIF(NULLIF(TRIM(anomaly_level), '\\N'), ''),

    FLOOR(
        CAST(
            NULLIF(NULLIF(TRIM(persistence_days), '\\N'), '')
            AS DECIMAL(20,6)
        )
    ),

    NULLIF(NULLIF(TRIM(drivers), '\\N'), '')

FROM staging_environmental_anomaly;

SELECT COUNT(*) AS total_rows
FROM fact_environmental_anomaly;
SELECT
    city,
    COUNT(*) AS rows_loaded
FROM fact_environmental_anomaly
GROUP BY city
ORDER BY city;
SELECT
    COUNT(*) AS total_rows,
    SUM(pm25 IS NULL) AS pm25_missing,
    SUM(nearest_fire_km IS NULL) AS fire_distance_missing,
    SUM(precipitation IS NULL) AS precipitation_missing
FROM fact_environmental_anomaly;

#lesson 1
SELECT
    city,
    ROUND(AVG(pm25), 2) AS average_pm25
FROM fact_environmental_anomaly
GROUP BY city
ORDER BY average_pm25 DESC;
#lesson 2
SELECT
    city,
    COUNT(*) AS anomaly_days
FROM fact_environmental_anomaly
WHERE compound_score > 0
GROUP BY city
ORDER BY anomaly_days DESC;
#lesson 3
SELECT
    city,
    COUNT(*) AS anomaly_days
FROM fact_environmental_anomaly
WHERE compound_score > 0
GROUP BY city
HAVING COUNT(*) > 42
ORDER BY anomaly_days DESC;
#lesson 4
SELECT
    city,
    date,
    compound_score,
    anomaly_level,
    persistence_days,
    drivers
FROM fact_environmental_anomaly
WHERE compound_score > 0
ORDER BY
    compound_score DESC,
    persistence_days DESC
LIMIT 10;
#lesson 5
SELECT
    city,
    date,
    compound_score,
    CASE
        WHEN compound_score = 0 THEN 'Normal'
        WHEN compound_score = 1 THEN 'Low'
        WHEN compound_score = 2 THEN 'Moderate'
        ELSE 'High'
    END AS severity_category
FROM fact_environmental_anomaly
ORDER BY compound_score DESC
LIMIT 20;
#2
SELECT
    CASE
        WHEN compound_score = 0 THEN 'Normal'
        WHEN compound_score = 1 THEN 'Low'
        WHEN compound_score = 2 THEN 'Moderate'
        ELSE 'High'
    END AS severity_category,
    COUNT(*) AS days
FROM fact_environmental_anomaly
GROUP BY severity_category
ORDER BY days DESC;
USE urban_stress_intelligence;

CREATE TABLE IF NOT EXISTS dim_city (
    city VARCHAR(50) PRIMARY KEY,
    country VARCHAR(50),
    region VARCHAR(50),
    latitude DOUBLE,
    longitude DOUBLE
);
INSERT INTO dim_city
    (city, country, region, latitude, longitude)
VALUES
    ('Delhi', 'India', 'Asia', 28.6139, 77.2090),
    ('Tokyo', 'Japan', 'Asia', 35.6762, 139.6503),
    ('New York', 'USA', 'North America', 40.7128, -74.0060);
    SELECT *
FROM dim_city;
#first join
SELECT
    f.city,
    d.country,
    d.region,
    f.date,
    f.pm25,
    f.temperature,
    f.compound_score
FROM fact_environmental_anomaly AS f
JOIN dim_city AS d
    ON f.city = d.city
LIMIT 10;
#highest average pm2.5
SELECT
    d.country,
    ROUND(AVG(f.pm25), 2) AS average_pm25
FROM fact_environmental_anomaly AS f
JOIN dim_city AS d
    ON f.city = d.city
GROUP BY d.country
ORDER BY average_pm25 DESC;

SELECT
    d.country,
    ROUND(AVG(f.pm25), 2) AS average_pm25
FROM fact_environmental_anomaly AS f
JOIN dim_city AS d
    ON f.city = d.city
GROUP BY d.country
HAVING AVG(f.pm25) > 10
ORDER BY average_pm25 DESC;
#ctes
WITH city_pm25 AS (
    SELECT
        city,
        ROUND(AVG(pm25), 2) AS average_pm25
    FROM fact_environmental_anomaly
    GROUP BY city
)

SELECT *
FROM city_pm25
ORDER BY average_pm25 DESC;

WITH city_pm25 AS (
    SELECT
        city,
        ROUND(AVG(pm25), 2) AS average_pm25
    FROM fact_environmental_anomaly
    GROUP BY city
)

SELECT
    city,
    average_pm25,
    RANK() OVER (
        ORDER BY average_pm25 DESC
    ) AS pm25_rank
FROM city_pm25
ORDER BY pm25_rank;
#window functions
SELECT
    city,
    date,
    pm25,

    ROUND(
        AVG(pm25) OVER (
            PARTITION BY city
        ),
        2
    ) AS city_average_pm25,

    ROUND(
        pm25 - AVG(pm25) OVER (
            PARTITION BY city
        ),
        2
    ) AS difference_from_city_average

FROM fact_environmental_anomaly

WHERE pm25 IS NOT NULL

ORDER BY city, date
LIMIT 20;

WITH ranked_anomalies AS (
    SELECT
        city,
        date,
        compound_score,
        persistence_days,
        drivers,

        ROW_NUMBER() OVER (
            PARTITION BY city
            ORDER BY
                compound_score DESC,
                persistence_days DESC
        ) AS rn

    FROM fact_environmental_anomaly

    WHERE compound_score > 0
)

SELECT
    city,
    date,
    compound_score,
    persistence_days,
    drivers
FROM ranked_anomalies
WHERE rn <= 3
ORDER BY city, rn;
#lesson 9 day rolling average
SELECT
    city,
    date,
    pm25,

    ROUND(
        AVG(pm25) OVER (
            PARTITION BY city
            ORDER BY date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS pm25_7day_avg

FROM fact_environmental_anomaly

WHERE pm25 IS NOT NULL

ORDER BY city, date;
#lesson 10 advance time series
SELECT
    city,
    date,
    pm25,

    LAG(pm25) OVER (
        PARTITION BY city
        ORDER BY date
    ) AS previous_day_pm25,

    ROUND(
        pm25 - LAG(pm25) OVER (
            PARTITION BY city
            ORDER BY date
        ),
        2
    ) AS daily_change

FROM fact_environmental_anomaly

WHERE pm25 IS NOT NULL

ORDER BY city, date;
#lesson 11
WITH daily_changes AS (
    SELECT
        city,
        date,
        pm25,

        LAG(pm25) OVER (
            PARTITION BY city
            ORDER BY date
        ) AS previous_day_pm25

    FROM fact_environmental_anomaly

    WHERE pm25 IS NOT NULL
)

SELECT
    city,
    date,
    ROUND(pm25, 2) AS pm25,
    ROUND(previous_day_pm25, 2) AS previous_day_pm25,
    ROUND(pm25 - previous_day_pm25, 2) AS increase
FROM daily_changes
WHERE previous_day_pm25 IS NOT NULL
ORDER BY increase DESC
LIMIT 10;
#lesson 12 data quality analysis
SELECT
    city,
    COUNT(*) AS total_days,

    SUM(pm25 IS NULL) AS missing_pm25,

    ROUND(
        100 * SUM(pm25 IS NOT NULL) / COUNT(*),
        2
    ) AS pm25_coverage_pct,

    SUM(precipitation IS NULL) AS missing_precipitation,

    ROUND(
        AVG(data_quality_score),
        2
    ) AS avg_quality_score

FROM fact_environmental_anomaly

GROUP BY city
ORDER BY pm25_coverage_pct DESC;
#lesson 13
SELECT
    city,
    date,
    compound_score,
    anomaly_level,
    persistence_days,
    drivers
FROM fact_environmental_anomaly
WHERE compound_score >= 2
ORDER BY
    compound_score DESC,
    persistence_days DESC,
    date;
#lesson 14
CREATE OR REPLACE VIEW vw_city_environment_summary AS

SELECT
    city,

    COUNT(*) AS total_days,

    ROUND(AVG(temperature), 2) AS avg_temperature,

    ROUND(AVG(pm25), 2) AS avg_pm25,

    ROUND(AVG(wind_speed), 2) AS avg_wind_speed,

    SUM(compound_score > 0) AS anomaly_days,

    SUM(compound_score >= 2) AS multi_factor_days,

    MAX(compound_score) AS max_compound_score,

    MAX(persistence_days) AS max_persistence_days,

    ROUND(
        100 * SUM(pm25 IS NOT NULL) / COUNT(*),
        2
    ) AS pm25_coverage_pct

FROM fact_environmental_anomaly

GROUP BY city;

SELECT *
FROM vw_city_environment_summary;
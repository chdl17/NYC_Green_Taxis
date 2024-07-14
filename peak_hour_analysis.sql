SELECT 
    pickup_hour, 
    pickup_count, 
    dropoff_count,
FROM 
    (SELECT 
         EXTRACT(HOUR FROM pickup_datetime) AS pickup_hour,
         COUNT(*) AS pickup_count
     FROM 
         `bigquery-public-data.new_york_taxi_trips.tlc_green_trips_*`
     GROUP BY 
         pickup_hour) AS pickups
JOIN 
    (SELECT 
         EXTRACT(HOUR FROM dropoff_datetime) AS dropoff_hour,
         COUNT(*) AS dropoff_count
     FROM 
         `bigquery-public-data.new_york_taxi_trips.tlc_green_trips_*`
     GROUP BY 
         dropoff_hour) AS dropoffs
ON 
    pickups.pickup_hour = dropoffs.dropoff_hour
ORDER BY 
    pickup_count DESC, dropoff_count DESC;

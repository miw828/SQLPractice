--Lists Flights that departed on January 1, 2013

FROM flights 
WHERE year = 2013
    AND month = 1
    AND day = 1;

-- Finds distinct airlines in the database

SELECT DISTINCT carrier 
FROM flights; 

--displays names of all airports located in New York 
SELECT name, faa, lat, lon
FROM airports
WHERE faa IN('JFK', 'LGA', 'EWR');

--counts the total number of flights
SELECT COUNT(*) AS total_flights
FROM flights; 

--finds flights with an delay greater than 60 min
SELECT *
FROM flights 
WHERE arr_delay > 60

--lists flights that were cancelled
SELECT *
FROM flights 
WHERE dep_time IS NULL;

--retreives the 10 earliest departing flights
SELECT *
FROM flights
ORDER BY sched_dep_time 
LIMIT 10; 

--average air time of flights departing from JFK
SELECT AVG(air_time) AS avg_air_time_minutes
FROM flights 
WHERE origin = 'JFK';

--flights with a departure delar but no arrival delar
SELECT *
FROM flights 
WHERE dep_delay > 0 
	AND arr_delay <= 0; 

--All flights headed to LAX 
SELECT *
FROM flights 
WHERE dest = 'LAX';

--Airline with the most flights 
SELECT a.name AS airline_name, 
	f.carrier,
	COUNT(*) AS total_flights
FROM flights f
JOIN airlines a ON f.carrier = a.carrier
GROUP BY f.carrier, a.name ORDER BY total_flights DESC
LIMIT 1; 

--Calculate the average departure delay
SELECT origin,
	AVG(dep_delay) AS avg_dep_delay_minutes
FROM flights 
GROUP BY origin 
ORDER BY avg_dep_delay_minutes DESC; 

--Lists 5 destination by number of flights 
SELECT dest, 
	COUNT(*) AS total_flights
FROM flights
GROUP BY dest 
ORDER BY total_flights DESC 
LIMIT 5; 

-- Retrieves the names of airlines that had flights to Chicago 
SELECT DISTINCT a.name AS airline_name
FROM flights f 
JOIN airlines a ON f.carrier = a.carrier 
WHERE f.dest = 'ORD'; 

-- total number of flights 
SELECT carrier,
       COUNT(*) AS flights_delayed_over_30min
FROM flights
WHERE dep_delay > 30
GROUP BY carrier
ORDER BY flights_delayed_over_30min DESC;
 
 
-- average flight speed for flights with valid data 
SELECT AVG((distance / air_time) * 60) AS avg_speed_mph
FROM flights
WHERE air_time > 0
  AND distance IS NOT NULL
  AND air_time IS NOT NULL;
 
 
-- Max arrival delar for each destination 
SELECT dest,
       MAX(arr_delay) AS max_arr_delay_minutes
FROM flights
GROUP BY dest
ORDER BY max_arr_delay_minutes DESC;
 
 
-- lists of flights that were delayed at departure but arried early or on time 
SELECT *
FROM flights
WHERE dep_delay > 0
  AND arr_delay <= 0;
 
 
-- Retrieves name of the airlines with longest average flight time 
SELECT a.name AS airline_name,
       AVG(f.air_time) AS avg_air_time_minutes
FROM flights f
JOIN airlines a ON f.carrier = a.carrier
WHERE f.air_time IS NOT NULL
GROUP BY f.carrier, a.name
ORDER BY avg_air_time_minutes DESC
LIMIT 1;
 
 
--top 10 flights that have the longest distance traveled 
SELECT *
FROM flights
ORDER BY distance DESC
LIMIT 10;
 

 
--  total number of flights and the average departure delay.
SELECT month,
       COUNT(*)            AS total_flights,
       AVG(dep_delay)      AS avg_dep_delay_minutes
FROM flights
GROUP BY month
ORDER BY month;
 
 
-- top 3 days with the most flights departing from JFK.
SELECT year,
       month,
       day,
       COUNT(*) AS total_flights
FROM flights
WHERE origin = 'JFK'
GROUP BY year, month, day
ORDER BY total_flights DESC
LIMIT 3;
 
 
-- the average delay for each hour of departure.
SELECT (dep_time / 100) AS departure_hour,
       AVG(dep_delay)   AS avg_dep_delay_minutes,
       COUNT(*)         AS total_flights
FROM flights
WHERE dep_time IS NOT NULL
GROUP BY departure_hour
ORDER BY departure_hour;
 
 
--  the top 5 most popular routes (origin and destination pair).
SELECT origin,
       dest,
       COUNT(*) AS total_flights
FROM flights
GROUP BY origin, dest
ORDER BY total_flights DESC
LIMIT 5;
 
 
-- the airline with the highest average departure delay.
SELECT a.name   AS airline_name,
       f.carrier,
       AVG(f.dep_delay) AS avg_dep_delay_minutes
FROM flights f
JOIN airlines a ON f.carrier = a.carrier
WHERE f.dep_delay IS NOT NULL
GROUP BY f.carrier, a.name
ORDER BY avg_dep_delay_minutes DESC
LIMIT 1;
 
 
-- the top 5 pairs of airports (origin and destination) with the longest average flight distance.
SELECT origin,
       dest,
       AVG(distance) AS avg_distance_miles
FROM flights
GROUP BY origin, dest
ORDER BY avg_distance_miles DESC
LIMIT 5;
 
 
-- all flights that were delayed at both departure and arrival but had an air time less than 3 hours (180 minutes).
SELECT *
FROM flights
WHERE dep_delay > 0
  AND arr_delay > 0
  AND air_time < 180
  AND air_time IS NOT NULL;


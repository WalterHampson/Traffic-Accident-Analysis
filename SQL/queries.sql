-- Data Analysis
-- 

SELECT * FROM phx_accidents;

SELECT Accident_Date, Accident_Time, City, Severity FROM phx_accidents;


-- Questions
-- 1. What are the most accident-prone intersections/areas in the Metro Phoenix area?
SELECT 
    street,
    start_lat,
    start_lng,
    COUNT(*) AS accident_count
FROM 
    phx_accidents
WHERE 
    city = 'Phoenix'
GROUP BY 
    street, start_lat, start_lng
ORDER BY 
    accident_count DESC
LIMIT 10;


-- 2. Which city has the highest volume of accidents?
SELECT city, COUNT(*) AS accident_count
FROM phx_accidents
GROUP BY city
ORDER BY accident_count DESC;


-- 3. Which city has the worst accidents in terms of severity (Average Severity by City- impact of traffic)?
SELECT city, AVG(severity) AS average_severity
FROM phx_accidents
GROUP BY city
ORDER BY average_severity DESC;

-- Accidents Severity Distribution
SELECT severity, COUNT(*) AS count
FROM phx_accidents
GROUP BY severity
ORDER BY severity;


-- 4. Does weather conduction impact the volume of accidents? (Monsoon season June-Sept?)
-- Accidents Count by Weather Condition
SELECT weather_condition, COUNT(*) AS accident_count
FROM phx_accidents
GROUP BY weather_condition
ORDER BY accident_count DESC;

--Monsoon season
-- June to Sept Accidents
SELECT * FROM phx_accidents WHERE Accident_Date BETWEEN '2022-06-01' AND '2022-09-30';

-- This helps determine whether specific weather conditions during the monsoon season correlate 
-- with a higher volume of accidents compared to other times of the year
SELECT 
    weather_condition,
    SUM(CASE WHEN EXTRACT(MONTH FROM accident_date) BETWEEN 6 AND 9 THEN 1 ELSE 0 END) AS monsoon_accidents,
    SUM(CASE WHEN EXTRACT(MONTH FROM accident_date) < 6 OR EXTRACT(MONTH FROM accident_date) > 9 THEN 1 ELSE 0 END) AS non_monsoon_accidents
FROM 
    phx_accidents
WHERE 
    city = 'Phoenix'
GROUP BY 
    weather_condition
ORDER BY 
    monsoon_accidents DESC;




-- Additional Findings
-- All Phoenix Metro Counts
SELECT COUNT(DISTINCT id) AS Unique_Accident_Count
FROM phx_accidents;

-- Phoenix Accident Counts Only
SELECT COUNT(id) AS Total_Accident_Count
FROM phx_accidents
WHERE city = 'Phoenix';

-- Phoenix Rush Hour Only
SELECT 
    CASE 
        WHEN (EXTRACT(HOUR FROM accident_time) BETWEEN 6 AND 8) THEN 'Morning Rush Hour'
        WHEN (EXTRACT(HOUR FROM accident_time) BETWEEN 15 AND 18) THEN 'Evening Rush Hour'
        ELSE 'Non-Rush Hour'
    END AS Time_Period,
    COUNT(id) AS Accident_Count
FROM 
    phx_accidents
WHERE 
    city = 'Phoenix'
GROUP BY 
    CASE 
        WHEN (EXTRACT(HOUR FROM accident_time) BETWEEN 6 AND 8) THEN 'Morning Rush Hour'
        WHEN (EXTRACT(HOUR FROM accident_time) BETWEEN 15 AND 18) THEN 'Evening Rush Hour'
        ELSE 'Non-Rush Hour'
    END
ORDER BY 
    CASE 
        WHEN (EXTRACT(HOUR FROM accident_time) BETWEEN 6 AND 8) THEN 'Morning Rush Hour'
        WHEN (EXTRACT(HOUR FROM accident_time) BETWEEN 15 AND 18) THEN 'Evening Rush Hour'
        ELSE 'Non-Rush Hour'
    END;

-- All cities Rush Hour
SELECT 
    CASE 
        WHEN (EXTRACT(HOUR FROM accident_time) BETWEEN 6 AND 8) THEN 'Morning Rush Hour'
        WHEN (EXTRACT(HOUR FROM accident_time) BETWEEN 15 AND 18) THEN 'Evening Rush Hour'
        ELSE 'Non-Rush Hour'
    END AS Time_Period,
    COUNT(id) AS Accident_Count
FROM 
    phx_accidents
GROUP BY 
    CASE 
        WHEN (EXTRACT(HOUR FROM accident_time) BETWEEN 6 AND 8) THEN 'Morning Rush Hour'
        WHEN (EXTRACT(HOUR FROM accident_time) BETWEEN 15 AND 18) THEN 'Evening Rush Hour'
        ELSE 'Non-Rush Hour'
    END
ORDER BY 
    CASE 
        WHEN (EXTRACT(HOUR FROM accident_time) BETWEEN 6 AND 8) THEN 'Morning Rush Hour'
        WHEN (EXTRACT(HOUR FROM accident_time) BETWEEN 15 AND 18) THEN 'Evening Rush Hour'
        ELSE 'Non-Rush Hour'
    END;
	
-- Filter by Severity
SELECT * FROM phx_accidents WHERE severity >= 3;
SELECT * FROM phx_accidents WHERE severity <= 2;


-- Average Temperature by Severity
SELECT severity, AVG("Temperature(F)") AS avg_temp
FROM phx_accidents
GROUP BY severity
ORDER BY severity;

-- Accidents by Hour of the Day
SELECT EXTRACT(HOUR FROM Accident_time) AS hour, COUNT(*) AS accident_count
FROM phx_accidents
GROUP BY hour
ORDER BY hour;

-- Accidents by Day of the Week
SELECT TO_CHAR(accident_date, 'Day') AS day_of_week, COUNT(*) AS accident_count
FROM phx_accidents
GROUP BY day_of_week
ORDER BY accident_count DESC;

-- Count of Severe Accidents (Severity >= 4) by City
SELECT city, COUNT(*) AS severe_accident_count
FROM phx_accidents
WHERE severity >= 4
GROUP BY city
ORDER BY severe_accident_count DESC;


-- # of Accidents Per Month
SELECT DATE_TRUNC('month', accident_date) AS month, COUNT(*) AS accident_count
FROM phx_accidents
GROUP BY month
ORDER BY month;


-- Monthly Accident Count for Severe Accidents (Severity >= 3)
SELECT DATE_TRUNC('month', accident_date) AS month, COUNT(*) AS accident_count
FROM phx_accidents
WHERE severity >= 3
GROUP BY month
ORDER BY month;
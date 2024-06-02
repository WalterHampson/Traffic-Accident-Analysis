-- Data Analysis
-- 

SELECT * FROM phx_accidents;

SELECT Accident_Date, Accident_Time, City, Severity FROM phx_accidents;

-- Filter by Severity
SELECT * FROM phx_accidents WHERE severity >= 3;
SELECT * FROM phx_accidents WHERE severity <= 2;

--Filter by Date Range
SELECT * FROM phx_accidents WHERE Accident_Date BETWEEN '2022-01-01' AND '2022-12-31';

--Count Accidents by City
SELECT city, COUNT(*) AS accident_count
FROM phx_accidents
GROUP BY city
ORDER BY accident_count DESC;

-- Average Severity by City
SELECT city, AVG(severity) AS average_severity
FROM phx_accidents
GROUP BY city
ORDER BY average_severity DESC;

-- Accidents Count by Weather Condition
SELECT weather_condition, COUNT(*) AS accident_count
FROM phx_accidents
GROUP BY weather_condition
ORDER BY accident_count DESC;

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

--Average Temperature During Rainy Conditions
SELECT AVG("Temperature(F)") AS avg_temp_during_rain
FROM phx_accidents
WHERE weather_condition = 'rain';

-- Accidents Trend Over Months
SELECT DATE_TRUNC('month', accident_date) AS month, COUNT(*) AS accident_count
FROM phx_accidents
GROUP BY month
ORDER BY month;

-- Accidents Severity Distribution
SELECT severity, COUNT(*) AS count
FROM phx_accidents
GROUP BY severity
ORDER BY severity;


-- Monthly Accident Count for Severe Accidents (Severity >= 3)
SELECT DATE_TRUNC('month', accident_date) AS month, COUNT(*) AS accident_count
FROM phx_accidents
WHERE severity >= 3
GROUP BY month
ORDER BY month;
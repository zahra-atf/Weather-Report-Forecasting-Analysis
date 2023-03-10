DESC weather;

/*When inserting data from a Pandas DataFrame into MySQL, it has sometimes unexpected data type conversions.
When inserting data from a Pandas DataFrame into MySQL, it creates VARCHAR columns for datetime type in Pandas.
Therefore, we need to change the type of column Date from varchar(50) to date.*/

ALTER TABLE weather MODIFY Date DATE;

DESC weather;

SELECT
	*
FROM
	weather;


-- 1. Give the count of the minimum number of days for the time when temperature reduced.

WITH temp_diffs AS (
SELECT
	Avg_temperature - LAG(Avg_temperature) OVER (
	ORDER BY Date) AS temp_diff
FROM
	weather
)
SELECT
	COUNT(*) AS min_num_days
FROM
	temp_diffs
WHERE
	temp_diff < 0;   -- output: 1822
	

-- 2. Find the temperature as Cold/hot by using the case and avg of values of the given data set

WITH weather_type_cte AS (
SELECT
	TRUNCATE(AVG(Avg_temperature),1) AS average
FROM
	weather  
)
SELECT
	weather.Date,
	weather.Avg_temperature,
	average,
	CASE
		WHEN weather.Avg_temperature > weather_type_cte.average THEN 'hot'
		WHEN weather.Avg_temperature < weather_type_cte.average THEN 'cold'
		ELSE
		'neutral'
	END AS temperature_type
FROM
	weather
CROSS JOIN weather_type_cte;


-- 3. Can you check for all 4 consecutive days when the temperature was below 30 Fahrenheit

SELECT
	w1.Date,
	w2.Date,
	w3.Date,
	w4.Date
FROM
	weather AS w1,
	weather AS w2,
	weather AS w3,
	weather AS w4
WHERE
	w1.Avg_temperature < 30
	AND w2.Avg_temperature < 30
	AND w3.Avg_temperature < 30
	AND w4.Avg_temperature < 30
	AND w2.Date = DATE_ADD(w1.Date, INTERVAL 1 DAY)
	AND w3.Date = DATE_ADD(w2.Date, INTERVAL 1 DAY)
	AND w4.Date = DATE_ADD(w3.Date, INTERVAL 1 DAY);


-- 4. Can you find the maximum number of days for which temperature dropped

WITH previous AS (
    SELECT
        Date,
        Avg_temperature AS temp1,
        LAG(Avg_temperature) OVER (
        ORDER BY Date) AS temp2
    FROM
        weather
),
init_cte AS (
    SELECT @temp := 0
),
max_cte AS (
    SELECT
        IF(temp2 > temp1, @temp := @temp + 1, @temp := 0) AS sum_temp
    FROM
        previous
    CROSS JOIN
        init_cte
)
SELECT
    MAX(sum_temp) AS result
FROM
    max_cte;   -- output: 7

   
/* 5. Can you find the average humidity average from the dataset
(NOTE: should contain the following clauses: group by, order by, date)*/


WITH avg_temp_cte AS (
SELECT
	Date,
	AVG(Avg_humidity) as avg
FROM
	weather
GROUP BY
	Date
ORDER BY
	avg DESC
)
SELECT
	AVG(avg) as avg_humidity
FROM
	avg_temp_cte;


/* 6. Use the GROUP BY clause on the Date column and make a query to fetch details for 
average windspeed (which is now windspeed done in task 3)*/

SELECT
	YEAR(Date),
	MAX(Avg_windspeed),
	MIN(Avg_windspeed),
	AVG(Avg_windspeed)
FROM
	weather
GROUP BY
	YEAR(Date);


/* 7. Please add the data in the dataset for 2034 and 2035 as well as forecast predictions for these years
(NOTE: data consistency and uniformity should be maintained) */



-- 8. If the maximum gust speed increases from 55mph, fetch the details for the next 4 days

-- Method1:
WITH next_days AS(
SELECT
	Date,
	DATE_ADD(Date, INTERVAL 1 DAY) AS day1,
	DATE_ADD(Date, INTERVAL 2 DAY) AS day2,
	DATE_ADD(Date, INTERVAL 3 DAY) AS day3,
	DATE_ADD(Date, INTERVAL 4 DAY) AS day4
FROM
	weather
WHERE
	Max_gustspeed > 55
)
SELECT
	*
FROM
	weather
JOIN next_days 
ON
	weather.Date IN (next_days.Date, next_days.day1, next_days.day2, next_days.day3, next_days.day4);

-- Method2: 
WITH Max_gust_cte AS (
SELECT 
	w1.Date AS date1,
	w2.Date AS date2,
	w3.Date AS date3,
	w4.Date AS date4,
	w5.Date AS date5,
	w1.Max_gustspeed
FROM
	weather AS w1,
	weather AS w2,
	weather AS w3,
	weather AS w4,
	weather AS w5
WHERE
	w1.Max_gustspeed > 55
	AND w2.Date = DATE_ADD(w1.Date, INTERVAL 1 DAY)
	AND w3.Date = DATE_ADD(w2.Date, INTERVAL 1 DAY)
	AND w4.Date = DATE_ADD(w3.Date, INTERVAL 1 DAY)
	AND w5.Date = DATE_ADD(w4.Date, INTERVAL 1 DAY)
),
Selected_dates AS (
SELECT
	date1,
	date2,
	date3,
	date4,
	date5
FROM
	Max_gust_cte
)
SELECT
	DISTINCT *
FROM
	weather
JOIN Selected_dates ON
	weather.date IN (date1, date2, date3, date4, date5);



-- 9. Find the number of days when the temperature went below 0 degrees Celsius

SELECT COUNT(w.Date)
FROM weather w
WHERE ((w.Avg_temperature - 32) * 5/9) < 0;   -- output: 853
    

-- 10. Create another table with a ???Foreign key??? relation with the existing given data set.

CREATE INDEX idx_weather_date ON
weather(Date);

CREATE TABLE additional (
  id INT PRIMARY KEY AUTO_INCREMENT,
  weather_id date,
  avg_cloud_cover DOUBLE,
  solar_radiation DOUBLE,
  FOREIGN KEY (weather_id) REFERENCES weather(Date)
);

DESC additional;












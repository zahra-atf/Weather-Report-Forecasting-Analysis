# Weather-Report-Forecasting-Analysis
Weather forecasting analysis using Python and SQL for pre-processing and analysing and Tableau for visualization


This project aims to provide accurate and reliable weather predictions based on global meteorological surface and upper-air observations. By pre-processing and analyzing the data using SQL and Python, and visualizing it using Tableau, we can help users gain insights into upcoming weather conditions.

Our dataset contains day-wise weather attributes from 2022 to July 2033 (predicted data).

This project is divided into two modules:

## Module 1: Pre-processing and analyzing data using Python and SQL

In this module, you will query the dataset using SQL to gain insights from the database. Tasks include pre-processing the data by handling null values, deleting or transforming irrelevant values, and removing duplicates. Additionally, you will analyze the data by answering requirements such as finding the temperature as cold/hot, the maximum number of days for which temperature dropped, the average humidity, and more. You will also add data for 2034 and 2035 and forecast predictions for these years.

### Task1:

Subtask 1: Correct years for given data set

Subtask 2: removal of duplicate rows and duplicate Columns

Subtask 3: fix a few labels in the given data set

Subtask 4: Encoding data into suitable format

### Task2:

Analysing the data with SQL and answer to these questions:

- Give the count of the minimum number of days for the time when temperature reduced
- Find the temperature as Cold/hot by using the case and avg of values of the given data set
- Can you check for all 4 consecutive days when the temperature was below 30 Fahrenheit
- Can you find the maximum number of days for which temperature dropped
- Can you find the average humidity average from the dataset
( NOTE: should contain the following clauses: group by, order by, date )
- Use the GROUP BY clause on the Date column and make a query to fetch details for average windspeed ( which is now windspeed done in task 3 )
- Please add the data in the dataset for 2034 and 2035 as well as forecast predictions for these years
( NOTE: data consistency and uniformity should be maintained )
- If the maximum gust speed increases from 55mph, fetch the details for the next 4 days
- Find the number of days when the temperature went below 0 degrees Celsius
- Create another table with a “Foreign key” relation with the existing given data set.


## Module 2: Visualizing data using Tableau

In this module, you will use the weather dataset and the data table you created in module 1 to create a dashboard using different statistical graphs and diagrams. The dashboard should consist of basic Tableau visuals such as stacked bar charts, cards, line charts, pie charts, and more. Numeric data types should be used predominantly in the visuals.

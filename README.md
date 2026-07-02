# MySQL-Company-Layoffs-Exploratory-Data-Analysis
Exploratory Data Analysis of a company layoffs dataset using MySQL Workbench

## Project Overview
Now that the data is clean, this project explores the dataset to uncover patterns and trends regarding global layoffs. The analysis answers critical business questions about which companies were impacted most, alongside chronological trends.

## Key Insights & Queries Included
*   **The Big Picture:** Finding the maximum and total layoffs (`SUM(total_laid_off)`) across the entire dataset.
*   **Company Impact:** Identifying which companies faced the highest losses.
*   **Chronological Trends:** Analyzing layoffs by year and calculating a rolling total of layoffs month-by-month to visualize momentum.

## How to Run the Analysis
1. Ensure you have run the previous Data Cleaning script to prepare the schema.
2. Open `Company_Layoffs_Exploratory_Data_analysis.sql` in MySQL Workbench.
3. Execute the queries sequentially to view the aggregated results and trends.

## Tech Stack
*   **Database:** MySQL Server
*   **IDE:** MySQL Workbench
*   **SQL Concepts Used:** Aggregate Functions (`SUM`, `AVG`, `MAX`), Grouping (`GROUP BY`, `ORDER BY`), CTEs (`WITH ... AS`), and Window Functions (`SUM(), DENSE_RANK, OVER()`).

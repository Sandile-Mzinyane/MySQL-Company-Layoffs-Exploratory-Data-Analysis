-- Exploratory Data Analysis

SELECT *
FROM layoffs_staging2;

DESCRIBE layoffs_staging2;

-- Data Preview
SELECT *
FROM layoffs_staging2
LIMIT 10;

-- Maximum Laid-off
SELECT MAX(total_laid_off)
FROM layoffs_staging2;

-- Minimum Laid-off
SELECT MIN(total_laid_off)
FROM layoffs_staging2;

-- Average Laid-Off
SELECT AVG(total_laid_off) AS average_laid_off
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

-- Total No. of People Laid Off
SELECT SUM(total_laid_off) AS Total_Laid_Off
FROM layoffs_staging2;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- Date Range
SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

-- Total Layoffs By Country
SELECT country, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

-- Total Layoffs By Industry
SELECT industry, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
Group BY industry
ORDER BY 2 DESC;

-- Total Layoffs By City Hubs
SELECT location, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY location
ORDER BY 2 DESC;

-- Total Layoffs By Year
SELECT YEAR(`date`) AS `Year`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC; 

SELECT *
FROM layoffs_staging2;

SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7)
GROUP BY `MONTH`
ORDER BY 1;

-- Rolling Total Using CTEs
WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_retrenched
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7)
GROUP BY `MONTH`
ORDER BY 1 ASC
)

SELECT `MONTH`, total_retrenched,
	SUM(total_retrenched) OVER(ORDER BY `MONTH`) AS Rolling_Total
FROM Rolling_Total;

-- Total Layoffs By Company
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

WITH annual_retrenchments AS 
(
SELECT company, YEAR(`date`) AS `year`, SUM(total_laid_off) AS total_retrenched
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
),
company_year_rank AS
(SELECT *,
	DENSE_RANK() OVER(PARTITION BY `year` ORDER BY total_retrenched DESC) AS year_rank
FROM annual_retrenchments
WHERE `year` IS NOT NULL
)

SELECT *
FROM company_year_rank
WHERE year_rank <= 5;
-- Exploratory Data Analysis

SELECT *
FROM layoffs_staging2;

SELECT MAX(total_laid_off)
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

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
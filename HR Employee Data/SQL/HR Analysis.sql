
-- QUESTIONS

-- 1. What is the gender breakdown of employees in the company?
SELECT gender, count(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY gender;

-- 2. What is the race/ethnicity breakdown of employees in the company?
SELECT race, COUNT(*) as count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY race
ORDER BY count(*) DESC;

-- 3. What is the age distribution of employees in the company? 
SELECT
	min(age) AS youngest,
    max(age) AS oldest
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00';

SELECT
	CASE
		WHEN age >= 18 AND age <= 25 THEN '18-25'
        WHEN age >= 26 AND age <= 35 THEN '26-35'
        WHEN age >= 36 AND age <= 45 THEN '36-45'
        WHEN age >= 46 AND age <= 55 THEN '46-55'
        WHEN age >= 56 AND age <= 65 THEN '56-65'
        ELSE '66+'
	END AS age_group,gender,
count(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY age_group, gender
ORDER BY age_group, gender;
    
-- 4. How many employees work at headquaters versus remote locations?
SELECT location, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY location;
    
-- 5. What is the average length of employment for employees who have been terminated?
SELECT
	ROUND(AVG(DATEDIFF(termdate, hire_date))/365) AS avg_length_employment
FROM hr
WHERE termdate <= curdate() AND termdate <> '0000-00-00' AND age >= 18;
    
-- 6. How does the gender distribution vary across departments?

SELECT department, gender, COUNT(*) as count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY department, gender
ORDER BY department;

-- 7. How is the distribution of job tittles across the company?

SELECT jobtitle, COUNT(*) as count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY jobtitle
ORDER BY jobtitle;
    
-- 8. Which department has the highest turnover rate?    
SELECT department,
total_count,
terminated_count,
terminated_count/total_count AS termination_rate
FROM (
	SELECT department,
    count(*) AS total_count,
    SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminated_count
    FROM hr
    WHERE age >= 18
    GROUP by department 
) AS subquery
ORDER BY  termination_rate DESC;
       
-- 9. What is the distribution of employees across locations by city and state?
SELECT location_state, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY location_state
ORDER BY count DESC;

-- 10. How has the company's employee count changed over time based on hire date and termination dates ?
SELECT
	year,
	hires,
	terminations,
	hires-terminations AS net_change,
	ROUND((hires - terminations)/hires * 100, 2) AS net_change_percent
FROM(
	SELECT 
		YEAR(hire_date) AS year,
        count(*) AS hires,
        SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminations
        FROM hr
        WHERE age >= 18
        GROUP BY YEAR(hire_date)
	) AS subquery
ORDER BY year ASC;

-- 11. What is the tenure distribution for each department?
SELECT department, round(AVG(datediff(termdate, hire_date)/365),0) AS avg_tenure
FROM hr
WHERE termdate<= curdate() AND termdate<>'0000-00-00' AND age >= 18
GROUP BY department;

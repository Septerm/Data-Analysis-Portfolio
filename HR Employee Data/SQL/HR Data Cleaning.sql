-- Creating Datebase for Porject
CREATE DATABASE projects;
USE projects;

-- Looking at the data
SELECT * FROM hr;
DESCRIBE hr;

-- Fixing employer ID Column Heading Name
ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;


-- Fixing the format of birthdate column 
SELECT birthdate FROM hr;

SET sql_safe_updates = 0; -- Alows updates to be made to CSV file 

UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
	WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END	;

-- Changing Datatype of birthdate from text to date
ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

-- Fixing the format of hire_date column

UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
	WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END	;

-- Changing Datatype of hire_date from text to date
ALTER TABLE hr
MODIFY COLUMN hire_date DATE;


-- Fixing the format of termdate column
SET SQL_MODE = ' '; -- Allows quary to work 

UPDATE hr
SET termdate = date(str_to_date(termdate, '%Y-%m-%d%H:%i:%sUTC'))
WHERE termdate IS NOT NULL AND termdate !='';

-- Changing Datatype of termdate from text to date
ALTER TABLE hr
MODIFY COLUMN termdate DATE;


-- Creating a new column for age 
ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());


-- Checking for incorrect ages 
SELECT
	min(age) AS youngest,
    max(age) AS oldest
FROM hr;

-- Checking to see how much records have ages lower then 18 (Ages of employess should be greater then 18 )
SELECT count(*) FROM hr WHERE age < 18;


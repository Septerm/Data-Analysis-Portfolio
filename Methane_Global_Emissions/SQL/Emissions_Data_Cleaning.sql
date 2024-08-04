CREATE DATABASE ch4_emissions;
USE ch4_emissions;


/* Looking at Dataset*/
SELECT *
FROM emissions;


/*Number of Countries in dataset*/
SELECT COUNT(DISTINCT(Country)) AS Number_OF_Countries
FROM emissions;

/* List of countries in dataset */
SELECT DISTINCT(Country)
FROM emissions
ORDER BY COUNTRY; -- World and EU is considered a country in data set needs to be remove from analyis  since the countries of the EU are already there

SELECT COUNT(DISTINCT(Country)) AS Number_OF_Countries
FROM emissions
WHERE Country NOT REGEXP "World"  AND Country NOT REGEXP "European";

/* Number of Sectors */
SELECT DISTINCT(Sector) 
FROM emissions
ORDER BY Sector; -- Need to exclude  "Total excluding LUCF", "Total including LUCF", "Sector" from analysis 

SELECT COUNT(DISTINCT(SECTOR))
FROM emissions
WHERE Sector NOT REGEXP "LUCF" AND Sector NOT REGEXP "Sector";

SELECT DISTINCT(SECTOR)
FROM emissions
WHERE Sector NOT REGEXP "LUCF" AND Sector NOT REGEXP "Sector";
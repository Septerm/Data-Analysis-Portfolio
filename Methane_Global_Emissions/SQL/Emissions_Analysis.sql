
/* 1. What is the percntage increase of Methane emissions from 1990 to 2018 ? */

SELECT  ((SUM(`2018`) - SUM(`1990`) )/ SUM(`1990`)) * 100 AS Percentagechange
FROM emissions
WHERE Country NOT REGEXP "World" AND Sector NOT REGEXP "LUCF" AND Sector NOT REGEXP "Sector" AND Country NOT REGEXP "European";

/* 2. What Sectors makeup the top 5 contributors for methane emissions in 2018 and 1990 ? */

SELECT Sector, SUM(`2018`) AS `2018`, SUM(`1990`) AS `1990`
from emissions
WHERE Country NOT REGEXP "World" AND Sector NOT REGEXP "LUCF" AND Sector NOT REGEXP "Sector" AND Country NOT REGEXP "European"
GROUP BY Sector
ORDER BY SUM(`2018`) DESC
LIMIT 5;

/* 3. Which countries are the top 5 contributors of mathane emissions in 2018 */

SELECT Country, SUM(`2018`) AS `2018`
from emissions
WHERE Country NOT REGEXP "World" AND Sector NOT REGEXP "LUCF" AND Sector NOT REGEXP "Sector" AND Country NOT REGEXP "European"
GROUP BY Country
ORDER BY SUM(`2018`) DESC
Limit 5;

/* 4. Which countries are the top 5 contributors of mathane emissions in 1990 */

SELECT Country, SUM(`1990`) AS `1990`
from emissions
WHERE Country NOT REGEXP "World" AND Sector NOT REGEXP "LUCF" AND Sector NOT REGEXP "Sector" AND Country NOT REGEXP "European"
GROUP BY Country
ORDER BY SUM(`1990`) DESC
Limit 5;

/* 5. Which countries are the top 5 contributors of mathane emissions base on the agriculture sector in 2018 */

SELECT Country, SUM(`2018`) AS `2018`
from emissions
WHERE Sector REGEXP "Agriculture" AND Country NOT REGEXP "World" AND Sector NOT REGEXP "LUCF" AND Sector NOT REGEXP "Sector" AND Country NOT REGEXP "European"
GROUP BY Country
ORDER BY SUM(`2018`) DESC
Limit 5;

/* 6. Which countries are the top 5 contributors of mathane emissions base on the energy sector in 2018 */

SELECT Country, SUM(`2018`) AS `2018`
from emissions
WHERE Sector REGEXP "Energy" AND Country NOT REGEXP "World" AND Sector NOT REGEXP "LUCF" AND Sector NOT REGEXP "Sector" AND Country NOT REGEXP "European"
GROUP BY Country
ORDER BY SUM(`2018`) DESC
Limit 5;

/* 7. Which countries are the top 5 contributors of mathane emissions base on the waste sector in 2018 */

SELECT Country, SUM(`2018`) AS `2018`
from emissions
WHERE Sector REGEXP "Waste" AND Country NOT REGEXP "World" AND Sector NOT REGEXP "LUCF" AND Sector NOT REGEXP "Sector" AND Country NOT REGEXP "European"
GROUP BY Country
ORDER BY SUM(`2018`) DESC
Limit 5;

/* 8. Which countries are the top 5 contributors of mathane emissions base on Fugitive emissions in 2018 */

SELECT Country, SUM(`2018`) AS `2018`
from emissions
WHERE Sector REGEXP "Fugitive" AND Country NOT REGEXP "World" AND Sector NOT REGEXP "LUCF" AND Sector NOT REGEXP "Sector" AND Country NOT REGEXP "European"
GROUP BY Country
ORDER BY SUM(`2018`) DESC
Limit 5;

/* 9. Which countries are the top 5 contributors of mathane emissions base on Fuel Combustion in 2018 */

SELECT Country, SUM(`2018`) AS `2018`
from emissions
WHERE Sector REGEXP "Fuel" AND Country NOT REGEXP "World" AND Sector NOT REGEXP "LUCF" AND Sector NOT REGEXP "Sector" AND Country NOT REGEXP "European"
GROUP BY Country
ORDER BY SUM(`2018`) DESC
Limit 5;

/* 10. What are the total amount of methane emissions the top 5 contributors are reponsible for vs the world for 2018 */

SELECT 
	CASE
		WHEN Country = 'China'         THEN 'Top 5 Countries'
        WHEN Country = 'Russia'        THEN 'Top 5 Countries'
        WHEN Country = 'United States' THEN 'Top 5 Countries'
        WHEN Country = 'India'         THEN 'Top 5 Countries'
        WHEN Country = 'Brazil'        THEN 'Top 5 Countries'
		ELSE 'World'
	END AS Catagory,
	sum(`2018`) AS CH4_Emissions
FROM emissions
WHERE Country NOT REGEXP "World" AND Sector NOT REGEXP "LUCF" AND Sector NOT REGEXP "Sector" AND Country NOT REGEXP "European"
GROUP BY Catagory;

/* 11. What Percentage of the total emissions are the top 5 contributors responsible for ?  */

SELECT
	top_countries,
    world,
    total,
    (top_countries / total) * 100 as percent
FROM (
		SELECT
			sum(`2018`) as top_countries
		FROM emissions
        WHERE Country REGEXP '(Russia|China|United States|India|Brazil)' AND Sector NOT REGEXP "LUCF" AND Sector NOT REGEXP "Sector"
) AS sub1, (
		SELECT
			sum(`2018`) as world
            FROM emissions
            WHERE Country NOT REGEXP '(Russia|China|United States|India|Brazil)'  AND Country NOT REGEXP "World" AND Sector NOT REGEXP "LUCF" AND Sector NOT REGEXP "Sector" AND Country NOT REGEXP "European"
        
) AS sub2,(
		SELECT
        sum(`2018`) as total
        FROM emissions
        WHERE Country NOT REGEXP "World" AND Sector NOT REGEXP "LUCF" AND Sector NOT REGEXP "Sector" AND Country NOT REGEXP "European"
) AS sub3;



    
	


    

            
            
        
        
        













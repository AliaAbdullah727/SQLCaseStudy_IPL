SELECT *
FROM IPLPlayers

-- Q1: find the total spending on players for each team: 
SELECT Team, SUM(Price_in_cr) as total_spending 
from IPLPlayers 
group by Team 
order by total_spending DESC 


-- Q2 find the top 3 highest-paid 'ALL-ROUNDERS' across all teams: 
SELECT TOP 3 Player , Price_in_cr
FROM IPLPlayers 
WHERE Role = 'All-rounder' 
ORDER BY Price_in_cr DESC

--Q3 find the highest paid player in each team 
SELECT Player , Team, 
MAX(Price_in_cr) over(partition by Team) MaxPrice
from IPLPlayers 


-- OR 
WITH CTF AS(SELECT Team , max(Price_in_cr) as max_price
from IPLPlayers 
group by Team) 

SELECT i.Team , i.Player , c.max_price
FROM IPLPlayers i 
JOIN CTF c 
 on I.Team = c.Team 
 where i.Price_in_cr = c.max_price



 --Q4 Rank players by their price within each team and list the top 2 for each team 
WITH RankedPlayers AS(SELECT Team , Player , Price_in_cr , 
ROW_NUMBER() over( partition by Team order by price_in_cr DESC) PriceRank 
FROM IPLPlayers 
)


SELECT Player , Team , PriceRank 
from RankedPlayers
WHERE PriceRank <= 2


-- Q5 find the most expensive playre from each team along with the second most expensive player's name and price
WITH RankedPlayers AS(SELECT Team , Player , Price_in_cr , 
ROW_NUMBER() over( partition by Team order by price_in_cr DESC) PriceRank 
FROM IPLPlayers 
)

SELECT Team , 
MAX(CASE WHEN PriceRank = 1 then Player END) AS MostExpensivePlayer,
MAX(CASE WHEN PriceRank = 1 then Price_in_cr END) AS HighestPrice,
MAX(CASE WHEN PriceRank = 2 then Player END) AS SecondMostExpensivePlayer,
MAX(CASE WHEN PriceRank = 2 then Price_in_cr END) AS SecondHighestPrice

FROM RankedPlayers
group by Team


--Q6 calculate the perecentage of contribution of each player's price to their team's total spending 
WITH TotalSpending AS (SELECT Team , SUM(Price_in_cr) TotalSpending 
FROM IPLPlayers 
GROUP BY Team
)

SELECT t.Team , i.Player, ROUND((i.Price_in_cr / t.TotalSpending) * 100 ,2)as ContributionPercentage
FROM IPLPlayers i
JOIN TotalSpending t
 on i.Team = t.Team
ORDER BY ContributionPercentage DESC

-OR
SELECT Team , Player , Price_in_cr ,
CAST(Price_in_cr/ SUM(Price_in_cr) OVER(PARTITION BY Team) * 100 AS DECIMAL (10,2)) AS ContributionPercentage
from IPLPlayers
order by ContributionPercentage DESC


--Q7 CLASSIFY players as 'High' , 'Medium' , or 'Low' priced based on the following rules:
-- High : price > 15 $ 
-- Medium : price between 5 and 15 
-- Low : price below 5 
-- and find out the number of playrs in each braket
with category as (SELECT Team , Player , Price_in_cr ,
    CASE WHEN Price_in_cr > 15 then 'High' 
          WHEN Price_in_cr < 15 and  Price_in_cr > 5 then 'Medium' 
          WHEN Price_in_cr < 5 then 'Low' 
          END AS Category

FROM IPLPlayers)

SELECT Team , Category ,count(*) NoOfPlayers
FROM category 
GROUP BY Team , Category 
ORDER BY Team , Category


--Q8 find the average price of Indian players and compare it with overseas players.
SELECT 'Indian' as player_Type, AVG(Price_in_cr) AvgPrice 
FROM IPLPlayers 
where Type  in ('Indian (uncapped)','Indian (capped)')
UNION ALL 
SELECT 'Overseas' ,  AVG(Price_in_cr) AvgPrice 
FROM IPLPlayers 
where Type LIKE 'Overseas%'

--Q9: identify players who earn more than the average price in their team 
SELECT Team , Player , Price_in_cr 
FROM IPLPlayers i
WHERE Price_in_cr > (
    SELECT AVG(Price_in_cr) avg_price
    FROM IPLPlayers 
    WHERE Team = i.Team)



-- Q10 for each role, find the most expensive player and their price using a correlated subquery 
SELECT Player , Team , Role , Price_in_cr 
from IPLPlayers i 
WHERE Price_in_cr =(
   
   SELECT MAX(Price_in_cr)
    FROM IPLPlayers 
    WHERE Role=i.Role
    )
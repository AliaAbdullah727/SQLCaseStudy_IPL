🏏 IPL Team Analysis using SQL
A collection of SQL queries that analyze IPL auction data using real-world business questions. This project demonstrates SQL skills ranging from basic aggregations to advanced analytical techniques such as Common Table Expressions (CTEs), Window Functions, Correlated Subqueries, and Conditional Logic.


📌 Project Overview
The dataset contains information about IPL players, including:
Player Name
Team
Role
Price (in Crores)
Player Type (Indian/Overseas)
Using SQL, the project answers common analytical questions that IPL franchises, analysts, or cricket enthusiasts might ask.


🛠️ SQL Concepts Used
SELECT Statements
Filtering with WHERE
GROUP BY
ORDER BY
Aggregate Functions
SUM()
AVG()
MAX()
COUNT()
CASE Expressions
Common Table Expressions (CTEs)
Window Functions
ROW_NUMBER()
SUM() OVER()
MAX() OVER()
Correlated Subqueries
UNION ALL
JOIN Operations
📊 Analysis Performed
1. Team Spending Analysis
Calculate the total amount spent by each IPL team.
2. Highest Paid All-Rounders
Find the top three most expensive all-rounders across the tournament.
3. Highest Paid Player Per Team
Identify the most expensive player in every franchise.
4. Top Two Players by Price
Rank players within each team and retrieve the top two highest-paid players.
5. Compare First and Second Highest Purchases
Display the highest and second-highest paid player from each team.
6. Player Contribution to Team Budget
Calculate each player's percentage contribution to their team's total spending.
7. Player Price Classification
Categorize players as:
High (>15 Cr)
Medium (5–15 Cr)
Low (<5 Cr)
Then count the number of players in each category.
8. Indian vs Overseas Spending
Compare the average auction price of Indian players with overseas players.
9. Above-Team-Average Players
Find players whose auction price exceeds the average price within their own team.
10. Most Expensive Player by Role
Determine the highest-paid player for every playing role using correlated subqueries.


Technologies
SQL Server (T-SQL)
Microsoft SQL Server Management Studio (SSMS)

Suggestions and improvements are welcome. Feel free to fork the repository and submit a pull request.
# SQLCaseStudy_IPL

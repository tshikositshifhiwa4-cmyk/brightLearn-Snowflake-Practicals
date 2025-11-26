---------------------------------------------------------------------------------------
--View the first 100 rows of the dataset to understand its structure.
SELECT *
FROM PRACTICAL.SOCCER.DATA
LIMIT 100;
---------------------------------------------------------------------------------------
--2. Count the total number of players in the dataset.
SELECT COUNT (*) AS total_players
FROM PRACTICAL.SOCCER.DATA;
---------------------------------------------------------------------------------------
--3. List all unique teams in the league.
SELECT DISTINCT TEAM
FROM PRACTICAL.SOCCER.DATA;
---------------------------------------------------------------------------------------
--4. Count how many players are in each team.
SELECT TEAM,
       COUNT (*) AS NUMBER_OF_PLAYERS
FROM PRACTICAL.SOCCER.DATA
GROUP BY TEAM;
---------------------------------------------------------------------------------------
--5. Identify the top 10 players with the most goals.
SELECT PLAYER_NAME,
       GOALS
FROM PRACTICAL.SOCCER.DATA
ORDER BY GOALS DESC 
LIMIT 10;
---------------------------------------------------------------------------------------
--6. Find the average salary for players in each team.
SELECT TEAM,
       AVG (AVERAGE_SALARY_ZAR)
FROM PRACTICAL.SOCCER.DATA
GROUP BY ALL;
---------------------------------------------------------------------------------------
--7. Retrieve the top 10 players with the highest market value.
SELECT PLAYER_NAME,
       TEAM,
       MARKET_VALUE_ZAR
FROM PRACTICAL.SOCCER.DATA
ORDER BY MARKET_VALUE_ZAR
LIMIT 10;
---------------------------------------------------------------------------------------
--8. Calculate the average passing accuracy for each position.
SELECT POSITION,
       AVG (PASSING_ACCURACY) AS AVERAGE_PASSING_ACCURACY,
 FROM PRACTICAL.SOCCER.DATA
 GROUP BY POSITION;
 ---------------------------------------------------------------------------------------
--9. Compare shot accuracy with goals to find correlations.
SELECT POSITION,
       AVG (SHOT_ACCURACY) AS AVERAGE_SHOT_ACCURACY,
       AVG (GOALS) AS AVERAGE_GOALS
 FROM PRACTICAL.SOCCER.DATA
 GROUP BY POSITION;
---------------------------------------------------------------------------------------
--10. Compute total goals and assists for each team.
SELECT TEAM, 
       SUM(GOALS) AS TOTAL_GOALS, 
       SUM(ASSISTS) AS TOTAL_ASSISTS
 FROM PRACTICAL.SOCCER.DATA
GROUP BY TEAM;
---------------------------------------------------------------------------------------
--11. Count players by their marital status.
SELECT MARITAL_STATUS, 
       COUNT(*) AS PLAYER_COUNT 
 FROM PRACTICAL.SOCCER.DATA
GROUP BY MARITAL_STATUS;
---------------------------------------------------------------------------------------
--12. Count players by nationality.
SELECT NATIONALITY, 
COUNT(*) AS PLAYER_COUNT 
FROM PRACTICAL.SOCCER.DATA
GROUP BY NATIONALITY;
---------------------------------------------------------------------------------------
--13. Find average market value grouped by nationality.
SELECT NATIONALITY, 
AVG(MARKET_VALUE_ZAR) AS AVERAGE_MARKET_VALUE_ZAR
FROM PRACTICAL.SOCCER.DATA 
GROUP BY NATIONALITY;
---------------------------------------------------------------------------------------
--14. Determine how many player contracts end in each year.
SELECT CONTRACT_END_YEAR, 
COUNT(*) AS PLAYERS_WITH_CONTRACT_ENDING
FROM PRACTICAL.SOCCER.DATA 
GROUP BY CONTRACT_END_YEAR;
---------------------------------------------------------------------------------------
--15. Identify players whose contracts end next year.
SELECT PLAYER_NAME, 
TEAM, 
CONTRACT_END_YEAR
FROM PRACTICAL.SOCCER.DATA 
WHERE CONTRACT_END_YEAR = EXTRACT(YEAR FROM CURRENT_DATE) + 1;
---------------------------------------------------------------------------------------
--16. Summarize the number of players by injury status.
SELECT INJURY_STATUS, 
       COUNT(*) AS PLAYER_COUNT
FROM PRACTICAL.SOCCER.DATA 
GROUP BY INJURY_STATUS;
---------------------------------------------------------------------------------------
--17. Calculate goals per match ratio for each player.
SELECT PLAYER_NAME, 
       TEAM, 
        GOALS, 
        MATCHES_PLAYED,
       (GOALS::DECIMAL / NULLIF(MATCHES_PLAYED, 0)) AS GOALS_PER_MATCH
FROM PRACTICAL.SOCCER.DATA ;
---------------------------------------------------------------------------------------
--18. Count how many players are managed by each agent.
SELECT AGENT, 
       COUNT(*) AS PLAYERS_PER_AGENT
FROM PRACTICAL.SOCCER.DATA
GROUP BY AGENT;
---------------------------------------------------------------------------------------
--19. Calculate average height and weight by player position.
SELECT POSITION, 
       AVG(HEIGHT_CM) AS AVG_HEIGHT_CM,
       AVG(WEIGHT_KG) AS AVG_WEIGHT_KG
FROM PRACTICAL.SOCCER.DATA
GROUP BY POSITION;
---------------------------------------------------------------------------------------
--20. Identify players with the highest combined goals and assists.
SELECT PLAYER_NAME, 
        TEAM, 
        GOALS, 
        ASSISTS,
       (GOALS + ASSISTS) AS TOTAL_CONTRIBUTIONS
FROM PRACTICAL.SOCCER.DATA
ORDER BY TOTAL_CONTRIBUTIONS DESC
LIMIT 10;

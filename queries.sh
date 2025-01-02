#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM( winner_goals) FROM games ")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals + opponent_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL " SELECT AVG(winner_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL " SELECT ROUND(AVG(Winner_goals),2) FROM games ")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL " SELECT AVG(Winner_goals + Opponent_goals) FROM games ")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL " SELECT GREATEST(MAX(Winner_goals), MAX(Opponent_goals)) FROM games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL " SELECT  COUNT(*) FROM games WHERE winner_goals > 2")"

echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL " SELECT distinct name from teams inner join games on teams.team_id = games.winner_id where games.year = 2018 AND games.round = 'Final'")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL " SELECT DISTINCT name from teams inner join games on teams.team_id IN (games.winner_id, games.opponent_id) where games.year = 2014 AND round = 'Eighth-Final' ORDER BY name")"

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL " SELECT DISTINCT name from teams inner join games on teams.team_id = games.winner_id ORDER BY name")"

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL " SELECT distinct year, name from teams inner join games on teams.team_id = games.winner_id where round = 'Final'")"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL " SELECT DISTINCT name from teams where name LIKE 'Co%'")"

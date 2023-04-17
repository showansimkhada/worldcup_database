#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.
WINNING_GOALS="$($PSQL "SELECT SUM(winner_goals) FROM games")"
OPPONENT_GOALS="$($PSQL "SELECT SUM(opponent_goals) FROM games")"
TOTAL_GOALS=`expr $WINNING_GOALS + $OPPONENT_GOALS`

echo -e "\nTotal number of goals in all games from winning teams:"
echo $WINNING_GOALS

echo -e "\nTotal number of goals in all games from both teams combined:"
echo $TOTAL_GOALS

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT avg(winner_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals), 2) FROM games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT AVG(winner_goals + opponent_goals) FROM games")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT max(winner_goals) FROM games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT count(winner_goals) FROM games WHERE (winner_goals > 2)")"

echo -e "\nWinner of the 2018 tournament team name:"
echo  "$($PSQL "SELECT name FROM teams RIGHT JOIN games ON teams.team_id = games.winner_id WHERE (games.round = 'Final' AND games.year = '2018')")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "SELECT name FROM teams INNER JOIN games ON teams.team_id = games.winner_id OR teams.team_id = games.opponent_id WHERE (games.round = 'Eighth-Final' AND games.year = '2014') ORDER BY teams.name")"

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "SELECT DISTINCT(teams.name) FROM teams RIGHT JOIN games ON teams.team_id = games.winner_id WHERE teams.team_id = games.winner_id ORDER BY teams.name")"

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "SELECT games.year, teams.name FROM teams RIGHT JOIN games ON teams.team_id = games.winner_id WHERE games.round = 'Final' ORDER BY games.year")"

echo -e "\nList of teams that start with 'Co':"
echo  "$($PSQL "SELECT name FROM teams WHERE name LIKE 'Co%'")"

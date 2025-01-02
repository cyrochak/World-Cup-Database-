#!/bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS=',' read -r year round winner opponent winner_goals opponent_goals
do
  if [[ $year != "year" ]]  # Skip header row
  then
    for TEAM in "$winner" "$opponent"  # Use double quotes for variables
    do
      TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$TEAM'")
      if [[ -z $TEAM_ID ]]
      then
        INSERT_TEAM=$($PSQL "INSERT INTO teams(name) VALUES('$TEAM')")
      fi
    done

    # Get the winner and opponent IDs from the teams table
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$winner'")
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$opponent'")

    # Ensure that the variables are not empty before proceeding
    if [[ -n $WINNER_ID && -n $OPPONENT_ID && -n $year && -n $round && -n $winner_goals && -n $opponent_goals ]]; then
      # Insert the game into the games table
      INSERT_GAME=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) 
      VALUES($year, '$round', $WINNER_ID, $OPPONENT_ID, $winner_goals, $opponent_goals)")
    else
      echo "Error: Missing data for game: $year, $round, $winner vs $opponent"
    fi
  fi
done

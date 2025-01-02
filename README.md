World Cup Database Challenge

This challenge involves creating a PostgreSQL database to track World Cup data, including teams, games, and their associated statistics. The goal is to perform various operations, such as importing data, querying the database, and ensuring data integrity.

Steps to Complete the Challenge

1. Database Schema

The database contains two tables:

teams:

team_id (Primary Key): Auto-incrementing integer.

name (Unique): Name of the team.

games:

game_id (Primary Key): Auto-incrementing integer.

year: Year the game was played.

round: Stage of the tournament (e.g., Final, Semi-Final).

winner_id: Foreign Key referencing teams.team_id.

opponent_id: Foreign Key referencing teams.team_id.

winner_goals: Goals scored by the winning team.

opponent_goals: Goals scored by the opponent team.

2. Importing Data

Data from a games.csv file is imported into the database using a bash script insert_data.sh. The script processes the data to:

Insert unique teams into the teams table.

Insert game details into the games table, ensuring foreign key relationships.

3. Queries

Once the data is imported, various queries are performed to extract insights, such as:

Total number of goals scored by winning teams.

List of unique winners.

Year and name of the tournament champions.

Teams that participated in specific rounds.

4. Troubleshooting

Common issues to check:

Duplicate entries: Ensure unique teams are added to the teams table.

Foreign key constraints: Ensure winner_id and opponent_id reference valid team_id values.

Data mismatches: Verify that all rows in games.csv are correctly processed.

5. Resetting the Database

If you encounter issues, you can reset the database:

TRUNCATE games RESTART IDENTITY;
TRUNCATE teams RESTART IDENTITY;

This clears all data and resets primary key sequences.

Example Queries

Total Goals by Winning Teams

SELECT SUM(winner_goals) FROM games;

List of Tournament Champions

SELECT year, name FROM teams
INNER JOIN games ON teams.team_id = games.winner_id
WHERE round = 'Final';

Teams Participating in 2014 Eighth-Final

SELECT DISTINCT name FROM teams
INNER JOIN games ON teams.team_id IN (games.winner_id, games.opponent_id)
WHERE year = 2014 AND round = 'Eighth-Final';

Running the Script

To execute the insert_data.sh script:

Ensure games.csv is formatted correctly.

Run the script:

./insert_data.sh

Verify the data using queries to ensure accuracy.

#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=numbergames -t --no-align -c"
SECRET=$(($RANDOM%(1000-1+1)+1))
#echo -e "$SECRET"

echo -e "Enter your username:"
read NAME
PLAYER=$($PSQL "SELECT username,games_played, best_game FROM playes WHERE username = '$NAME'")
# if player doesn't exist
if [[ -z $PLAYER ]]
then
  # insert new player
  echo "Welcome, $NAME! It looks like this is your first time here."
  INSERT_NEW_PLAYER=$($PSQL "INSERT INTO playes(username, games_played) VALUES('$NAME', 0)")
  
  PLAYER=$($PSQL "SELECT username,games_played, best_game FROM playes WHERE username = '$NAME'")
else
  #yer
  echo "$PLAYER" | while IFS="|" read USERNAME GAMES_PLAYED BEST_GAME
    do
      echo -e "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
      
    done
fi

echo -e "\nGuess the secret number between 1 and 1000:"
read GUESS
TURNS=1

while [[ $GUESS -ne $SECRET ]]
do
  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
  echo -e "That is not an integer, guess again:"
    read GUESS
  else
    if [[ $GUESS -gt $SECRET ]] #too high
    then
      echo -e "It's lower than that, guess again:"
    else
      echo -e "It's higher than that, guess again:"
    fi
    read GUESS
    TURNS=$((TURNS + 1))
  fi
done

if [[ -z $BESTGAME ]]
then
  UPDATE_RESULT=$($PSQL "UPDATE playes SET best_game = $TURNS WHERE username = '$NAME'")
else
  if [[ $TURNS -lt $BEST_GAME ]]
  then
    UPDATE_RESULT=$($PSQL "UPDATE playes SET best_game = $TURNS WHERE username = '$NAME'")
  fi
fi
UPDATE_RESULT=$($PSQL "UPDATE playes SET games_played = $((GAMESPLAYED + 1)) WHERE username = '$NAME'")

echo "You guessed it in $TURNS tries. The secret number was $SECRET. Nice job!"
exit
#!/bin/bash 
# connect to database 
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c" 
# no argument 
if [[ -z $1 ]] 
then 
  echo "Please provide an element as an argument."  
  exit
fi

# if number
if [[ $1 =~ ^[0-9]+$ ]] 
then 
  RESULT=$($PSQL " SELECT atomic_number, name, symbol, types.type, atomic_mass, melting_point_celsius, boiling_point_celsius
    FROM elements
    JOIN properties USING(atomic_number)
    JOIN types USING(type_id) WHERE atomic_number = $1"); 
elif [[ ${#1} -le 2 ]] 
then # if symbol
  RESULT=$($PSQL " SELECT atomic_number, name, symbol, types.type, atomic_mass, melting_point_celsius, boiling_point_celsius
    FROM elements
    JOIN properties USING(atomic_number)
    JOIN types USING(type_id) WHERE symbol = '$1'");
else #if name
  RESULT=$($PSQL " SELECT atomic_number, name, symbol, types.type, atomic_mass, melting_point_celsius, boiling_point_celsius
    FROM elements
    JOIN properties USING(atomic_number)
    JOIN types USING(type_id) WHERE name = '$1'"); 
fi

if [[ -z $RESULT ]] 
then 
  echo "I could not find that element in the database." 
else 
  echo "$RESULT" | while IFS="|" read ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELT BOIL 
  do 
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius." 
  done 
fi


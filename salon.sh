#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c"
POSSIBLE_SERVICES=$($PSQL "SELECT service_id,name FROM services")

APPOINT_MENU() {
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  # if customer doesn't exist
  if [[ -z $CUSTOMER_NAME ]]
  then
    # get new customer name
    echo -e "\nWhat's your name?"
    read CUSTOMER_NAME

    # insert new customer
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
  fi

  # get customer_id
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$PHONE_NUMBER'")

  #get the time
  echo -e "\nWhat time would you like to book?"
  read SERVICE_TIME
  # insert APPOINTMENT
  INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id,time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = '$SERVICE_ID_SELECTED'")
  echo -e "I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
  
}

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  echo "$POSSIBLE_SERVICES" | while IFS='|' read SERVICE_ID NAME
  do
    echo "$SERVICE_ID) $NAME"
  done
  echo "Please choose any services from teh choices above"
  read SERVICE_ID_SELECTED
  case $SERVICE_ID_SELECTED in
    1)  APPOINT_MENU ;;
    2)  APPOINT_MENU ;;
    3)  APPOINT_MENU ;;
    *) MAIN_MENU "Please enter a valid option." ;;
  esac
}

MAIN_MENU


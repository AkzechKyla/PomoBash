#!/usr/bin/env bash

FOCUS_TIME=25 # 25 minutes
SHORT_BREAK=5 # 5 minutes
LONG_BREAK=15 # 15 minutes
ALERT_MESSAGE="Pomodoro completed."

function run_pomodoro() {
  echo "POMODORO START"
  echo

  for i in $(seq 1 $((FOCUS_TIME * 60))) # Convert minutes to seconds
  do
    sleep 1
    rem=$(( (FOCUS_TIME * 60) - i ))
    echo -ne "$((rem / 60)) : $((rem % 60))\\r"
  done

  echo
  echo
  echo ALERT_MESSAGE
}

#--- MAIN LOOP ---
while true; do
  run_pomodoro

  echo "➡️  Press [Enter] to start the next Pomodoro or Ctrl+C to exit."
  read
done

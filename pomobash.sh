#!/usr/bin/env bash

FOCUS_TIME=25 # 25 minutes
SHORT_BREAK=5 # 5 minutes
LONG_BREAK=15 # 15 minutes
ALERT_MESSAGE="Pomodoro completed."

#--- FUNCTION: Countdown Timer ---
function countdown() {
  local time=$1  # Duration in minutes
  local total_seconds=$((time * 60))

  echo
  echo "⏳ Timer started for $time minutes..."
  echo

  for ((i = total_seconds; i > 0; i--)); do
    echo -ne "$(printf "%02d:%02d" $((i / 60)) $((i % 60)))\r"
    sleep 1
  done

  echo -e "\n⏰ Time's up!"
  echo
}

#--- FUNCTION: Run a Single Pomodoro Session ---
function run_pomodoro() {
  echo "🔥 Pomodoro #$((POMODORO_COUNT + 1)) - Focus for $FOCUS_TIME minutes."
  countdown $FOCUS_TIME
  echo $ALERT_MESSAGE
  ((POMODORO_COUNT++))
  echo
}

#--- FUNCTION: Take a Break (Short or Long) ---
function take_break() {
  if ((POMODORO_COUNT % 4 == 0)); then
    echo "🌿 Take a long break! ($LONG_BREAK minutes)"
    countdown $LONG_BREAK
  else
    echo "☕ Take a short break! ($SHORT_BREAK minutes)"
    countdown $SHORT_BREAK
  fi
}

#--- MAIN LOOP ---
while true; do
  run_pomodoro
  take_break

  echo "➡️  Press [Enter] to start the next Pomodoro or Ctrl+C to exit."
  read
done

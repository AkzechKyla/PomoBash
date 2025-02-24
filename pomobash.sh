#!/usr/bin/env bash

#--- DEFAULT VALUES ---
FOCUS_TIME=25       # 25 minutes
SHORT_BREAK=5       # 5 minutes
LONG_BREAK=15       # 15 minutes
POMODORO_COUNT=0    # Pomodoro counter

#--- FUNCTION: Countdown Timer ---
function countdown() {
  local time=$1  # Duration in minutes
  local total_seconds=$((time * 60))

  echo
  echo "⏳ Timer started for $time minutes..."
  echo

  for ((i = total_seconds; i >= 0; i--)); do
    echo -ne "$(printf "%02d:%02d" $((i / 60)) $((i % 60)))\r"
    sleep 1
  done

  echo -e "\n⏰ Time's up!"
}

#--- FUNCTION: Run a Single Pomodoro Session ---
function run_pomodoro() {
  echo "🔥 Pomodoro #$((POMODORO_COUNT + 1)) - Focus for $FOCUS_TIME minutes."
  countdown $FOCUS_TIME
  ((POMODORO_COUNT++))
  echo
}

#--- FUNCTION: Take a Break (Short or Long) ---
function take_break() {
  if ((POMODORO_COUNT % 4 == 0)); then
    echo "🌿 Take a long break! ($LONG_BREAK minutes)"
    countdown $LONG_BREAK
    echo "🎉 Congratulations! You've completed a Pomodoro cycle."
    echo "-------------------------------------------------------"
  else
    echo "☕ Take a short break! ($SHORT_BREAK minutes)"
    countdown $SHORT_BREAK
  fi
  echo
}

#--- MAIN LOOP ---
while true; do
  clear
  run_pomodoro
  take_break

  echo "➡️  Press [Enter] to start the next Pomodoro or Ctrl+C to exit."
  read
done

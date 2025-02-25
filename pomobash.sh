#!/usr/bin/env bash

#--- DEFAULT VALUES ---
FOCUS_TIME=25       # 25 minutes
SHORT_BREAK=5       # 5 minutes
LONG_BREAK=15       # 15 minutes
POMODORO_COUNT=0    # Pomodoro counter
paused=false        # Paused flag

#--- FUNCTION: Countdown Timer with Pause/Resume/Quit ---
function countdown() {
  local time=$1  # Duration in minutes
  local total_seconds=$((time * 60))

  echo -e "\n⏳ Timer started for $time minutes...\n"
  echo -e "(Press 'p' to pause, 'r' to resume, or 'q' to quit.)\n"

  for ((i = total_seconds; i >= 0; i--)); do
    # Wait for user input asynchronously
    read -t 1 -n 1 keypress && handle_input $keypress

    # Pause execution if paused is true
    while $paused; do
      read -n 1 -s keypress && handle_input $keypress
    done

    # Exit if user quits
    if [[ $keypress == "q" ]]; then
      echo -e "\n🚪 Exiting Pomodoro Timer."
      exit 0
    fi

    echo -ne "$(printf "%02d:%02d" $((i / 60)) $((i % 60)))\r"
  done

  echo -e "\n⏰ Time's up!\n"
  espeak "Time's up!"
}

#--- FUNCTION: Handle Key Inputs ---
function handle_input() {
  case $1 in
    p)  echo -e "\n⏸️  Timer paused. Press 'r' to resume." && paused=true ;;
    r)  echo -e "\n▶️  Timer resumed." && paused=false ;;
    q)  echo -e "\n🚪 Exiting Pomodoro Timer." && exit 0 ;;
  esac
}

#--- FUNCTION: Run a Single Pomodoro Session ---
function run_pomodoro() {
  echo "🔥 Pomodoro #$((POMODORO_COUNT + 1)) - Focus for $FOCUS_TIME minutes."
  espeak "Focus for $FOCUS_TIME minutes."
  countdown $FOCUS_TIME
  ((POMODORO_COUNT++))
}

#--- FUNCTION: Take a Break (Short or Long) ---
function take_break() {
  if ((POMODORO_COUNT % 4 == 0)); then
    echo "🌿 Take a long break! ($LONG_BREAK minutes)"
    espeak "Take a long break for $LONG_BREAK minutes."
    countdown $LONG_BREAK
    echo "🎉 Congratulations! You've completed a Pomodoro cycle."
    espeak "Congratulations! You've completed a Pomodoro cycle."
    echo "-------------------------------------------------------"
  else
    echo "☕ Take a short break! ($SHORT_BREAK minutes)"
    espeak "Take a short break for $SHORT_BREAK minutes."
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

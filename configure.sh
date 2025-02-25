#!/usr/bin/env bash

#--- DEFAULT VALUES ---
FOCUS_TIME=25             # 25 minutes
SHORT_BREAK=5             # 5 minutes
LONG_BREAK=15             # 15 minutes
AUTO_START_POMODORO=false # Auto-start pomodoro flag
AUTO_START_BREAK=false    # Auto-start break flag

#--- FUNCTION: Ensure user input is a positive integer ---
function handle_integer_input() {
    local default_value=$1
    local variable_name=$2

    while true; do
        read user_input
        if [[ -z "$user_input" ]]; then
            eval $variable_name=$default_value # Set default value if input is empty
            break
        elif [[ $user_input =~ ^[0-9]+$ ]]; then
            eval $variable_name=$user_input
            break
        else
            echo "Invalid input. Please enter a number."
        fi
    done
}

#--- FUNCTION: Ensure user input is 'y' or 'n' ---
function handle_boolean_input() {
    local default_value=$1
    local variable_name=$2

    while true; do
        read user_input
        if [[ -z "$user_input" ]]; then
            eval $variable_name=$default_value # Set default value if input is empty
            break
        elif [[ "$user_input" == "y" ]]; then
            eval $variable_name=true
            break
        elif [[ "$user_input" == "n" ]]; then
            eval $variable_name=false
            break
        else
            echo "Invalid input. Please enter 'y' or 'n'."
        fi
    done
}

#--- MAIN PROMPTS ---

echo -e "\nConfigure your Pomodoro settings:\n"

echo -e "1. Focus Time (minutes) [default: $FOCUS_TIME]: \c"
handle_integer_input $FOCUS_TIME FOCUS_TIME

echo -e "2. Short Break (minutes) [default: $SHORT_BREAK]: \c"
handle_integer_input $SHORT_BREAK SHORT_BREAK

echo -e "3. Long Break (minutes) [default: $LONG_BREAK]: \c"
handle_integer_input $LONG_BREAK LONG_BREAK

echo -e "4. Auto-start Pomodoro Cycle? [y/n] [default: $AUTO_START_POMODORO]: \c"
handle_boolean_input $AUTO_START_POMODORO AUTO_START_POMODORO

echo -e "5. Auto-start Break time? [y/n] [default: $AUTO_START_BREAK]: \c"
handle_boolean_input $AUTO_START_BREAK AUTO_START_BREAK

#--- DISPLAY UPDATED SETTINGS ---

echo -e "\n✅ Pomodoro settings updated!\n"
echo -e "FOCUS TIME: $FOCUS_TIME minutes"
echo -e "SHORT BREAK: $SHORT_BREAK minutes"
echo -e "LONG BREAK: $LONG_BREAK minutes"
echo -e "AUTO-START POMODORO: $AUTO_START_POMODORO"
echo -e "AUTO-START BREAK: $AUTO_START_BREAK\n"

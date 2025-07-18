#!/bin/bash

#4countdown.sh

get_user_input() {
    read -p "Enter a number: " number
    if ! [[ "$number" =~ ^[0-9]+$ ]]; then
        echo "Invalid input. Please enter a positive integer."
        get_user_input
    fi
}

countdown() {
    local count="$1"
    while [[ "$count" -gt 0 ]]; do
        echo "$count"
        sleep 1
        ((count--))
    done
    echo "Countdown finished!"
}

get_user_input
countdown "$number"
#!/bin/bash

# 7fortune_teller.sh

# stored fortune messages
fortunes=(
  "You will find happiness soon."
  "A surprise awaits you today."
  "Great opportunities are coming your way."
  "Be cautious with new ventures."
  "Luck favors the prepared mind."
  "An old friend will reconnect with you."
  "Hard work will bring success."
  "Expect the unexpected."
  "Your efforts will be rewarded."
  "A new adventure is on the horizon."
  "You will overcome challenges."
)

while true; do
  # Get a random fortune message
  fortune=${fortunes[RANDOM % ${#fortunes[@]}]}
  echo "Your fortune: $fortune"

  # Ask the user if they want another fortune
  read -p "Do you want another fortune? (yes/no): " answer
  if [[ "$answer" != "yes" ]]; then
    break
  fi
done

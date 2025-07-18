#!/bin/bash

#currency_converter.sh

currency_converter(){
    local amount=$1
    local from_currency=$2
    local to_currency=$3
    converted_amount=$(curl -s "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/${from_currency}.json" | grep '"'"${to_currency}"'":' | awk -F': ' '{print $2}' | tr -d ',') 
    if [[ -z "$converted_amount" ]]; then
        echo "Conversion rate not found for $from_currency to $to_currency."
        return 1
    fi
    to_currency_upper=$(echo "$to_currency" | tr '[:lower:]' '[:upper:]')
    from_currency_upper=$(echo "$from_currency" | tr '[:lower:]' '[:upper:]')
    echo "Conversion rate: 1 $from_currency_upper = $converted_amount $to_currency_upper"
    echo "Converting $amount from $from_currency_upper to $to_currency_upper"
    echo "Converted amount: $(echo "$amount * $converted_amount" | bc -l)"
}

get_user_input() {
    while true; do
        read -p "Enter amount: " amount
        read -p "Enter from currency (e.g., USD): " from_currency
        read -p "Enter to currency (e.g., EUR): " to_currency

        from_currency=$(echo "$from_currency" | tr '[:upper:]' '[:lower:]')
        to_currency=$(echo "$to_currency" | tr '[:upper:]' '[:lower:]')
        if [[ -z "$amount" || -z "$from_currency" || -z "$to_currency" ]]; then
            echo "Usage: currency_converter requires amount, from currency, and to currency."
            continue
        fi

        if ! [[ "$amount" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
            echo "Invalid amount. Please enter a valid number for the amount."
            continue
        fi

        if [[ "$from_currency" == "$to_currency" ]]; then
            echo "No conversion needed, both currencies are the same."
            exit 0
        fi
        break
    done
}

get_user_input
currency_converter "$amount" "$from_currency" "$to_currency"
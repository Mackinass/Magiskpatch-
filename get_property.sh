#!/bin/bash

# Function to mimic Android's getprop command using GETPROP_OUTPUT file
getprop() {
    # Check if GETPROP_OUTPUT exists
    if [ ! -f GETPROP_OUTPUT ]; then
        echo "Error: GETPROP_OUTPUT file not found."
        return 1
    fi

    if [ $# -eq 0 ]; then
        # No specific property requested, print entire file
        cat GETPROP_OUTPUT
    else
        # Search for the specific property key
        local key="$1"
        local key_value=$(grep -w "$key" GETPROP_OUTPUT)
        
        if [ -z "$key_value" ]; then
            # Key not found
            echo "Error: Property '$key' not found."
            return 1
        fi

        # Extract and clean up the value (removing brackets)
        local value=$(echo "$key_value" | awk -F': ' '{print $2}' | tr -d '[]')
        echo "$value"
    fi
}

# Export the function so it can be used in subshells or scripts
export -f getprop

#!/bin/bash

# Log file path
LOG_FILE="/var/log/malicious_activity.log"

# Check if log file exists, create if not
if [ ! -f "$LOG_FILE" ]; then
    touch "$LOG_FILE"
fi

# Function to log messages
log_message() {
    local log_level="$1"
    local message="$2"
    local timestamp=$(date +"%Y-%m-%d %T")
    echo "[$timestamp] [$log_level] $message" >> "$LOG_FILE"
}

# Function to check for malicious activity
check_malicious_activity() {
    local current_time=$(date +%s)
    local last_activity_time=$(stat -c %Y "$LOG_FILE")
    local time_diff=$((current_time - last_activity_time))

    log_message "DEBUG" "Current Time: $current_time"
    log_message "DEBUG" "Last Activity Time: $last_activity_time"
    log_message "DEBUG" "Time Difference: $time_diff"

    if [ $time_diff -gt 3600 ]; then  # Check activity in the last 1 hour
        log_message "WARNING" "Potential malicious activity detected!"
        # Add additional checks or commands to analyze and respond to malicious activity
    else
        log_message "INFO" "No recent malicious activity detected."
    fi
}

# Main function
main() {
    log_message "INFO" "Script started."
    check_malicious_activity
    log_message "INFO" "Script completed."
}

# Execute main function
main


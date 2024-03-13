#!/bin/bash
# Set the directory where your programs are installed
programs_directory="/usr/bin"
# Get the current date
current_date=$(date +%Y-%m-%d)
# Calculate the date 30 days ago
thirty_days_ago=$(date -d "30 days ago" +%Y-%m-%d)
# Find programs modified within the last 30 days in the specified directory
modified_programs=$(find "$programs_directory" -type f -newermt "$thirty_days_ago" ! -newermt "$current_date")
# Iterate over each modified program
for program in $modified_programs; do
    # Get the installation date
    install_date=$(stat -c %y "$program" | cut -d' ' -f1)
    # Get the last run date
    last_run_date=$(stat -c %y "$program")
    # Print the program name, installation date, and last run date
    echo "Program: $program Installed on: $install_date"
    echo "Last run on: $last_run_date"
    echo "-----------------------------------"
done

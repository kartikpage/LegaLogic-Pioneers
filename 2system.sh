#!/bin/bash
# Define the directory where systemd service units are located
SERVICE_DIR="/etc/systemd/system"
# Get the current date in seconds since epoch
CURRENT_DATE=$(date +%s)
# Calculate the date 30 days ago in seconds since epoch
THIRTY_DAYS_AGO=$(date -d "30 days ago" +%s)
# Iterate through each service unit file in the directory
for service_file in "$SERVICE_DIR"/*.service; do
    # Extract the service name from the file name
    service_name=$(basename "$service_file" .service)    
    # Get the activation time of the service
    activation_time=$(systemctl show -p ActiveEnterTimestamp "$service_name" | cut -d'=' -f2)    
    # Convert activation time to seconds since epoch
    activation_seconds=$(date -d "$activation_time" +%s)
    # Check if the service was activated in the last 30 days
    if [ "$activation_seconds" -ge "$THIRTY_DAYS_AGO" ] && [ "$activation_seconds" -le "$CURRENT_DATE" ]; then
        echo "Service $service_name was started in the last 30 days"
    fi
done

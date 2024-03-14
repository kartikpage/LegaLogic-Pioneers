#!/bin/bash

# Directories and files to monitor
watchlist=("/home/kali/.config" )

# Output file for scan results
scan_results="/home/scan_results_$(date +%Y-%m-%d_%H-%M-%S).txt"

#

# Function to calculate and check hashes of files/directories
check_hashes() {
    local path=$1
    local hash_file="/tmp/hash_$(echo $path | sed 's|/|_|g').txt"

    # Check if hash file exists; if not, create it
    if [ ! -f "$hash_file" ]; then
        find "$path" -type f -exec md5sum {} \; > "$hash_file"
        echo "Initial hash generated for $path" >> "$scan_results"
    else
        # Check current state against hash file
        md5sum -c --quiet "$hash_file" > /dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo "WARNING: Potential unauthorized change detected in $path" >> "$scan_results"
            # Update the hash file to current state
            find "$path" -type f -exec md5sum {} \; > "$hash_file"
        else
            echo "No changes detected in $path" >> "$scan_results"
        fi
    fi
}

# Loop through watchlist to check each item
for item in "${watchlist[@]}"; do
    check_hashes "$item"
done

echo "Scan completed. Results saved to  $scan_results."
echo
echo "Displaying scan results:"
cat "$scan_results"

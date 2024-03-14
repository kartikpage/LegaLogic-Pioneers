#!/bin/bash

# Rootkit detector script for Kali Linux

# Ensure script is executed with root privileges
if [[ $(id -u) -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi
if ! command -v rkhunter &> /dev/null; then
	sudo apt-get install rkhunter
 	exit 1
fi
if ! command -v chkrootkit &> /dev/null; then
    sudo apt-get install chkrootkit
    exit 1
fi

# Run rkhunter
echo "Running rkhunter..."
rkhunter --check

# Run chkrootkit
echo "Running chkrootkit..."
chkrootkit

echo "Rootkit detection completed."

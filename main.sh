#!/bin/bash

echo "Welcome to Forensics and Malware Analysis Script!"

# Function to display the main menu conditionally
function display_menu() {
  if [[ ! "$in_memory_forensics" ]]; then
    echo "Select an option:"
    echo "1) Memory Forensics with Volatility"
    echo "2) Rootkit Detection"
    echo "3) Scan a File for Malware"
    echo "4) Exit"
  fi
}

# Function to perform memory forensics using Volatility
function memory_forensics() {
  echo "Enter the path to the memory image: "
  read memory_image

  # Check if Volatility is installed
 # if ! command -v volatility &> /dev/null; then
   # echo "Error: Volatility is not installed."
   # return 1
 # fi

  # Loop to accept multiple Volatility commands
  in_memory_forensics=true  # Set flag to stay in memory forensics mode
  while true; do
    echo "Enter Volatility commands (separate them with spaces, or 'q' to quit):"
    read -r volatility_commands

    if [[ "$volatility_commands" == "q" ]]; then
      in_memory_forensics=false  # Reset flag to exit memory forensics mode
      break
    fi

    # Run Volatility commands on the memory image
   # volatility -f $memory_image $volatility_commands
   cd volatility
   python2 vol.py -f $memory_image $volatility_commands
   cd ..
  done
}

# Function to detect rootkits (replace 'rootkit_hunter' with your actual tool)
function rootkit_detection() {
  # Check if your rootkit detection tool is installed
  if ! command -v rootkit_hunter &> /dev/null; then
    echo "Error: Rootkit detection tool (rootkit_hunter) is not installed. Replace 'rootkit_hunter' with your tool."
    return 1
  fi

  # Run your rootkit detection tool
  sudo rootkit_hunter
}

# Function to scan a file for malware using VirusTotal
function scan_file() {
  echo "Enter the path to the file: "
  read file_path

  # Check if curl is installed (needed for VirusTotal API access)
  if ! command -v curl &> /dev/null; then
    echo "Error: curl is not installed."
    return 1
  fi

  # ... rest of the scan_file function remains the same (get file hash, API URL, etc.)
}

# Main loop with a flag to track memory forensics mode
in_memory_forensics=false

while true; do
  display_menu
  read -r choice

  case $choice in
    1)
      memory_forensics
      ;;
    2)
      rootkit_detection
      ;;
    3)
      scan_file
      ;;
    4)
      echo "Exiting..."
      exit 0
      ;;
    *)
      if [[ "$in_memory_forensics" ]]; then
        echo "Invalid command. Enter Volatility commands or 'q' to quit memory forensics."
        continue  # Stay in memory forensics loop for further commands
      else
        echo "Invalid choice."
      fi
      ;;
  esac
done

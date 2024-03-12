#!/bin/bash

echo "For complete installation enter your password:"

# For updating system packages
sudo apt-get update -y

# Install git if not already installed
if command -v git >/dev/null 2>&1; then
    echo "Git is installed, proceeding towards next installation."
else
    echo "Git is not installed, installing now..."
    sudo apt-get install git -y
fi

mkdir LegaLogics
# For cloning the Volatility repository
git clone https://github.com/volatilityfoundation/volatility.git

# To move into the volatality directory
cd volatility

# Granting executable permission to vol.py
chmod a+x vol.py

#For moving vol.py in command line directly without accessing the folder
sudo ln -s $(pwd)/vol.py /usr/bin/vol.py
export PATH=$PATH:/usr/bin

echo "For running vol.py you have to use python2"
echo "Do you want to install Python 2? Enter (y/n):"
read answer

# Check the user's answer
if [ "$answer" = "y" ]; then
    # If the user answered 'yes', install Python 2
    echo "Installing Python 2..."
    sudo apt-get install python2
    echo "Python 2 installation complete."
elif [ "$answer" = "n" ]; then
    # If the user answered 'no', do not install Python 2
    echo "You chose not to install Python 2."
else
    # If the user entered something other than 'yes' or 'no', print an error message
    echo "Invalid input. Please enter yes or no."
fi

cd ../
# Clone the vt-cli repository from GitHub
git clone https://github.com/VirusTotal/vt-cli.git
# Navigate to the cloned repository
cd vt-cli
# Build the project
go build
make install
# Print a success message
echo "vt-cli has been successfully installed."



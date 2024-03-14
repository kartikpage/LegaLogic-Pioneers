bash
#!/bin/bash

# Function to install NFS packages
install_nfs_packages() {
    echo "Installing NFS packages..."
    sudo apt-get install ufw
    sudo apt-get install nfs-kernel-server nfs-common -y
    echo "NFS packages installed."
}

# Function to configure NFS exports
configure_nfs_exports() {
    echo "Configuring NFS exports..."
    sudo mkdir -p /srv/nfs
    sudo chmod 777 /srv/nfs   # Adjust permissions as necessary
    
    # Example: Export /srv/nfs to all clients
    echo "/srv/nfs *(rw,sync,no_subtree_check)" | sudo tee -a /etc/exports
    
    # Apply changes
    sudo exportfs -ra
    echo "NFS exports configured."
}

# Function to start NFS service
start_nfs_service() {
    echo "Starting NFS service..."
    sudo systemctl start nfs-server
    sudo systemctl enable nfs-server
    echo "NFS service started."
}

# Function to stop NFS service
stop_nfs_service() {
    echo "Stopping NFS service..."
    sudo systemctl stop nfs-server
    echo "NFS service stopped."
}

# Function to add firewall rules for NFS
configure_firewall() {
    echo "Configuring firewall for NFS..."
    sudo ufw allow from 192.168.160.136/24 to any port nfs
    sudo ufw reload
    echo "Firewall configured for NFS."
}

# Main menu
echo "Welcome to NFS management script"
echo "1. Install NFS packages"
echo "2. Configure NFS exports"
echo "3. Start NFS service"
echo "4. Stop NFS service"
echo "5. Configure firewall for NFS"
echo "6. Exit"

read -p "Enter your choice: " choice

case $choice in
    1)
        install_nfs_packages
        ;;
    2)
        configure_nfs_exports
        ;;
    3)
        start_nfs_service
        ;;
    4)
        stop_nfs_service
        ;;
    5)
        configure_firewall
        ;;
    6)
        echo "Exiting script."
        exit 0
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

exit 0

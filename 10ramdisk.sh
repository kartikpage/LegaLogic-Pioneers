#!/bin/bash
# Configuration
ramdisk_size_mb=100  # Size of RAM disk in MB
ramdisk_mount_point="/mnt/ramdisk"  # Mount point for RAM disk
backup_directory="/home"  # Directory to backup RAM disk contents
# Function to create RAM disk
create_ramdisk() {
    sudo mkdir -p "$ramdisk_mount_point"
    sudo mount -t tmpfs -o size=${ramdisk_size_mb}M tmpfs "$ramdisk_mount_point"
    echo "RAM disk created at $ramdisk_mount_point"
}
# Function to backup RAM disk contents
backup_ramdisk() {
    sudo rsync -avh --delete "$ramdisk_mount_point/" "$backup_directory"
    echo "RAM disk contents backed up to $backup_directory"
}
# Function to restore RAM disk contents
restore_ramdisk() {
    sudo rsync -avh --delete "$backup_directory/" "$ramdisk_mount_point"
    echo "RAM disk contents restored from $backup_directory"
}
# Main script
case "$1" in
    create)
        create_ramdisk
        ;;
    backup)
        backup_ramdisk
        ;;
    restore)
        restore_ramdisk
        ;;
    *)
        echo "Usage: $0 {create|backup|restore}"
        exit 1
esac
exit 0

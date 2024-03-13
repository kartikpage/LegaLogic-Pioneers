#!/bin/bash
# Display the filesystem mounts on a Kali Linux system
# Display the contents of /etc/fstab
echo "Filesystem mounts in /etc/fstab:"
cat /etc/fstab
# Display the active mounts using systemd-mount
echo "Active mounts using systemd-mount:"
systemd-mount --list
# Display the active mounts using the mount command
echo "Active mounts using the mount command:"
mount | column -t

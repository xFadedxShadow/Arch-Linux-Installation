#!/usr/bin/env bash

echo "  ___           _         _____          _        _ _           "
echo " / _ \         | |       |_   _|        | |      | | |          "
echo "/ /_\ \_ __ ___| |__ ______| | _ __  ___| |_ __ _| | | ___ _ __ "
echo "|  _  | '__/ __| '_ \______| || '_ \/ __| __/ _' | | |/ _ \ '__|"
echo "| | | | | | (__| | | |    _| || | | \__ \ || (_| | | |  __/ |   "
echo "\_| |_/_|  \___|_| |_|    \___/_| |_|___/\__\__,_|_|_|\___|_|   "
echo "      by xFadedxShadow         Version: 0.0.1                   "
echo

read -p " [User Info] Please enter Hostname: " hostname
read -p " [User Info] Please enter Username: " username
read -p " [User Info] Please enter Password: " password
read -p " [User Info] Please Confirm your Password: " password_confirm
echo

if [ "$password" != "$password_confirm" ]; then
    echo
    echo " [User Error] Passwords do not match!"
    exit 1
fi

read -p " [Disk Utility] Would you like to wipe a disk.(y/N) " wipe

function diskWipe() {
    echo
    echo lsblk | grep "sd"
    echo
    read -p " [Disk Utility] Which disk would you like to wipe.(ex: sda, sdb) " disk
    if [ $(dd if=/dev/zero of=/dev/$disk bs=16M status=progress && sync) ]; then
        echo " [Disk Utility] Disk: $disk has been wiped!"
    else
        echo " [Disk Utility Error] Disk: $disk either does not exsist or couldn't be wiped!"
        diskWipe
    fi
}

if [ "$wipe" == "y" ] || [ "$wipe" == "Y" ]; then
    diskWipe
fi

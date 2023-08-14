#!/bin/bash
# This script is made to test the router using the web browser.
# Prompt for the router's internal IP
echo "Enter the router's internal IP:"
read router_internal_ip

# Open WhatIsMyIP website
firefox www.whatismyip.com

# Prompt for the public IP
echo "Enter the Public IP:"
read public_ip

# DNS test
echo "DNS test? y / n"
read dns_test
    if [ "$dns_test" == "y" ]; then
firefox https://browserleaks.com/ip
fi

# Public IP port tests
echo "Public IP port test? y / n"
read port_test
if [ "$port_test" == "y" ]; then
	firefox https://shodan.io/host/$public_ip
	firefox https://censys.io/ipv4/$public_ip
fi

# HNAP1 test
echo "HNAP1 test? y / n"
read hnap1_test
if [ "$hnap1_test" == "y" ]; then
	firefox http://$router_internal_ip/HNAP1/
	firefox http://$public_ip/HNAP1/
fi

# Multiple known ports test
echo "Multiple known ports test? y / n"
read ports_test
if [ "$ports_test" == "y" ]; then
	port_tests=("19541" "32764")  # Add more ports as needed
	for port in "${port_tests[@]}"; do
    	firefox http://$router_internal_ip:$port
    	firefox http://$public_ip:$port
	done
fi

# URL multiple paths test
echo "URL multiple paths test? y / n"
read paths_test
if [ "$paths_test" == "y" ]; then
	paths=("system/" "etc/" "etc/config/" "config/" "cgi/")  # Add more paths as needed
	for path in "${paths[@]}"; do
    	firefox http://$router_internal_ip/$path
	done
fi

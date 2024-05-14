#!/bin/bash

# Turn off default swap 
sudo swapoff /swapfile 

echo "Verify swap memory";

free -h 

# delete the existing swap file 
sudo rm /swapfile 

# create new swap file 
read -p 'New Swap Size (GB) : ' swap_size 
dd if=/dev/zero of=/swapfile bs=1M count=$(($swap_size*1024))

chmod 600 /swapfile

# enable new swap 
mkswap /swapfile
swapon /swapfile
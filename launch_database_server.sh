#!/bin/bash 

echo "==================="; 
echo "|  Your password  |";
echo "==================="

echo "command : sudo /opt/lamp/lamp start";
echo "";

sudo systemctl stop nginx
sudo systemctl stop apache2
sudo systemctl stop mysql

sudo /opt/lampp/lampp start

echo "----------------------"; 
echo "Database Server Launched"; 

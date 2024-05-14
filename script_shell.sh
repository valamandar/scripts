#!/bin/bash 

interface="enp0s3"
ip="172.16.0.20/23"
gateway="172.16.0.1"
dns="8.8.8.8,8.8.4.4"
methode="manual"

# Les commandes 
nmcli c modify $interface ipv4.adresses $ip 
nmcli c modify $interface ipv4.gateway $gateway 
nmcli c modify $interface ipv4.dns $dns
nmcli c modify $interface ipv4.methode $methode 
nmcli c down $interface 
nmcli c up $interface 

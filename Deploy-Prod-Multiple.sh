#!/usr/bin/env bash
#Deploy to all pinable Product Web Instance(s) Ubuntu .
# AWS subnet1 and 2 10.0.1.x 10.0.2.x
# GCP subnet 
# Azure subnet

echo "Generating a hosts.txt file collecting all pinable IP in one Prod subnet"

#Generate a hosts.txt file collecting all pinable IP in one Prod subnet
seq 254 | xargs -iIP -P255 ping -c1 10.0.1.IP |gawk -F'[ :]' '/time=/{print $4}'  >hosts.txt
seq 254 | xargs -iIP -P255 ping -c1 10.0.2.IP |gawk -F'[ :]' '/time=/{print $4}'  >>hosts.txt

echo "Run Deploy script file in a loop for all pinable instances"

#Run Deploy script file in a loop
for host in $(cat hosts.txt); do sudo ssh -i /home/ubuntu/.ssh/Jmy_Key_AWS_Apr_2018.pem ubuntu@$host "sh /home/ubuntu/Deploy_Prod.sh"; done  |true





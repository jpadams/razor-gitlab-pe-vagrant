#!/bin/bash
# This script will launch the razordemo vm and restart it in the middle when virtualbox error comes up
# WARNING:  This will destroy your existing razorclient vm (asks for confirmation)
# Feel free to adjust the timer if you notice it waiting around too long
# Remember to disable the DHCP server on your virtualbox host only network

WAIT_TIME=230

#If dhcp server exists, prompt to remove it.
if [[ $(vboxmanage list dhcpservers | grep 'HostInterfaceNetworking-vboxnet0') != "" ]]; then 
	#echo -e "\nVirtual Box DHCP Server exists on host only network, razor demo will probably not work correctly with this enabled, would you like me to remove it?"
	read -p "DHCP Server exists, razor demo will probably not work correctly in this state, would you like me to remove it? [y/n]" -n 1 -r
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		vboxmanage dhcpserver remove --netname HostInterfaceNetworking-vboxnet0
	fi
fi
vagrant destroy razorclient #&>/dev/null
echo -e "\n\nPreparing Razor demo environment..."
vagrant up razorclient &>/dev/null
sleep $WAIT_TIME
#  INSERT "preparation finished, press any key to provision your system with razor.
read -p "Razor demo ready, press [Enter] key to begin..."
vagrant halt razorclient &>/dev/null
sleep 1
vagrant up razorclient &>/dev/null
vagrant up razorclient &>/dev/null #First time causes an error for me so I have to do this twice.

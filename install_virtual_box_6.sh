#!/bin/bash

vbox="/usr/bin/virtualbox"
vbox_installed=$(which virtualbox)
if [ "$vbox == $vbox_installed" ]; then
        echo "Virtualbox already installed"
else 
	wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -

	echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian bionic contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list

	sudo apt-get update

	sudo apt-get install -y virtualbox-6.1	
fi


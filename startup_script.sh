#!/bin/bash
# Script for initial setup of programs
# It was tested (and made for) Ubuntu 18.02
# It is a basic script, so to run it just:
# `. startup_script.sh`
echo "Startup setup script"
echo "*****Updating system*****"
sudo apt-get update

echo "CURL:"
CUR=$(which curl)
if [ -z "$CUR" ]; then
	sudo apt install curl -y
else
	echo "curl is already installed"
fi

echo "WGET:"
WGT=$(which wget)
if [ -z "$WGT" ]; then
        sudo apt install wget -y
else
        echo "wget is already installed"
fi

echo "PIP:"
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py 
python get-pip.py --user
echo "PIP_HOME=/home/${USER}/.local/bin" >> ~/.bashrc
echo 'export PATH="$PIP_HOME:$PATH"' >> ~/.bashrc
. ~/.bashrc

echo "AWS CLI:"
pip install awscli --upgrade --user

echo "Terminator:"
sudo apt-get install terminator -y

echo "Git:"
sudo apt-get install git -y
echo "- setting git global variables"
git config --global user.name "marcorodnav"
git config --global user.email "marcorodnav@gmail.com"
git config --global core.editor "nano"
echo "- generating ssh keys for github"
ssh-keygen -t rsa -b 4096 -C "marcorodnav@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

echo "OpenJDK8:"
sudo apt-get install openjdk-8-jdk -y
echo "Set java home"
echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> ~/.bashrc
echo "export JAVA_HOME" >> ~/.bashrc
. ~/.bashrc

echo "Chrome:"
echo "1. Adding key"
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "2. Setting repository"
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
echo "Installation"
sudo apt-get update
sudo apt-get install google-chrome-stable -y

echo "VSCode:"
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install code -y

echo "Maven:"
sudo apt-get install maven -y

echo "Intellij"
sudo snap install intellij-idea-community --classic --edge

echo "Docker:"
sudo apt-get update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt-get update
sudo apt install docker-ce -y
sudo usermod -aG docker ${USER}
su - ${USER}

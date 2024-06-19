#!/bin/bash


# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color


# Step 1: Add Kali Linux repositories to the sources list
echo "${Green}[+]${NC} Adding Kali Linux repositories to the sources list..."
cat <<EOF | sudo tee /etc/apt/sources.list.d/kali.list
deb http://http.kali.org/kali kali-rolling main non-free contrib
EOF

# Step 2: Add the Kali Linux GPG key
echo "${Green}[+]${NC}Adding Kali Linux GPG key..."
wget -q -O - https://archive.kali.org/archive-key.asc | sudo apt-key add -

# Step 3: Set up APT preferences to prioritize Ubuntu repositories over Kali
echo "${Green}[+]${NC} Setting up APT preferences..."
cat <<EOF | sudo tee /etc/apt/preferences.d/kali.pref
Package: *
Pin: release o=Kali
Pin-Priority: 100

Package: *
Pin: release o=Ubuntu
Pin-Priority: 900
EOF

# Step 4: Update the package list
echo "${Green}[+]${NC} Updating the package list..."
sudo apt update

# Step 5: Install Go
echo "${Green}[+]${NC} Installing Go..."
wget https://go.dev/dl/go1.21.6.linux-amd64.tar.gz 
sudo tar -xvf go1.21.6.linux-amd64.tar.gz -C /usr/local 
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.profile 
source ~/.profile
go version 


# Step 7: Install Project Discovery Tool Manager (pdtm)
echo "${Green}[+]${NC} Installing Project Discovery Tool Manager (pdtm)..."
go install -v github.com/projectdiscovery/pdtm/cmd/pdtm@latest

# Add pdtm to PATH
echo "${Green}[+]${NC} Adding pdtm to PATH..."
cat <<EOF >> ~/.profile

# Set up Project Discovery Tool Manager
export PATH=\$PATH:\$HOME/.pdtm/bin
EOF

# Reload the profile to apply changes
source ~/.profile

# Install all pdtm
echo "${Green}[+]${NC} Installing all tools with PDTM"
pdtm -install-all
sudo apt install python3-pip

# Install GAU
echo "${Green}[+]${NC} Installing GAU"
go install github.com/lc/gau/v2/cmd/gau@latest

# Install crosslinked
echo "${Green}[+]${NC} Installing Crosslinked"
pip3 install crosslinked

# Install pip3 and aiodnsbrute and seclists
echo "${Green}[+]${NC} Installing pip3, aiodnsbrute and seclists"
sudo apt install python3-pip seclists
pip3 install aiodnsbrute

# Install pipx and bbot
echo "${Green}[+]${NC} Installing pipx and BBOT"
sudo apt install pipx
pipx ensure path
$SHELL


for i in {1..50}
do
    echo "-"
done
echo "${Green}[+]${NC} Setup complete, necessary tools have been added and setup. Remember to add bbot config file at: ~/.config/bbot/secrets.yml"
for i in {1..50}
do
    echo "-"
done
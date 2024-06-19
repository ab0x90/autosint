#!/bin/bash

# Step 1: Add Kali Linux repositories to the sources list
echo "Adding Kali Linux repositories to the sources list..."
cat <<EOF | sudo tee /etc/apt/sources.list.d/kali.list
deb http://http.kali.org/kali kali-rolling main non-free contrib
EOF

# Step 2: Add the Kali Linux GPG key
echo "Adding Kali Linux GPG key..."
wget -q -O - https://archive.kali.org/archive-key.asc | sudo apt-key add -

# Step 3: Set up APT preferences to prioritize Ubuntu repositories over Kali
echo "Setting up APT preferences..."
cat <<EOF | sudo tee /etc/apt/preferences.d/kali.pref
Package: *
Pin: release o=Kali
Pin-Priority: 100

Package: *
Pin: release o=Ubuntu
Pin-Priority: 900
EOF

# Step 4: Update the package list
echo "Updating the package list..."
sudo apt update

# Step 5: Install Go
echo "Installing Go..."
sudo apt install -y golang-go

# Step 6: Set up Go environment for the user
echo "Setting up Go environment..."
cat <<EOF >> ~/.profile

# Set up Go environment
export GOPATH=\$HOME/go
export PATH=\$PATH:/usr/lib/go-1.15/bin:\$GOPATH/bin
EOF

# Reload the profile to apply changes
source ~/.profile

echo "Kali repositories have been added, preferences set, package list updated, and Go installed and configured."
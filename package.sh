#!/bin/bash

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Check if the file exists
if [ ! -f "tools.txt" ]; then
    echo -e "${RED}Error: tools.txt not found!${NC}"
    exit 1
fi

# Update package lists
echo "Updating package lists..."
sudo apt-get update &> /dev/null

# Read the file and install packages
while read package; do
    if [ ! -z "$package" ]; then
        echo -e "Checking ${YELLOW}$package${NC}..."
        # Check if the package is available
        if apt-cache show "$package" &> /dev/null; then
            echo -e "Installing ${YELLOW}$package${NC}..."
            if sudo apt-get install -y "$package"; then
                # Double-check if the package is actually installed
                if dpkg -l | grep -q "^ii  $package "; then
                    echo -e "${GREEN}$package installed successfully${NC}"
                else
                    echo -e "${RED}Failed to install $package (not found after installation attempt)${NC}"
                fi
            else
                echo -e "${RED}Failed to install $package${NC}"
            fi
        else
            echo -e "${RED}Package $package not found in the repositories${NC}"
        fi
    fi
done < tools.txt

echo "Installation process completed."

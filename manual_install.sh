#!/bin/bash

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root."
   exit 1
fi

# Define the desired Node.js version
NODE_VERSION="14"  # Change to your desired Node.js version (e.g., "14")

# Verify if Node.js is already installed
if ! command -v node &>/dev/null; then
  echo "Node.js is not installed. Installing Node.js version $NODE_VERSION..."
  # Add NodeSource repository for the specified Node.js version
  curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/nodesource-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/nodesource-archive-keyring.gpg] https://deb.nodesource.com/node_$NODE_VERSION.x $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/nodesource.list
  # Update package list
  apt update
  # Install Node.js and npm
  apt install -y nodejs
else
  echo "Node.js is already installed."
fi

# Define the desired dbdocs version
DBDOCS_VERSION="0.8.1"  # Change to your desired dbdocs version

# Verify if dbdocs is already installed
if ! npm list -g dbdocs@$DBDOCS_VERSION --depth=0 &>/dev/null; then
  echo "dbdocs version $DBDOCS_VERSION is not installed. Installing..."
  # Install dbdocs globally
  npm install -g dbdocs@$DBDOCS_VERSION
else
  echo "dbdocs version $DBDOCS_VERSION is already installed."
fi

# Verify installations
NODEJS_VERSION=$(node -v)
NPM_VERSION=$(npm -v)
DBDOCS_INSTALLED_VERSION=$(dbdocs --version)

echo "Node.js version: $NODEJS_VERSION"
echo "npm version: $NPM_VERSION"
echo "dbdocs version: $DBDOCS_INSTALLED_VERSION"

echo "Node.js, npm, and dbdocs have been installed successfully."

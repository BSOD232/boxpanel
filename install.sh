#!/bin/bash

# Print message
echo "Downloading and setting up BoxPanel..."

# Define the repository URL
REPO_URL="https://github.com/BSOD232/boxpanel.git"
INSTALL_DIR="$HOME/boxpanel"

# Check if git is installed
if ! command -v git &> /dev/null
then
    echo "git not found. Installing git..."
    sudo apt-get update
    sudo apt-get install -y git
fi

# Clone the repository
if [ -d "$INSTALL_DIR" ]; then
    echo "BoxPanel directory already exists. Pulling latest changes..."
    cd "$INSTALL_DIR"
    git pull
else
    echo "Cloning the BoxPanel repository..."
    git clone "$REPO_URL" "$INSTALL_DIR"
    cd "$INSTALL_DIR"
fi

# Update package list and install Node.js and npm if not installed
if ! command -v node &> /dev/null
then
    echo "Node.js not found. Installing Node.js..."
    curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
    sudo apt-get install -y nodejs
fi

# Install PM2 globally if not installed
if ! command -v pm2 &> /dev/null
then
    echo "PM2 not found. Installing PM2..."
    sudo npm install -g pm2
fi

# Install project dependencies
echo "Installing project dependencies..."
npm install

# Start the application using PM2
echo "Starting the BoxPanel application with PM2..."
pm2 start server.js --name boxpanel

# Save the PM2 process list and corresponding environments
pm2 save

# Print completion message
echo "BoxPanel installation and setup complete!"
echo "Access the app at http://localhost:3000"

#!/bin/bash

# Verify if nginx is installed
which nginx > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "Nginx already installed."
else
    echo "Nginx is not present. I will installs it or die trying..."
    sudo apt update && sudo apt install -y nginx
    if [ $? -eq 0 ]; then
        echo "Nginx was installed sucessful."
    else
        echo "Mission failed. Nginx was not installed."
        exit 1
    fi
fi

# Verify if ninx is running
systemctl is-active --quiet nginx
if [ $? -eq 0 ]; then
    echo "Nginx is running."
else
    echo "Nginx is not running. I will starts now..."
    sudo systemctl start nginx
    if [ $? -eq 0 ]; then
        echo "Nginx started sucessful."
    else
        echo "Mission failed. Nginx was not started."
        exit 1
    fi
fi

exit 0

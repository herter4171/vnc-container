#!/bin/bash

# Prevent prompts from tzdata, etc
export DEBIAN_FRONTEND=noninteractive

# Update package lists
apt-get update -y

# Install desktop and VNC server
apt-get install -y \
    xfce4 \
    xfce4-goodies \
    tightvncserver

# Install convenience packages
apt-get install -y \
    vim \
    tmux \
    expect \
    sudo \
    firefox

# Clear package lists to reduce image size
apt-get clean

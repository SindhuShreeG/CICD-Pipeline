#!/bin/bash

# Update the package list
sudo apt update -y

# Install OpenJDK 8
sudo apt install openjdk-8-jdk -y

# Download Nexus OSS
sudo wget https://download.sonatype.com/nexus/3/nexus-3.42.0-01-unix.tar.gz

# Extract Nexus
sudo tar -xvf nexus-3.42.0-01-unix.tar.gz

# Move Nexus to /opt
sudo mv nexus-3.42.0-01 /opt/nexus

# Change permissions
sudo chown ubuntu:ubuntu /opt/nexus

# Set INSTALL4J_JAVA_HOME environment variable
sudo tee /etc/environment <<EOF
INSTALL4J_JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
EOF

# Reload environment variables
source /etc/environment

# Create sonatype-work directory
sudo mkdir -p /opt/sonatype-work

# Set ownership to ubuntu user
sudo chown -R ubuntu:ubuntu /opt/sonatype-work

# Create a systemd service file
sudo tee /etc/systemd/system/nexus.service <<EOF
[Unit]
Description=Nexus Service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
User=ubuntu
Environment=INSTALL4J_JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd daemon
sudo systemctl daemon-reload

# User Settings for Ubuntu
sudo echo 'run_as_user="ubuntu"' > /opt/nexus/bin/nexus.rc

# Start and enable Nexus service
sudo systemctl start nexus
sudo systemctl enable nexus

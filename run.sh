#!/bin/bash

# Check if enough arguments are passed
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 IP_ADDRESS PORT PROFILE_NAME"
    exit 1
fi

IP_ADDRESS=$1
PORT=$2
PROFILE_NAME=$3

# Determine the directory containing this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Update system packages
echo "Updating system packages..."
sudo apt-get update && sudo apt-get upgrade -y

# Install Docker if it's not already installed
if [ -z $(which docker) ]; then
    echo "Installing Docker..."
    sudo apt-get install -y docker.io
fi

# Install Docker Compose if it's not already installed
if [ -z $(which docker-compose) ]; then
    echo "Installing Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

# Prepare OpenVPN configuration and data
echo "Setting up OpenVPN server..."
cat <<EOF > "$SCRIPT_DIR/docker-compose.yml"
version: '3'
services:
  openvpn:
    image: kylemanna/openvpn
    container_name: openvpn_server
    ports:
      - "$PORT:1194/udp"
    restart: always
    volumes:
      - "$SCRIPT_DIR:/etc/openvpn"
    cap_add:
      - NET_ADMIN
EOF

# Initialize the configuration files and certificates
cd "$SCRIPT_DIR"
sudo docker-compose run --rm openvpn ovpn_genconfig -u udp://$IP_ADDRESS:$PORT
sudo docker-compose run --rm openvpn ovpn_initpki

# Start the OpenVPN server
sudo docker-compose up -d

# Generate a client profile
sudo docker-compose run --rm openvpn easyrsa build-client-full $PROFILE_NAME nopass
sudo docker-compose run --rm openvpn ovpn_getclient $PROFILE_NAME > "$PROFILE_NAME.ovpn"

# Ensure the Docker and Docker Compose services start on boot
sudo systemctl enable docker
echo "Docker service enabled to start on boot."

# Setup Docker Compose service to start on boot
echo "Setting up Docker Compose to auto-start OpenVPN server..."
COMPOSE_SERVICE_NAME="openvpn"
cat <<EOF | sudo tee /etc/systemd/system/${COMPOSE_SERVICE_NAME}.service
[Unit]
Description=Docker Compose OpenVPN Service
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=${SCRIPT_DIR}
ExecStart=/usr/local/bin/docker-compose up -d
ExecStop=/usr/local/bin/docker-compose down
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
EOF

# Enable and start the service
sudo systemctl enable ${COMPOSE_SERVICE_NAME}.service
sudo systemctl start ${COMPOSE_SERVICE_NAME}.service

echo "OpenVPN server setup is complete. Your client profile is located at ${SCRIPT_DIR}/${PROFILE_NAME}.ovpn"

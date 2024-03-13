#!/bin/bash

# Check if enough arguments are passed
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 PROFILE_NAME"
    exit 1
fi

PROFILE_NAME=$1

# Determine the directory containing the Docker Compose file
# This assumes that the Docker Compose setup is in the same directory as this script.
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Navigate to the script directory (where your Docker Compose setup is located)
cd "$SCRIPT_DIR"

# Generate a new client profile
echo "Creating OpenVPN profile for $PROFILE_NAME..."
sudo docker-compose run --rm openvpn easyrsa build-client-full $PROFILE_NAME nopass
sudo docker-compose run --rm openvpn ovpn_getclient $PROFILE_NAME > "${PROFILE_NAME}.ovpn"

echo "New OpenVPN profile created: ${SCRIPT_DIR}/${PROFILE_NAME}.ovpn"

[![GitHub stars](https://img.shields.io/github/stars/sazidnur/ovpn_script?style=social&label=Stars)](https://github.com/sazidnur/ovpn_script/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/sazidnur/ovpn_script?style=social&label=Forks)](https://github.com/sazidnur/ovpn_script/network/members)
[![GitHub issues](https://img.shields.io/github/issues/sazidnur/ovpn_script.svg)](https://github.com/sazidnur/ovpn_script/issues)
[![GitHub pull requests](https://img.shields.io/github/issues-pr/sazidnur/ovpn_script.svg)](https://github.com/sazidnur/ovpn_script/pulls)
[![GitHub license](https://img.shields.io/github/license/sazidnur/ovpn_script)](https://github.com/sazidnur/ovpn_script/blob/main/LICENSE)
[![Visitor Count](https://visitor-badge.laobi.icu/badge?page_id=sazidnur.ovpn_script)](https://github.com/sazidnur/ovpn_script)



# OpenVpn Automatic Setup Script with Docker

Copy the script to your server, change the chmod to +x for the script, then run the run.sh script with arguments such as your public IP (in the case of a VPN, we generally use the public IP, but you can provide a local IP if you want it for a local network), port, and profile name. It will automatically set up a VPN server with Docker, and it will also generate a .ovpn file in the same folder where the script is located. This script will enable automatic activation whenever you start or restart the server.

## Commands:

```sudo apt-get install nano```

```nano run.sc```

```sudo chmod +x run.sh```

```./run.sh 111.222.333.444 1194 ProfileName```

Provide all the necessary information when running the script. After a successful run, check the same folder where the script is located. You will find a file named ProfileName.ovpn. Copy this file via email, QR code, or file server software like WinSCP or FileZilla to your machine where you intend to use this VPN. Install the OpenVPN Client software, open your .ovpn file, and connect. Congratulations, you have just set up your own VPN.

## Possible Troubleshooting Steps:

- Check the Docker status on your server by using the command ```docker ps```
- If your Docker is not running, check the Docker logs or review the docker-compose file to ensure the location of the configuration file matches between the server and docker-compose.
- Check your server's firewall for open ports and other configurations.

## Use in multiple device simultaneously

To use the VPN on multiple devices simultaneously, I would recommend creating separate profiles; otherwise, you may experience disconnects and automatic reconnections. To add another profile, use the add_new.sh script. The process is the same: create a new script, change its permissions with chmod, run it, and provide the profile name as an argument while running.

## Commands

```nano add_new.sh```

```sudo chmod +x add_new.sh```

```./add_new.sh ProfileName2```

Now copy your new PofileName2.ovpn file to desired device and use it by OpenVPN Client

[![GitHub stars](https://img.shields.io/github/stars/sazidnur/ovpn_script?style=social&label=Stars)](https://github.com/sazidnur/ovpn_script/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/sazidnur/ovpn_script?style=social&label=Forks)](https://github.com/sazidnur/ovpn_script/network/members)
[![GitHub issues](https://img.shields.io/github/issues/sazidnur/ovpn_script.svg)](https://github.com/sazidnur/ovpn_script/issues)
[![GitHub pull requests](https://img.shields.io/github/issues-pr/sazidnur/ovpn_script.svg)](https://github.com/sazidnur/ovpn_script/pulls)
[![GitHub license](https://img.shields.io/github/license/sazidnur/ovpn_script)](https://github.com/sazidnur/ovpn_script/blob/main/LICENSE)
[![Visitor Count](https://visitor-badge.laobi.icu/badge?page_id=sazidnur.ovpn_script)](https://github.com/sazidnur/ovpn_script)



# OpenVpn Automatic Setup Script with Docker

Copy the script to your sevrer, change chmod to +x to script, run the script with arguments like your public IP (generally in VPN case we use public IP, you can provide local IP if you want for local net), port, profile name. It will setup automatcially a VPN server with docker, also it will provide a .ovpn file in the same folder where the script is located. This script will add automatic turn on whenever you start server or restart. 

## Commands:

```sudo apt-get install nano```

```nano run.sc```

```sudo chmod +x run.sh```

```./run.sh 111.222.333.444 1194 ProfileName```

Provide all the necessary information while running the script. After successful run, check the same folder where the script is located. You will find a file anmes ProfileName.ovpn, copy this file to your machine where you want to use this vpn by email, qr code or filserver software like WinSCP, FileZilla. Install OpenVPN Client software, open you .ovpn file and connect. Hurray you just setup your own VPN.

Possible Troubleshoot:
Check docker status on your server by ```docker ps```
If your docker is not running check docker log or check docker-compose file for re-ensuring the location of the conf file macth in server and docker-compose
Check you server firewall for open port and other configs.

## Use in multiple device simultaneously

To use in multiple device simultaneousl, I would prefer separate profile, otherwise you can face disconnet and auto re-connect issue. To add another profile use add_new.sh script. Tt's same process, create new script, change chmod, run it and send profile name as argument while running.

## Commands

```nano add_new.sh```

```sudo chmod +x add_new.sh```

```./add_new.sh ProfileName2```

Now copy your new PofileName2.ovpn file to desired device and use it by OpenVPN Client

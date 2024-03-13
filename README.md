
# OpenVpn Automatic Setup Script with Docker

Copy the script to your sevrer, change chmod to +x to script, run the script with arguments, it will setup automatcially a vpn server with docker, it will provide a .ovpn file in the same folder where the script is located and it will add schedule turn on whenever you start server or restart. 

## Commands:

```sudo apt-get install nano```

```nano run.sc```

```sudo chmod +x run.sh```

```./run.sh 111.222.333.444 8000 ProfileName```

Provide all the necessary information while running the script. After successful run, check the same folder where the script is located. You will find a file anmes ProfileName.ovpn, copy this file to your machine where you want to use this vpn by email, qr code or filserver software like WinSCP, FileZilla. Install OpenVPN Client software, open you .ovpn file and connect. Hurray you just setup your own VPN.

Possible Troubleshoot:
Check docker status on your server by ```docker ps```
If your docker is not running check docker log or check docker-compose file for re-ensuring the location of the conf file macth in server and docker-compose
Check you server firewall. 
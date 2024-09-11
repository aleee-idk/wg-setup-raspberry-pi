#!/usr/bin/env bash

config_path="/etc/wireguard/wg0.conf"

if [ "$EUID" -ne 0 ]
  	then echo "Please run as root"
  	exit
fi

if ! command -v wg &> /dev/null
then
	apt install -y wireguard
fi

# Download config file
curl -Ls https://raw.githubusercontent.com/aleee-idk/wg-setup-raspberry-pi/main/wg0.conf.tmpl -o $config_path

read -p "Enter this client IP: " -r ip
read -p "Enter this client private key: " -r priv_key
read -p "Enter server public key: " -r server_key
read -p "Enter server host \"host.domain:port\": " -r server_host

sed -i "s|<client-ip>|$ip|g" $config_path
sed -i "s/<client-priv-key>/$priv_key/g" $config_path
sed -i "s/<server-public-key>/$server_key/g" $config_path
sed -i "s/<server-endpoint>/$server_host/g" $config_path

echo -e "\n---\n"

cat $config_path

echo -e "\n---\n"

read -p "Is this configuration correct? [y/N] " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]] then
	echo "Cancelling..."
	exit 1
fi

systemctl enable --now wg-quick@wg0

echo "the system will reboot in 5 seconds..."

sleep 5

reboot


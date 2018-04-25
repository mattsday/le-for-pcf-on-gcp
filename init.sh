#!/bin/sh
apt-get update
apt-get -y dist-upgrade

apt-get -y install git python python-pip build-essential libffi-dev libssl-dev

git clone https://github.com/certbot/certbot
cd certbot
python setup.py install
cd certbot-dns-cloudflare
python setup.py install
cd ../certbot-dns-google
python setup.py install
certbot plugins


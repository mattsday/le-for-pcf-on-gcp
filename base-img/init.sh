#!/bin/bash
apt-get update
apt-get -y dist-upgrade

apt-get -y install git python python-pip build-essential libffi-dev libssl-dev wget jq uuid

git clone https://github.com/certbot/certbot
cd certbot
python setup.py install
cd certbot-dns-cloudflare
python setup.py install
cd ../certbot-dns-google
python setup.py install
certbot plugins

cd /

wget "https://github.com/pivotal-cf/om/releases/download/0.36.0/om-linux" -O /usr/local/bin/om
chmod +x /usr/local/bin/om

wget "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-200.0.0-linux-x86_64.tar.gz" -O cloud-sdk.tar.gz
tar zxvf cloud-sdk.tar.gz
cd google-cloud-sdk
./install.sh --usage-reporting false -q
echo 'export PATH=$PATH:/google-cloud-sdk/bin' >> ~/.bashrc
. ~/.bashrc
cd /

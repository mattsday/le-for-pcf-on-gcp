#!/bin/bash

if [ -z "${GCP_CREDENTIALS}" ]; then echo No GCP_CREDENTIALS; exit 1; fi
if [ -z "${CF_DOMAINS}" ]; then echo No CF_DOMAINS; exit 1; fi
if [ -z "${LE_SERVER}" ]; then export LE_SERVER="https://acme-v02.api.letsencrypt.org/directory"; exit 1; fi
if [ -z "${GCP_CREDENTIALS_FILE}" ]; then export GCP_CREDENTIALS_FILE="/accounts.json"; fi

echo ${GCP_CREDENTIALS} | tee ${GCP_CREDENTIALS_FILE}

certbot certonly -n --agree-tos \
  --dns-google --dns-google-credentials ${GCP_CREDENTIALS_FILE} \
  -d ${CF_DOMAINS} \
  --server ${LE_SERVER} \
  --cert-path / \
  --cert-name le

if [ ! -f "/etc/letsencrypt/live/sys.lab01.pcf.pw/fullchain.pem" ] || \
  [ ! -f "/etc/letsencrypt/live/sys.lab01.pcf.pw/privkey.pem" ]; then
	echo No certificate generated see logs
	exit 1
fi

echo Full Chain
cat /etc/letsencrypt/live/le/fullchain.pem

echo Private Key
cat /etc/letsencrypt/live/le/privkey.pem


#!/bin/bash

if [ -z "${GCP_CREDENTIALS}" ]; then echo No GCP_CREDENTIALS; exit 1; fi
if [ -z "${GCP_CREDENTIALS_FILE}" ]; then export GCP_CREDENTIALS_FILE="/accounts.json"; fi
if [ -z "${GCP_HTTPS_PROXY}" ]; then echo No GCP_HTTPS_PROXY; exit 1; fi
if [ -z "${CERT_RENEW_BEFORE}" ]; then echo Setting cert renewall to 7 days; CERT_RENEW_BEFORE=604800; fi

echo ${GCP_CREDENTIALS} | tee ${GCP_CREDENTIALS_FILE} >/dev/null
export PATH="$PATH:/google-cloud-sdk/bin"

# Get current certificate name

CERT_NAME=$(gcloud compute target-https-proxies describe ${GCP_HTTPS_PROXY} --format=json | jq '.sslCertificates[0]' | xargs basename)

if [ -z ${CERT_NAME} ]; then
	echo Cannot find certificate in GCP
	exit 1
fi

CERT=$(gcloud compute ssl-certificates describe ${CERT_NAME} --format='get(certificate)')

echo Expiry date:
echo "$CERT" | openssl x509 -enddate -noout | awk -F= '{print $2}'

echo "$CERT" | openssl x509 -checkend ${CERT_RENEW_BEFORE} -noout
if [ $? = 1 ]; then
	echo Certificate due to expire - continue pipeline
	# Continue pipeline
else
	echo Certificate not due to expire
fi

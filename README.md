# Letsencrypt for PCF on GCP
This is the source code for a Docker image that does the following:

1. Requests a new certificate from Letsencrypt
2. Applies it to the GCP load balancer
3. Configures the following tiles with the new certificate:
	* PAS (aka Elastic Runtime)
	* PKS
	* Harbor

### Input Variables needed
* `GCP_CREDENTIALS` - GCP credentials in JSON, you should request a service account with DNS Admin credentials
* `CF_DOMAINS` - comma separated list of PCF domains, e.g. `*.sys.example.com,*.login.sys.example.com,*.cfapps.example.com`
* `LE_EMAIL` - email address to issue the certificates to
* `PCF_OPSMGR` - URL for opsmanager in the format `https://opsman.xxx.yyy`
* `PCF_PASSWD` - ops manager password
* `GCP_HTTPS_PROXY` - GCP Proxy to update - run `gcloud compute target-https-proxies list` to get this information

#### Optional input variables
* `PCF_USER` - ops manager username - defaults to `admin`
* `OPSMAN_CERT_NAME` - name of certificate in ops manager - defaults to `Certificate`
* `LE_SERVER` - Lets Encrypt server (optional) - will default to `https://acme-v02.api.letsencrypt.org/directory`
* `GCP_CREDENTIALS_FILE` - name of the file to store credentials, defaults to `/accounts.json`
* `GCP_CERT_NAME` - new name of certificate file in GCP - defaults to an auto generated UUID
* `GCP_DNS_WAIT` - how long to wait for DNS to propogate - defaults to 120 seconds

## Docker Hub
You can download it on Docker Hub too as `mattsday/le-pcf-on-gcp`

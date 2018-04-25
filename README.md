# Lets Encrypt updater for PCF
Basic Docker image that requests a certificate from Letsencrypt.

### Input Variables needed

* `GCP_CREDENTIALS` - GCP credentials in JSON, you should request a service account with DNS Admin credentials
* `CF_DOMAINS` - comma separated list of PCF domains, e.g. `*.sys.example.com,*.login.sys.example.com,*.cfapps.example.com`
* `LE_SERVER` - Lets Encrypt server (optional) - will default to `https://acme-v02.api.letsencrypt.org/directory`

### Output
Full chain in `/fullchain.pem`
Private key in `/privkey.pem`


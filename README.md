# rancher-hetzner-lb
Create Hetzner Cloud hosts which manage a floating ip between them using pacemaker

ENVIRONMENT_NAME=http://rancher-metadata/2015-07-25/self/stack/environment_name
ENVIRONMENT_ID=https://rancher.ipunkt.cloud/v1/projects?name=${ENVIRONMENT_NAME}&limit=1 | jq '.data[0].id'
https://rancher.ipunkt.cloud/v2-beta/projects/${ENVIRONMENT_ID}/registrationtokens?state=active&limit=-1&sort=name

#!/bin/bash

if [ -z "${HCLOUD_TOKEN}" ] ; then
	echo "No Hetzner Cloud Token was specified. Exiting."
	echo "Please set the environment variable HCLOUD_TOKEN to your cloud token"
	exit 1
fi

if [ -z "${CATTLE_URL}" ] ; then
	echo "No Cattle URL was specified. Exiting."
	echo "Please set the environment variable CATTLE_URL to your rancher api url"
	echo ""
	echo "Note that Rancher sets this variable for you if you specify the following labels"
	echo "io.rancher.container.create_agent=true"
	echo "io.rancher.container.agent.role=environmentAdmin,agent"
	exit 1
fi

start() {

	cd /opt/playbook
	ansible-playbook -i library/hcloud_inventory "${SERVERS}" install.yml
}

init() {
	SERVERS="${SERVERS:-lb01:lb02}"

	FLOATING_IP="${FLOATING_IP:-loadbalancer}"

	SSH_KEY_NAME="${SSH_KEY_NAME:-loadbalancer_key}"
	SSH_KEY_PATH="${SSH_KEY_PATH:-./id_rsa}"
	CLUSTER_INI="${CLUSTER_INI:-./cluster.ini}"

	confd -onetime -backend env
}

init

COMMAND=${1}
case ${COMMAND} in
	wait)
		echo "Debug entrypoint 'wait': sleeping for 3600s, use this time to exec into the container"
		sleep 3600s
		;;
	*)
		start
		;;
esac
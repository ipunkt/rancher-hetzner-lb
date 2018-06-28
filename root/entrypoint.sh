#!/bin/bash

if [ -z "${HCLOUD_TOKEN}" ] ; then
	echo "No Hetzner Cloud Token was specified. Exiting."
	echo "Please set the environment variable HCLOUD_TOKEN to your cloud token"
	exit 1
fi

if [ -z "${PUBLIC_KEY}" ] ; then
	echo "No public key set. Exiting"
	echo "Please set the environment variable PUBLIC_KEY to the public key with which the servers will be created"
	exit 1
fi

start() {

	cd /opt/playbook
	ansible-playbook infrastructure.yml
	ansible-playbook -i hcloud_inventory "${SERVERS}" cluster.yml
}

init() {
	SERVERS=${SERVERS:-lb01:lb02}

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

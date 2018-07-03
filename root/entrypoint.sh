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

if [ -z "${CATTLE_AGENT_INSTANCE_ENVIRONMENT_ADMIN_AUTH}" ] ; then
	echo "This is usually set by rancher when setting the following labels for an infrastructure service:"
	echo "io.rancher.container.create_agent=true"
	echo "io.rancher.container.agent.role=environmentAdmin,agent"
	echo ""
	echo "If you want to run this script from outside Rancher it is also possible to set this to"
	echo "'Basic base64(RANCHER_ACCESS_KEY:RANCHER_SECRET_KEY)'"
	echo "using an account level api key."
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

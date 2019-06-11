# rancher-hetzner-lb
Create Hetzner Cloud hosts which manage a floating ip between them using pacemaker

This image is intended for use through the ipunkt rancher catalog: https://github.com/ipunkt/catalog

## Environment Variables

| Variable    | Default      | Explanation     |
| ----------- |--------------| --------------- |
| HCLOUD\_TOKEN     | -      | The token used to create the hosts and later manage the floating ip and fencing the nodes. |
| SERVERS     | lb01:lb02    | Colon(:) separated list of host(name)s to creates |
| SERVER\_SIZE| cx11         | Hetzner server type to create |
| FLOATING_IP | loadbalancer | The description used set for the floating ip address and used to identified on subsequent runs |
| SSH_KEY_NAME| loadbalancer_key | The name by which the generated public ssh key is saved to the hetzner cloud api |
| SSH_KEY_PATH| ./id_rsa     | Path to the ssh private key. Set this to be on a persistent volume unless you use the {PRIVATE,PUBLIC}\_KEY variables |
| SSH_EXTRA_PUBKEYS | -     | Extra ssh public keys to add to the servers root auhorized_keys file |
| CLUSTER\_INI  | ./cluster.ini | Place to save the cluster.ini to. Set this to be on a persistent volume or set CLUSTER\_USER\_PASSWORD|
| CLUSTER\_TIMEOUT  | 10000 | Corosync token timeout. How long the cluster waits before it throws out a node when not receiving anything from it. |
| PRIVATE\_KEY  | -          | Use this private ssh key instead of generating one. Only effective in conjunction with PUBLIC\_KEY |
| CLUSTER_USER_PASSWORD | -           | Password to the `hacluster` user used by pacemaker to link the cluster. Leave empty to generate a password which is then saved in the CLUSTER\_INI |
| PUBLIC\_KEY  | -           | Use this public ssh key instead of generating one. Only effective in conjunction with PRIVATE\_KEY |
| HOST\_LABELS  | lb=true    | Host labels to be set on the rancher entries of the new servers. Only effective when first registered. Change within rancher afterwards |

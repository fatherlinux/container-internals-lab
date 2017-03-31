#!/bin/bash

ocp_servers="master1 master2 master2 node1 node2 node3"
all_servers="$ocp_servers storage1 haproxy1"
domain="ocp1.dc2.crunchtools.com"
ssh_options="-oStrictHostKeyChecking=no -i ./root@ocp1.dc2.crunchtools.com"

for server in $servers
do
    ssh $ssh_options root@${server}.${domain} hostname
done

case $1 in
test)
    for server in $all_servers
    do
        ssh $ssh_options root@${server}.${domain} hostname
    done
  ;;
prep)
    for server in $ocp_servers
    do
        ssh $ssh_options root@${server}.${domain} docker pull rhel7
        ssh $ssh_options root@${server}.${domain} docker pull rhel7/rhel-tools
        ssh $ssh_options root@${server}.${domain} docker pull nate/dockviz
    done
  ;;
export)
  ;;
*)
  echo "Usage: container-processes {test|prep|export}"
  ;;
esac


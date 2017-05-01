#!/bin/bash

master_servers="ose3-master"
node_servers="ose3-node1 ose3-node2"
all_servers="$master_servers $node_servers"
domain="example.com"
ssh_options="-oStrictHostKeyChecking=no"

case $1 in
keys)
    ssh-keygen
    for server in $all_servers
    do
        ssh-copy-id root@${server}.${domain}
    done
  ;;
test)
    for server in $all_servers
    do
        ssh $ssh_options root@${server}.${domain} hostname
    done
  ;;
prep)
    for server in $master_servers
    do
        ssh $ssh_options root@${server}.${domain} docker pull rhel7/rhel-tools
        ssh $ssh_options root@${server}.${domain} docker pull registry.access.redhat.com/jboss-eap-7/eap70-openshift
    done

    for server in $all_servers
    do
        ssh $ssh_options root@${server}.${domain} docker pull registry.access.redhat.com/rhel7/rhel:latest
        ssh $ssh_options root@${server}.${domain} docker pull rhel7
        ssh $ssh_options root@${server}.${domain} docker pull registry.access.redhat.com/rhel7/rhel-atomic:latest
        ssh $ssh_options root@${server}.${domain} docker pull rhel7-atomic
        ssh $ssh_options root@${server}.${domain} docker pull nate/dockviz
        ssh $ssh_options root@${server}.${domain} docker pull openshift3/ose-haproxy-router
        ssh $ssh_options root@${server}.${domain} docker pull openshift3/ose-docker-registry
        ssh $ssh_options root@${server}.${domain} docker pull openshift3/registry-console
        ssh $ssh_options root@${server}.${domain} docker pull openshift3/mysql-55-rhel7
    done
  ;;
export)
    input_directory="/dev/RHEL7CSB"
    output_directory="/srv/data/tmp/container-internals-lab"

    for server in $all_servers
    do
        virsh dumpxml ${server}.${domain} > ${output_directory}/L103118-${server}.${domain}.xml
        sed -e '/<uuid>.*<\/uuid>$/d' -i ${output_directory}/L103118-${server}.${domain}.xml
        sed -e "s#${input_directory}/${server}.${domain}#${output_directory}/${server}.${domain}.raw#" -i ${output_directory}/L103118-${server}.${domain}.xml
        sed -e "s#${server}.${domain}#L103118-${server}.${domain}#" -i ${output_directory}/L103118-${server}.${domain}.xml
    done

    for server in $all_servers
    do
        if [ ! -f ${output_directory}/L103118-${server}.${domain}.raw ] && [ ! -f ${output_directory}/L103118-${server}.${domain}.xz ]
        then
            dd if=${input_directory}/${server}.${domain} of=${output_directory}/L103118-${server}.${domain}.raw
	    # echo "dd if=${input_directory}/${server}.${domain} of=${output_directory}/L103118-${server}.${domain}.raw"
        fi

        if [ -f ${output_directory}/L103118-${server}.${domain}.raw ]
        then
            xz --verbose ${output_directory}/L103118-${server}.${domain}.raw
        fi
    done
  ;;
command)
    for server in $all_servers
    do
        ssh $ssh_options root@${server}.${domain} $2
    done
  ;;
*)
  echo "Usage: container-processes {test|prep|export|command}"
  ;;
esac


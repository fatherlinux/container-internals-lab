#!/bin/bash

ocp_servers="master1 master2 master3 node1 node2 node3"
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
        ssh $ssh_options root@${server}.${domain} docker pull openshift3/ose-haproxy-router
        ssh $ssh_options root@${server}.${domain} docker pull openshift3/ose-docker-registry
        ssh $ssh_options root@${server}.${domain} docker pull openshift3/registry-console
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


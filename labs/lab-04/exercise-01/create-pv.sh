#!/bin/bash

nfs_host=storage1.ocp1.dc2.crunchtools.com
dir=/exports/data/

for i in pv0001 pv0002 pv0003 pv0004
do
	ssh -q -oStrictHostKeyChecking=no root@$nfs_host mkdir -p "$dir/$i && \
	               chmod 777 -R $dir && \
	               chown nfsnobody.nfsnobody -R $dir && \
	               chcon -Rt default_t $dir"
done
ssh -oStrictHostKeyChecking=no -q root@$nfs_host 'echo "/exports/data *(rw,root_squash)" > /etc/exports.d/pv.exports'
ssh -oStrictHostKeyChecking=no -q root@$nfs_host "systemctl restart nfs"
ssh -oStrictHostKeyChecking=no -q root@$nfs_host "ls -alhZ $dir/"

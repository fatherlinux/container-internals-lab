

# Setup Network
Configure all IP addresses statically to make things consistent when running the lab. Use hosts file to make sure all nodes can communicate.

```
/etc/sysconfig/network-scripts/ifcfg-eth0
BOOTPROTO=static
IPADDR=192.168.122.200
ONBOOT=yes
DNS1=192.168.122.1
-UUID
```

```
/etc/sysconfig/network
HOSTNAME=master1.ocp1.dc2.crunchtools.com
GATEWAY=192.168.122.1
NETWORKING=YES
```

```
hostnamectl set-hostname master1.ocp1.dc2.crunchtools.com
```

```
/etc/hosts
192.168.122.200	master1.ocp1.dc2.crunchtools.com
192.168.122.201	master2.ocp1.dc2.crunchtools.com
192.168.122.202	master3.ocp1.dc2.crunchtools.com
192.168.122.203	node1.ocp1.dc2.crunchtools.com
192.168.122.204	node2.ocp1.dc2.crunchtools.com
192.168.122.205	node3.ocp1.dc2.crunchtools.com
192.168.122.206	haproxy1.ocp1.dc2.crunchtools.com
192.168.122.207	storage1.ocp1.dc2.crunchtools.com
```


# Storage Volume
The nice part about Atomic Host is that it sets the docker storage up for you ahead of time. All you have to do is extend it to make things easy to run.

```
lvextend -l +100%FREE /dev/mapper/rhelah-docker--pool
```

# ssh keys
On an external RHEL box, prepare for install. First, add the above hosts file.

```
ssh-keygen -f /root/.ssh/root@osp1.dc2.crunchtools.com
ssh-copy-id -i /root/.ssh/root@osp1.dc2.crunchtools.com.pub root@master1.ocp1.dc2.crunchtools.com
ssh-copy-id -i /root/.ssh/root@osp1.dc2.crunchtools.com.pub root@master2.ocp1.dc2.crunchtools.com
ssh-copy-id -i /root/.ssh/root@osp1.dc2.crunchtools.com.pub root@master3.ocp1.dc2.crunchtools.com
ssh-copy-id -i /root/.ssh/root@osp1.dc2.crunchtools.com.pub root@node1.ocp1.dc2.crunchtools.com
ssh-copy-id -i /root/.ssh/root@osp1.dc2.crunchtools.com.pub root@node2.ocp1.dc2.crunchtools.com
ssh-copy-id -i /root/.ssh/root@osp1.dc2.crunchtools.com.pub root@node3.ocp1.dc2.crunchtools.com
ssh-copy-id -i /root/.ssh/root@osp1.dc2.crunchtools.com.pub root@haproxy1.ocp1.dc2.crunchtools.com
ssh-copy-id -i /root/.ssh/root@osp1.dc2.crunchtools.com.pub root@storage1.ocp1.dc2.crunchtools.com
```

# subscription manager
```
subscription-manager register
```


# openshift
Prepare subscription manager entitlements for openshift
```
subscription-manager attach --pool=8a85f9815404b7da0154071f610f73db
subscription-manager repos --disable="*"
subscription-manager repos --enable=rhel-7-server-rpms --enable=rhel-7-server-extras-rpms --enable=rhel-7-server-optional-rpms --enable=rhel-7-server-supplementary-rpms --enable=rhel-7-server-rh-common-rpms --enable="rhel-7-server-ose-3.4-rpms"
```

Run the installer
```
atomic-openshift-installer
```
# lessons learned
1. Running a 3 master, 3 node OpenShift environment requires an external haproxy and storage node for the registry
2. The storage node must be RHEL
3. The haproxy node for the masters must be on RHEL. Could not find that information in the docs
4. hostnamectl overwrites /etc/resolve.conf configuration (not sure why)

# Atomic Tools Container

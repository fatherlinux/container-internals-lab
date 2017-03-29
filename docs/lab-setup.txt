

# Setup Network
Configure all IP addresses statically to make things consistent when running the lab. Use hosts file to make sure all nodes can communicate.
```192.168.122.200	master1.ocp1.dc2.crunchtools.com
192.168.122.201	master2.ocp1.dc2.crunchtools.com
192.168.122.202	node1.ocp1.dc2.crunchtools.com
192.168.122.203	node2.ocp1.dc2.crunchtools.com
192.168.122.204	node3.ocp1.dc2.crunchtools.com```

```/etc/sysconfig/network-scripts/ifcfg-eth0
BOOTPROTO=static
IPADDR=192.168.122.200
ONBOOT=yes
-UUID```

```/etc/sysconfig/network
HOSTNAME=master1.ocp1.dc2.crunchtools.com
GATEWAY=192.168.122.1
NETWORKING=YES```

```hostnamectl set-hostname master1.ocp1.dc2.crunchtools.com```


# Storage Volume
The nice part about Atomic Host is that it sets the docker storage up for you ahead of time. All you have to do is extend it to make things easy to run.

```lvextend -l +100%FREE /dev/mapper/rhelah-docker--pool```

# Atomic Tools Container

# Lab 3 Exercises
Get into the right directory. By now, you should start to understand which of these command can be ran from directly on the how and which can be run from a super privileged container. Most of these commands will run just fine in a super privileged container, like accessing the hosts PID table, but some commands require access to the hosts's RPM database, which means it needs to be ran on the host or the RPM database directory needs mounted into a container to inspect it.

We suggest running all of these commands on the host for simplicity
```
cd /root/work/container-internals-lab/labs/lab-03/
```


## Exercise 1
The goal of this exercise is to gain a basic understanding of the APIs (Kubernetes/OpenShift, Docker, Linux kernel). First let's inspect the daemons which are running on the master nodes.
```
./exercise-01/mega-proc.sh docker
```

Pay attention to the following proecesses and daemons running. You may notice that all of the docker commands and daemons have the "-current" extension - this is a methodology Red Hat uses to specify which version of the tools are installed. Red Hat supports two versions - a fast moving version with the -latest extension and a stable version targetted for OpenShift with the -current extension.

These processes all work together to create a container in the Linux kernel. The following is a basic description of their purpose:

- **dockerd**: This is the main docker daemon. It handles all docker API calls (docker run, docker build, docker images) through either the unix socket /var/run/docker.sock or it can be configured to handle requests over TCP. This is the "main" daemon and it is started by systemd with the /usr/lib/systemd/system/docker.service unit file.
- **docker-containerd**: Containerd was recently open sourced as a separate community project. The docker daemon talks to containerd when it needs to fire up a container. More and more plumbing is being added to containerd (such as storage).
- **docker-containerd-shim**: this is a shim layer which starts the docker-runc-current command with the right options
- **docker**: This is the docker command which you typed on the command line


Now let's take a look at the OpenShift daemons which are runnning on the master:
```
./exercise-01/mega-proc.sh openshift
```

Pay particular attention the the following daemons. The OpenShift/Kubernetes code is very modular. OpenShift compiles all of the functionality into a single binary and determines which role the daemon will play with start parameters. Depending on which installation method (single node, clustered, registry server only) is chosen the OpenShift binaries can be started in different ways.

- **openshift start master api**:
- **/usr/bin/openshift start node**:
- **/usr/bin/openshift start master controllers**:



In three terminals run the following commands. In the first terminal, prepare to inspect what dockerd is doing. Use megaproc to get the PID and replace the -p argument:
```
strace -f -s1024 -e read,write -p 10510 2>&1 | grep -e "GET " -e "POST " -e "PUT " -e " 200 " -e " 400 "
```

In the second terminal, prepare to inspect what containerd is doing. Use megaproc to get the PID and replace the -p argument:
```
strace -f -s4096 -e clone,getpid -p 10516
```

In the third terminal, run some commands, and inspect what happens in terminal 1 & 2:
```
docker images
docker run -it rhel7 bash
```

## Exercise 2
The goal of this exercise is to gain a basic understanding of system calls and kernel namespaces

## Exercise 3
The goal of this exercise is to gain a basic understanding of SECCOMP

## Exercise 4
The goal of this exercise is to gain a basic understanding of SELinux

## Exercise 5
The goal of this exercise is to gain a basic understanding of cgroups


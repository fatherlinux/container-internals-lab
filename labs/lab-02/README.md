# Lab 2 Excercises
Get into the right directory
```
cd /root/work/container-internals-lab/labs/lab-02/

```



## Excercise 1
The goal is to understand the difference between base images and multi-layered images (repositories). Try to understand the difference between an image layer and a repository.

First, let's take a look at a base image. Notice there is no parent image. This is a base image and it is designed to be built upon.
```
docker run --rm --privileged -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz images -t
```

Now, build a multi-layered image:
```
docker build -t rhel7-change:test exercise-01/
```

Do you see the newly created rhel7-change image?
```
docker images
```

Can you see all of the layers that make up the new image/repository?

```
docker history rhel7-change
```

Now run the "dockviz" command. What does this command show you? What's the parent image of the rhel7-change image?
```
docker run --rm --privileged -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz images -t
```



## Exercise 2
Now we are going to inspect the different parts of the URL that you pull. The most common command is something like this, where only the repository name is specified:

```
docker inspect rhel7
```

But, what's really going on? Well, similar to DNS, the docker command line is resolving the full URL and TAG of the repository on the registry server. The following command will give you the exact same results:
```
docker inspect registry.access.redhat.com/rhel7/rhel:latest
```

You can run any of the following commands and you will get the exact same results as well:
```
docker inspect registry.access.redhat.com/rhel7/rhel:latest
docker inspect registry.access.redhat.com/rhel7/rhel
docker inspect registry.access.redhat.com/rhel7:latest
docker inspect registry.access.redhat.com/rhel7
docker inspect rhel7/rhel:latest
docker inspect rhel7/rhel
```

Now, let's build another image, but give it a tag other than "latest":
```
docker build -t registry.access.redhat.com/rhel7/rhel:test exercise-01/
```

Now, notice there is another tag
```
docker run --rm --privileged -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz images -t
```

Now try the resolution trick again. What happened?
```
docker inspect rhel7:test
```

Notice that full resolution only works with the latest tag. You have to specify the namespace and the repository with other tags. Remember this when building scripts.
```
docker inspect rhel7/rhel:test
```



## Exercise 3
Now, let's tak a look at what's inside the container image. Java is particularly interesting because it uses glibc.
```
docker run -it registry.access.redhat.com/jboss-eap-7/eap70-openshift ldd -v -r /usr/lib/jvm/java-1.8.0-openjdk/jre/bin/java
```

Notice that dynamic scripting languages are also compiled and linked against system libraries:
```
docker run -it rhel7 ldd /usr/bin/python
```

Inspecting a common tool like "curl" demonstrates how many libraries are used from the operating system. First, start the RHEL Tools container:
```
docker run -it rhel7/rhel-tools bash
```

Take a look at all of the libraries curl is linked against:
```
ldd /usr/bin/curl
```

Let's see what packages deliver those libraries? Both, OpenSSL, and the Network Security Services libraries.
```
rpm -qf /lib64/libssl.so.10
rpm -qf /lib64/libssl3.so
```

It's a similar story with Apache and most other daemons and utilities that rely on libraries for security, or deep hardware integration:
```
docker run -it registry.access.redhat.com/rhscl/httpd-24-rhel7 bash
```

Inspect mod_ssl Apache module:
```
ldd /opt/rh/httpd24/root/usr/lib64/httpd/modules/mod_ssl.so
```

Once again we find a library provided by OpenSSL:
```
rpm -qf /lib64/libcrypto.so.10
```

What does this all mean? Well, it means you need to be ready to rebuild all of your container images any time there is a security vulnerability in one of the libraries inside one of your container images...

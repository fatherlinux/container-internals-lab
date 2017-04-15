# Lab 2 Excercises
Get into the right directory
```
cd /root/work/container-internals-lab/labs/lab-04/
```



## Exercise 1
The goal of this exercise is to build a containerized two tier application in the OpenShift cluster. This application will help you learn about clustered containers and distributed systems


First, inspect the application that we are going to create. We will start with the definition of the application itself. Notice the different software defined objects we are going to create - Services, ReplicationControllers, Routes, PeristentVolumeClaims. All of these objects are defined in a single file to make sharing and deployment of the entire application easy. These definitions can be stored in version control systems just like code. With Kubernetes these application definition files can be written in either JSON or YAML. 

Notice, there is only a single Route in this definition. That's because Services are internal to the Kubernetes cluster, while Routes expose the service externally. We only want to expose our Web Server externally, not our Database:
```
vi excercise-01/wordpress-objects.yaml
```

Now, let's create an application:
```
oc create -f excercise-01/wordpress-objects.yaml
```

Look at the status of the application. The two pods that make up this application will remain in a "pending" state - why?
```
oc describe pod wordpress-
oc describe pod mysql-
```

Inspect the persistent volume claims:
```
oc get pvc
```

The application needs storage for the MySQL tables, and Web Root for Apache. Let's inspect the yaml file which will create the storage. We will create four persistent volumes - two that have 1GB of storage and two that will have 2GB of storage. These perisistent volumes will reside on the storage node and use NFS:
```
vi excercise-01/persistent-volumes.yaml
```

Instantiate the peristent volumes:
```
oc create -f excercise-01/persistent-volumes.yaml
```

Now, the persistent volume claims for the application will become Bound and satisfy the storage requirements:
```
oc get pvc
```

Now look at the status of the pods again:
```
oc describe pod wordpress-
oc describe pod mysql-
```

You may notice the wordpress pod enter a state called CrashLoopBackOff. This is a natural state in Kubernetes/OpenShift which helps satisfy dependencies. The wordpress pod will not start until the mysql pod is up and running. This makes sense, because wordpress can't run until it has a database and a connection to it. Similar to email retries, Kubernetes will back off and attempt to restart the pod again after a short time. Kubernetes will try several times, extending the time between tries until eventually the dependency is satisfied, or it enters an Error state. Luckily, once the mysql pod comes up, wordpress will come up successfully.
```
oc describe pod wordpress-
```

In this exercise you learned how to deploy a fully functional two tier application with a single command (oc create -f excercise-01/wordpress-objects.yaml). As long as the cluster has peristnet volumes available to satisify the application, an end user can do this on their laptop, in a development environment or in production data centers all over the world. All of the dependent code is packaged up and delivered in the container images - all of the data and configuration comes from the environment. Production instances will access production persistent volumes, development environments can be seeded with copies of production data, etc. It's easy to see why container orchestration is so powerful. 



## Exercise 2
The goal of this exercies is to understand the nature of a distributed systems environment with containers.




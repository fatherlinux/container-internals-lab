# Lab 2 Excercises
Get into the right directory
```
cd /root/work/container-internals-lab/labs/lab-02/

```

## Excercise 1
Build and inspect the multi-layered images (repositories) on the local machine. Try to understand the difference between an image layer and a repository.

First, build a multi-layered image
```
docker build -t rhel7-change exercise-01/
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

## Abstract
Have you ever wondered how Linux containers work? How they really work, deep down inside? Questions like: How does sVirt/SELinux, SECCOMP, namespaces, and isolation really work? How does the Docker Daemon work? How does Kubernetes talk to the Docker Daemon? How are container images made? In this lab, we'll answer all these questions and more. If you want a deep technical understanding of containers, this is the lab for you. An engineering walk through the deep, dark internals of the container host, what’s packaged in the container image, and how container orchestration work. You'll get the knowledge and confidence it takes to apply your current Linux technical knowledge to containers.

This lab was given at Red Hat Summit 2017 in Boston. If you missed the session, feel free to run through this material. If you have any questions, feel free to find me on Twitter: [@fatherlinux](http://crunchtools.com/how-i-got-the-name-fatherlinux/) or create an issue in GitHub. Also, I will be looking to run this lab again at other Open Source and container related conferences, so keep your eye out for more runs. Please send me feedback, I really want to improve this lab, and I know it is a ton of material.

## Links
Full presentation, lab guide, and setup instructions. All of the labs can be completed using [OpenShift Origin](https://docs.openshift.org/latest/getting_started/administrators.html#running-in-a-docker-container) in a container, running on [Fedora Atomic Host](https://getfedora.org/atomic/download/). If you are an over acheiver, it's recommended that you set up a cluster with 3 masters, 3 nodes, 1 haproxy, and 1 storage node.

- [Presentation](http://bit.ly/2q0j3im)
- [Lab Guide](http://bit.ly/2prnkYi)
- [Setup Instructions](https://github.com/fatherlinux/container-internals-lab/tree/master/meta/lab-build)
- [Dictionary](https://docs.google.com/document/d/10qOfVa9EfWVPRfeB_JNDQ8Wz7QhY6LSZkd0wYaZi97c/edit#heading=h.7su8sbqp44g9)
- [Operations Guidance](https://docs.google.com/document/d/10qOfVa9EfWVPRfeB_JNDQ8Wz7QhY6LSZkd0wYaZi97c/edit#heading=h.8hdst1fon9dq)

## Ciriculum
Each section containers a 4-6 slide presenation, and exercises. You should got through the presentation, then complete the exercises in each section. The labs reinforce and demonstrate what is covered in the presetentation.

### Lab 1: Architecure
This lab is focused on understanding the architecture of how Kubernetes/OpenShift, Docker, and the Linux kernel work together to run containers.
- [Presentation](https://docs.google.com/presentation/d/1TSSq_1jGhoaY8gkHdpwnSL_bRjaNVIDOxSGSdKLarWA/edit#slide=id.g2065a112e4_1_36)
- [Lab Guide](https://docs.google.com/document/d/10qOfVa9EfWVPRfeB_JNDQ8Wz7QhY6LSZkd0wYaZi97c/edit#heading=h.5yclnh6h5b5z)
- [Exercises](https://docs.google.com/document/d/10qOfVa9EfWVPRfeB_JNDQ8Wz7QhY6LSZkd0wYaZi97c/edit#heading=h.5yclnh6h5b5z)

### Lab 2: Container Images
This lab is focused on understanding how Open Container Initiative (OCI), also known as Docker, images are built, tagged, organized and leveraged to deliver software in a range of use cases. 
- [Presentation](https://docs.google.com/presentation/d/1TSSq_1jGhoaY8gkHdpwnSL_bRjaNVIDOxSGSdKLarWA/edit#slide=id.g20639ff941_0_26)
- [Lab Guide](https://docs.google.com/document/d/10qOfVa9EfWVPRfeB_JNDQ8Wz7QhY6LSZkd0wYaZi97c/edit#heading=h.abkrpov51t320
- [Exercises](https://github.com/fatherlinux/container-internals-lab/tree/master/labs/lab-02)

### Lab 3: Container Runtime
This lab focuses on understanding how a particular host actually runs the container images - from the deep internals of how containerized processes interact with the Linux kernel, to the docker daemon and how it receives REST API calls and translates them into system calls to tell the Linux kernel to create new containerized processes.
- [Presentation](https://docs.google.com/presentation/d/1TSSq_1jGhoaY8gkHdpwnSL_bRjaNVIDOxSGSdKLarWA/edit#slide=id.g20639ff941_0_30)
- [Lab Guide](https://docs.google.com/document/d/10qOfVa9EfWVPRfeB_JNDQ8Wz7QhY6LSZkd0wYaZi97c/edit#heading=h.9pp3vsupi47n)
- [Exercises](https://github.com/fatherlinux/container-internals-lab/tree/master/labs/lab-03)

### Lab 4: Container Orchestration
This lab focuses on understanding how Kubernetes/OpenShift work - from how the daemons interact, to how to model your application with a distributed systems mindset.
- [Presentation](https://docs.google.com/presentation/d/1TSSq_1jGhoaY8gkHdpwnSL_bRjaNVIDOxSGSdKLarWA/edit#slide=id.g20639ff941_0_42)
- [Lab Guide](https://docs.google.com/document/d/10qOfVa9EfWVPRfeB_JNDQ8Wz7QhY6LSZkd0wYaZi97c/edit#heading=h.ulao5c3adja2)
- [Exercises](https://github.com/fatherlinux/container-internals-lab/tree/master/labs/lab-04)

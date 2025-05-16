# Containers Fundamentals - Test Setup

These instructions will guide you through testing a GitHub Codespaces environment that you can use to run the course labs. 

*(Note: If you prefer to run this in your own environment, you will need to have Docker and Kubernetes installed and configured, and have a clone of this repository. If you run in your own environment, some elements in the labs may look/be different and are not guaranteed to function the same way. For those reasons, the codespace environment is the recommended one for the class.)*

If using the codespace environment, follow the instructions below.

**1. Click on the button below to start a new codespace from this repository.**

Click here ➡️  [![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/brentlaster/containers-test?quickstart=1)

**2. Then click on the option to create a new codespace.**

![Creating new codespace from button](./images/cf01.png?raw=true "Creating new codespace from button")

This will run for a while to get everything ready.

## Start the Kubernetes cluster and complete setup

**3. Run the following commands in the codespace's terminal (This will take several minutes to run...):**

```
./test-setup.sh
```

The output should look similar to the following.

```console
😄  minikube v1.33.1 on Ubuntu 20.04 (docker/amd64)
✨  Automatically selected the docker driver. Other choices: ssh, none
📌  Using Docker driver with root privileges
👍  Starting "minikube" primary control-plane node in "minikube" cluster
🚜  Pulling base image v0.0.44 ...
💾  Downloading Kubernetes v1.30.0 preload ...
    > preloaded-images-k8s-v18-v1...:  342.90 MiB / 342.90 MiB  100.00% 207.93 
    > gcr.io/k8s-minikube/kicbase...:  481.58 MiB / 481.58 MiB  100.00% 66.28 M
🔥  Creating docker container (CPUs=2, Memory=2200MB) ...
🐳  Preparing Kubernetes v1.30.0 on Docker 26.1.1 ...
    ▪ Generating certificates and keys ...
    ▪ Booting up control plane ...
    ▪ Configuring RBAC rules ...
🔗  Configuring bridge CNI (Container Networking Interface) ...
🔎  Verifying Kubernetes components...
    ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
🌟  Enabled addons: storage-provisioner, default-storageclass
🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default
💡  registry is an addon maintained by minikube. For any concerns contact minikube on GitHub.
You can view the list of minikube maintainers at: https://github.com/kubernetes/minikube/blob/master/OWNERS
    ▪ Using image gcr.io/k8s-minikube/kube-registry-proxy:0.0.6
    ▪ Using image docker.io/registry:2.8.3
🔎  Verifying registry addon...
🌟  The 'registry' addon is enabled
```

<br/><br/>

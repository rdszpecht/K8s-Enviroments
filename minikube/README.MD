<p align="center">
  <img src="https://www.couchbase.com/wp-content/original-assets/september-2016/minikube---rapid-dev--testing-for-kubernetes/minikube-logo-1024x290.jpg" alt="logo" height=150>
</p>

## Introduction
The purpose of this folder is to enable anyone to deploy the EoloPlanner application on minikube and be able to do some play around and testing with learning purposes.

With this in mind, following you can find a list of performed steps. As you may have noticed, there are similar tutorials separated in folders by environments in this repository.

## About Minikube
Minikube is a lightweight tool that simplifies the setup and testing of Kubernetes applications on a local machine. It provides a convenient environment for developers to experiment with different Kubernetes features, test their applications, and simulate clusters. Minikube offers flexibility by supporting different drivers, allowing users to choose the virtualization technology that best suits their needs, such as VirtualBox, VMware, or Docker. 

This enables developers to run Kubernetes locally using their preferred driver and provides compatibility with various operating systems. With its user-friendly nature and driver options, Minikube serves as an excellent tool for learning, development, and testing purposes, providing an easy way to explore Kubernetes functionality in a local environment.

## Installation and setup:
Prerequirements:
- You need a driver, it may be a VM or docker, in this case we are using docker.
- Keep in mind this tutorial is done in Ubuntu.

In order to install minikube on our local environment, run the application (./resources), and test it, the steps to follow are:

1. Install kubectl:

```bash
$ curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

$ sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

2. Install minikube:
   
```bash
$ curl -o ~/Downloads/minikube-linux-amd64 https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 

$ sudo install ~/Downloads/minikube-linux-amd64 /usr/local/bin/minikube
```

3. Start minikube:
   
Notice that the first start also downloads kubernetes itself if you don't have it already.

```bash
$ minikube version

$ minikube start
```

4. Have a look at the dashboard:

```bash
$ minikube dashboard
```

Here minikube suggests us to use a minikube specific addon:
```
$ minikube addons enable metrics-server
```

As you can see, the dashboard opens, but for now, it is empty.

5. Deploy the resources:
```
$ kubectl apply -f resources/.
```
Give it few minutes.

6. Have a look at the dashboard again:
Repeat the step 4, or just go to the UI dashboard if you haven't closed it.


7. Connect to the web UI service:
```
$ minikube service --url server-service 
```
Follow the given link. You should see an EoloPlanner UI, try creating some plants.

Overall, really simple process, minikube is the perfect tool for learning and testing locally.

# Extra:

## Helm:
Does HELM work with minikube?
 - Yes it does.

To test it, follow these steps: 
1. Make sure you have kubectl installed and connected to a cluster.
2. Execute:
```
$ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3

$ chmod 700 get_helm.sh

$ ./get_helm.sh
```

3. Execute:
```
$ helm version
```
to ensure that the installation is correct.

4. Install the application with helm:
```
$ cd helm

$ helm install eoloplanner-release ./eoloplanner
```
or
```
$ chmod +rwx install.sh

$ ./install.sh
```

5. Test the application:
```
http://{the ip of your cluster}:30000/
```

## Load balancer

Not with a vanilla installation. But there are some options to make it work. One of those is to do ```$ minikube tunnel``` and then the load balancer works. 

The other option is to add an addon called metallb you can install and use. If you want to use LoadBalancers, follow these steps:
1. Execute ```$ minikube addons enable metallb```
2. Execute ```$ minikube addons configure metallb```. Enter some sample ips, for instants: 192.168.59.20 and 192.168.59.30.
3. Apply this file: ```$ kubectl apply -f metallb-config.yaml.```


We've created a folder named "loadBalancer" with a yaml file to be deployed and a script for testing. If you are getting both "foo" and "bar" outputs while running the script, it means the load balancer is working fine.

You want to run ```$ kubectl get all``` command, copy the external ip for the service, run ```$ export LB_IP={pasteYourIp}```, give permissions to the script and run it.

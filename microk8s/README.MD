<p align="center">
  <img src="https://global.discourse-cdn.com/business6/uploads/kubernetes/original/2X/5/52c2e57feb961611de65abf267208fa8a957f5f5.png" alt="logo" height=150>
</p>

## Introduction
The purpose of this folder is to enable anyone to deploy the EoloPlanner application on microk8s and be able to do some play around and testing with learning purposes.

With this in mind, following you can find a list of performed steps. As you may have noticed, there are similar tutorials separated in folders by environments in this repository.

## About Microk8s

Microk8s is a lightweight distribution of Kubernetes. It provides a simplified and easy to install Kubernetes cluster for local development and testing. With minimal system resource requirements, Microk8s allows users to quickly set up a fully functional Kubernetes environment on laptops, desktops, or edge devices. 

It offers optional add-ons and supports key Kubernetes features like scaling, load balancing, and service discovery. Microk8s enables developers to experiment and deploy containerized applications efficiently in a local environment.

## Installation and setup:
Prerequirements:
- You don't need any driver, nor docker, it runs all the services natively in your local machine.
- You need **snap**
- Keep in mind this tutorial is done in Ubuntu.

In order to install microk8s on our local environment, run the application (./resources), and test it, the steps to follow are:

1. Install kubectl:

```bash
$ curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

$ sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

2. Install microk8s:
   
```bash
$ sudo snap install microk8s --classic
```

3. Enable addons:
   
We can really easily enable and disable addons such as dns, storage, ingress, istio or dashboard, using ```microk8s enable [addon]``` and ```microk8s disable [addon]``` commands. Let's enable dashboard for example:

```bash
$ sudo microk8s enable dashboard
```

Also guides recommend enabling dns because other addons might use it.

```bash
$ sudo microk8s enable dns
```

Finally, in order to be able to use Persistent Volume Claims, we have to enable storage addon.

Worth noting that these pvcs can be deployed in microk8s without setting anything else, so this is a metter to take in consideration in migrations.

```bash
$ sudo microk8s enable storage
```

1. At this point we can check the progress of the addons to be deployed: 

```bash
$ sudo microk8s kubectl get all --all-namespaces
```

## Demo

1. Deploy the resources:

```bash
$ sudo microk8s kubectl apply -f resources/.
```

2. Have a look at the dashboard:

```bash
$ sudo microk8s kubectl get all --all-namespaces

NAMESPACE     NAME                                TYPE        CLUSTER-IP       EXTERNAL-IP   PORT
default       service/kubernetes                  ClusterIP   10.152.183.1     <none>        443
kube-system   service/metrics-server              ClusterIP   10.152.183.245   <none>        443
kube-system   service/kubernetes-dashboard        ClusterIP   10.152.183.120   <none>        443
kube-system   service/dashboard-metrics-scraper   ClusterIP   10.152.183.74    <none>        8000
```
Look for the IP and port for the kubernetes dashboard service, then paste both into your browser, keep in mind using https. This is going to show you a login screen, use the default token by:

```bash
$ token=$(sudo microk8s kubectl -n kube-system get secret | grep default-token | cut -d " " -f1)

$ sudo microk8s kubectl -n kube-system describe secret $token
```

Copy the long token displayed in the console and login into the dashboard.

3. Connect to the web UI service:

Check the services deployed in the default namespace, so we can retrieve the IP and port for server-service.

```bash
$ sudo microk8s kubectl get service --namespace default
NAME                     TYPE        CLUSTER-IP       EXTERNAL-IP   PORT
kubernetes               ClusterIP   10.152.183.1     <none>        443/
mongodb-service          ClusterIP   10.152.183.247   <none>        27017/TCP
mysql-service            ClusterIP   10.152.183.201   <none>        3306/
rabbitmq-service         ClusterIP   10.152.183.45    <none>        5672/TCP,15672/
server-service           NodePort    10.152.183.118   <none>        3000:30000/
toposervice-service      ClusterIP   10.152.183.249   <none>        8181/
weatherservice-service   ClusterIP   10.152.183.106   <none>        9090/

```
Paste the IP:Port in your browser, in this case ```http://10.152.183.118:3000```. Play with the app, try creating some plants.


# Extra

## Helm:
Does HELM work with microk8s?
 - Yes it does. In fact, MicroK8s comes with Helm pre-installed, so you can use it out of the box.

1. Make sure you have kubectl installed and connected to a cluster.

2. Install the application with helm:
```
$ cd helm

$ sudo microk8s helm install eoloplanner-release ./eoloplanner
```

3. Test the application:
```
http://{the ip of server-service}:30000/
```
Get the ip of the service the same way as before.

## Istio:
You can install istio with microk8s. Follow these steps:

1. Enable community addons ```sudo microk8s enable community```
2. Enable istio ```sudo microk8s enable istio```

## Load Balancer

Does microk8s have a load balancer?

No with a vanilla installation, but you can easily use MetalLB. Just execute: ```$ microk8s enable metallb```

We've created a folder named "loadBalancer" with a yaml file to be deployed and a script for testing. If you are getting both "foo" and "bar" outputs while running the script, it means the load balancer is working fine.

You want to run ```$ kubectl get all``` command, copy the external ip for the service, run ```$ export LB_IP={pasteYourIp}```, give permissions to the script and run it.

## Conclusions
Overall, pretty simple to use, the set-up is pretty fast and the addons work really well. For learning and testing locally purposes.

Unlike minikube, it does not require using docker or a VM. It runs the images in linux container technologies. Also this makes it faster.

It does provide better support for addons. Helm is installed by default. Good interaction with istio.

Keep in mind you need **snap** in order to install it.

## Cheatsheet
Here you have a cheat sheet with some useful commands:

- ```$ microk8s status```: Provides an overview of the MicroK8s state (running / not running) as well as the set of enabled addons
- ```$ microk8s enable```: Enables an addon
- ```$ microk8s disable```: Disables an addon
- ```$ microk8s kubectl```: Interact with kubernetes
- ```$ microk8s config```: Shows the kubernetes config file
- ```$ microk8s istioctl```: Interact with the istio services; needs the istio addon to be enabled
- ```$ microk8s inspect```: Performs a quick inspection of the MicroK8s intallation
- ```$ microk8s reset```: Resets the infrastructure to a clean state
- ```$ microk8s stop```: Stops all kubernetes services
- ```$ microk8s start```: Starts MicroK8s after it is being stopped

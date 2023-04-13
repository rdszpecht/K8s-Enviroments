<p align="center">
  <img src="https://d33wubrfki0l68.cloudfront.net/d0c94836ab5b896f29728f3c4798054539303799/9f948/logo/logo.png" alt="logo" height=150>
</p>

## Introduction
The purpose of this folder is to enable anyone to deploy the EoloPlanner application on kind and be able to do some play around and testing with learning purposes.

With this in mind, following you can find a list of performed steps. As you may have noticed, there are similar tutorials separated in folders by environments in this repository.

## About Kind
KIND (Kubernetes IN Docker) is an open-source tool that allows you to run local Kubernetes clusters inside Docker containers. It provides an easy and lightweight way to set up and test Kubernetes applications without the need for a full-scale production environment. With KIND, you can quickly spin up a Kubernetes cluster on your local machine and run tests.

## Installation and setup:
Prerequirements:
- You need docker.
- You can install it with Go, using the LTS version.

In order to install kind on our local environment, run the application (./resources), and test it, the steps to follow are:

1. Install kind:
   
```
$ go install sigs.k8s.io/kind@v0.18.0
```

3. Start kind:
   
```
$ kind create cluster
```

Once the cluster is deployed, the local kubectl will be automatically pointed to it.

## Demo

1. Deploy the resources:
```
$ kubectl apply -f resources/.
```
Give it few minutes.


2. Take a look at our cluster resources:
```
$kubectl get all
NAME                                        READY   STATUS              RESTARTS   AGE
pod/mongodb-deploy-6845cd9675-2rdw2         0/1     Pending             0          10s
pod/mysql-deploy-897d8f876-g4n4c            0/1     Pending             0          10s
pod/planner-deploy-5bf58d697c-75m2k         0/1     ContainerCreating   0          10s
pod/rabbitmq-deploy-6cb4c7f8bc-j4dfl        0/1     ContainerCreating   0          10s
pod/server-deploy-588c584b9d-t4lnb          0/1     ContainerCreating   0          10s
pod/toposervice-deploy-567f67f956-bl6hj     0/1     ContainerCreating   0          10s
pod/weatherservice-deploy-b5c4b588f-fq4kk   0/1     ContainerCreating   0          10s

NAME                             TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                         AGE
service/kubernetes               ClusterIP   10.96.0.1       <none>        443/TCP                         50s
service/mongodb-service          ClusterIP   10.96.192.113   <none>        27017/TCP,27018/TCP,27019/TCP   10s
service/mysql-service            ClusterIP   10.96.118.203   <none>        3306/TCP                        10s
service/rabbitmq-service         ClusterIP   10.96.52.47     <none>        5672/TCP,15672/TCP              10s
service/server-service           NodePort    10.96.71.230    <none>        3000:30000/TCP                  10s
service/toposervice-service      ClusterIP   10.96.215.231   <none>        8181/TCP                        10s
service/weatherservice-service   ClusterIP   10.96.154.12    <none>        9090/TCP                        10s

NAME                                    READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/mongodb-deploy          0/1     1            0           10s
deployment.apps/mysql-deploy            0/1     1            0           10s
deployment.apps/planner-deploy          0/1     1            0           10s
deployment.apps/rabbitmq-deploy         0/1     1            0           10s
deployment.apps/server-deploy           0/1     1            0           10s
deployment.apps/toposervice-deploy      0/1     1            0           10s
deployment.apps/weatherservice-deploy   0/1     1            0           10s
```

3. Access to application

We can use the link to the server to access the application, using the port 3000

# Extra:

## Network policies:

By default, Kind uses its own CNI and does not support network policies. 
To enable network policies, we need to configure a different CNI, such as Calico. 
To do this, we must create a cluster and disable the default CNI during setup. 
Once the cluster is up and running, we can install Calico or another CNI of our choice.

## Load Balancer:

By default, Kind doesn't come with any load balancer configured. It is necessary to install one, and in its own documentation, MetalLB is recommended. 
No special configuration is required when setting up the cluster, just install the necessary MetalLB resources.
To configure we need to provide MetalLB with a range of IP addresses from the Docker Kind network. We can use the ```docker network inspect``` command to obtain the IP range, which should be within the subnet of the Docker Kind network.

### Testing
We've created a folder named "loadBalancer" with a yaml file to be deployed and a script for testing. If you are getting both "foo" and "bar" outputs while running the script, it means the load balancer is working fine.

You want to run ```kubectl get all``` command, copy the external ip for the service, run ```export LB_IP={pasteYourIp}```, give permissions to the script and run it.

## Helm:
You can deploy helm applications on **Kind** without any further impact.

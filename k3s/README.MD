<p align="center">
  <img src="https://k3s.io/img/k3s-logo-light.svg" alt="logo" height=150>
</p>

## Introduction
The purpose of this folder is to enable anyone to deploy the EoloPlanner application on K3S and be able to do some play around and testing with learning purposes.

With this in mind, following you can find a list of performed steps. As you may have noticed, there are similar tutorials separated in folders by environments in this repository.


## About K3S

K3S is a lightweight version of Kubernetes designed for use in production on small servers, IoT devices, and more. The binary is less than 50 MB in size.

Indeed, a lightweight version typically means that certain features have been removed to make it more streamlined. With K3S, many functionalities that are considered "legacy," "alpha," or "non-default" have been removed. Additionally, all add-ons have been eliminated.

## Installation and setup:

It is very simple to install, you just need to download the installation script directly from its website and run it. It will also install other useful tools such as kubectl.

```
$ curl -sfL https://get.k3s.io | sh -
```

In its documentation, you can find more ways to configure the installation.

The installation includes the k3s CLI, which allows us to perform the following operations:

```
   server           Run management server
   agent            Run node agent
   kubectl          Run kubectl
   crictl           Run crictl
   ctr              Run ctr
   check-config     Run config check
   token            Manage bootstrap tokens
   etcd-snapshot    Trigger an immediate etcd snapshot
   secrets-encrypt  Control secrets encryption and keys rotation
   certificate      Manage K3s certificates
   completion       Install shell completion script
   help, h          Shows a list of commands or help for one command
```

We are interested in starting a cluster, we will use a single-node cluster for our test, but we have the ability to add more nodes.

```
$ sudo k3s server
```

At this point, we now have a single-node cluster up and running, and we can easily perform operations on it. Through its CLI, we can interact directly by using **k3s kubectl**.

## Demo:

We are going to run an application with different services that interact with each other, called EoloPlanner. To do this, we will use the resources in the 'Resources' folder located in this same directory.

As mentioned before, we will use the CLI to interact with the cluster. To deploy all the resources contained in that folder, we will use:

```
$ sudo k3s kubectl apply -f resources/
```

Now, we can see how those resources are being deployed:

```
$ sudo k3s kubectl get all
NAME                                        READY   STATUS    RESTARTS   AGE
pod/mongodb-deploy-6845cd9675-l9fwr         0/1     Pending   0          6s
pod/mysql-deploy-897d8f876-lrdrz            1/1     Running   0          6s
pod/planner-deploy-5bf58d697c-vwp9b         1/1     Running   0          6s
pod/server-deploy-588c584b9d-r2tdj          1/1     Running   0          6s
pod/rabbitmq-deploy-6cb4c7f8bc-2ftx7        1/1     Running   0          6s
pod/toposervice-deploy-567f67f956-fb92g     1/1     Running   0          6s
pod/weatherservice-deploy-b5c4b588f-ct7ls   1/1     Running   0          6s

NAME                             TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                         AGE
service/kubernetes               ClusterIP   10.43.0.1       <none>        443/TCP                         86s
service/mongodb-service          ClusterIP   10.43.178.229   <none>        27017/TCP,27018/TCP,27019/TCP   6s
service/mysql-service            ClusterIP   10.43.180.146   <none>        3306/TCP                        6s
service/rabbitmq-service         ClusterIP   10.43.28.123    <none>        5672/TCP,15672/TCP              6s
service/server-service           NodePort    10.43.107.2     <none>        3000:30000/TCP                  6s
service/toposervice-service      ClusterIP   10.43.39.221    <none>        8181/TCP                        6s
service/weatherservice-service   ClusterIP   10.43.24.235    <none>        9090/TCP                        6s

NAME                                    READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/mongodb-deploy          0/1     1            0           6s
deployment.apps/mysql-deploy            1/1     1            1           6s
deployment.apps/planner-deploy          1/1     1            1           6s
deployment.apps/server-deploy           1/1     1            1           6s
deployment.apps/rabbitmq-deploy         1/1     1            1           6s
deployment.apps/toposervice-deploy      1/1     1            1           6s
deployment.apps/weatherservice-deploy   1/1     1            1           6s

NAME                                              DESIRED   CURRENT   READY   AGE
replicaset.apps/mongodb-deploy-6845cd9675         1         1         0       6s
replicaset.apps/mysql-deploy-897d8f876            1         1         1       6s
replicaset.apps/planner-deploy-5bf58d697c         1         1         1       6s
replicaset.apps/server-deploy-588c584b9d          1         1         1       6s
replicaset.apps/rabbitmq-deploy-6cb4c7f8bc        1         1         1       6s
replicaset.apps/toposervice-deploy-567f67f956     1         1         1       6s
replicaset.apps/weatherservice-deploy-b5c4b588f   1         1         1       6s
```

Once everything is deployed, we can enter the URL of the service 'ServerService' to use the application. We will perform a test to make sure it works by adding one of the cities from the list.

# Extra

## Load Balancer:
K3s provides a default load balancer called ServiceLB.

### Testing
We've created a folder named "loadBalancer" with a yaml file to be deployed and a script for testing. If you are getting both "foo" and "bar" outputs while running the script, it means the load balancer is working fine.

You want to run ```kubectl get all``` command, copy the external ip for the service, run ```export LB_IP={pasteYourIp}```, give permissions to the script and run it.

## Network policies:
Network policies work by default in K3s, as it uses a CNI called Flannel.

## Helm:
You can deploy helm applications on k3s without any further impact.
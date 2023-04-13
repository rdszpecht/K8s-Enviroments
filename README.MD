# Kubernetes Local Enviroments comparison

## Introduction
This repository offers a comparison of several kubernetes local enviroments to help the reader to chose between them, the one that fits best their task. 

For each enviroment, you are going to find a folder, with the steps you want to follow to deploy, and test a sample application, as well as some more details specific to each enviroment. The enviroments we've took into consideration are:

* [**Docker Desktop (Windows)**](./Docker%20Desktop/)
* [**Kind (Linux)**](./kind/)
* [**Minikube (Linux)**](./minikube/)
* [**Microk8s (Linux)**](./microk8s/)
* [**K3s (Linux)**](./k3s/)

## Conclusions

After doing some tests, research, and working a little bit with each distribution, these are our thougts:

**Docker Desktop** is more limited than the other four tools. Moreover, its installation is considerably more problematic than the others. Its only advantage is that it provides a graphical interface for users unfamiliar with console usage. However, Kubernetes often fails to start, and the tool lacks transparency in diagnosing the encountered problems. It gives the impression of an unfinished product.

**Kind** is somewhat restricted; for instance, it lacks an interface to install addons, and they must be deployed manually. If you aim to quickly and easily deploy a cluster locally without special requirements, Kind is a very good option. It can only be used with Docker (the cluster is deployed within a Docker container). All changes must be made through YAML configuration. The default CNI is kindnet, which does not support network policies.

**Minikube** can be deployed both in Docker and other types of virtualizations (by default in Docker), which makes it versatile. It has the most extensive community and documentation in this comparison, which is a significant advantage. It offers a wide range of options such as cluster communication (tunnels, SSH, IP, logs, etc.), easy start and stop commands, and addon control. Minikube was created by the creators of Kubernetes. The default CNI is bridge, which does not support network policies.

**Microk8s** is also straightforward to install. It executes deployments natively (without the need for virtualizations or Docker). It is very fast in terms of deployment. It has a user-friendly addon interface, and we found its CLI easy to handle. It also has excellent documentation. Microk8s is developed by Canonical (Ubuntu), and Snap is required for its usage. On the downside, access to the dashboard could be more direct and straightforward like in Minikube. The default CNI is calico, which supports network policies, and cillium can also be easily utilized. Superuser permissions are required.

**K3s** is more focused on production for servers with lighter workloads. It does not run on Docker (though there is k3d that does), and it executes deployments natively like Microk8s. It offers a complete yet lightweight Kubernetes solution. Another strength is that it provides many practical default options that its competitors lack, such as LoadBalancer, CNI with network policy support, dynamic storage for persistent volumes and persistent volume claims. This is advantageous for portability and deployments of applications requiring these features. On the downside, its documentation is more complex to comprehend, and there is not as much information available online compared to its competitors. K3s was created by Rancher. The default CNI is Flannel, which supports network policies by default. It does not have addons and does not run a vanilla version of Kubernetes.

## Summary
There is a clear distinction between Kind and Minikube, and Microk8s and K3s: Minikube and Kind run deployments within images or virtualizations (Kind only in Docker), whereas Microk8s and K3s execute everything natively. Microk8s and K3s are designed for IoT and Edge Computing as they are lighter in weight.

The capabilities offered by Minikube, Microk8s, and K3s are very similar, while Kind is slightly more limited.

## When to choose each of these tools?

* **Docker Desktop:** If you need to set up a Kubernetes cluster on Windows and prefer a graphical interface.

* **Minikube:** Ideal for learning and testing, especially if you want to deploy using Docker. It is the easiest option to install and use.

* **Kind:** It is also suitable for learning and testing if you want to deploy using Docker. However, in this case, we prefer Minikube

* **Microk8s:** Recommended for learning and testing if you want to deploy natively. It is particularly useful if you seek faster deployments and have Snap available.

* **K3s:** If you require LoadBalancers, dynamic storage, network policies, etc., in the easiest possible way. It is the appropriate choice if you want to set up Kubernetes in production or simulate a production environment locally.
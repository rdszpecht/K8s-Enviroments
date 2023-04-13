<p align="center">
  <img src="https://geekflare.com/wp-content/uploads/2020/05/docker-desktop.jpg" alt="logo" height=150>
</p>

## Introduction
The purpose of this folder is to enable anyone to deploy the EoloPlanner application on Docker Desktop and be able to play around and test it for learning purposes.

With this in mind, you can find a list of steps performed below. As you may have noticed, there are similar tutorials separated into folders by environments in this repository.

### Disclaimer:
We have tested and tried it on several Linux OSs and believe it is not worth using in Linux. This demo was performed on Windows 10.

## About Docker Desktop
Docker Desktop is a widely used tool for simplifying containerized application development and deployment. It provides a seamless experience for running Docker containers on your local machine, supporting various operating systems. With its graphical user interface (GUI) and integration with other Docker ecosystem tools, Docker Desktop aims to streamline the container lifecycle management process. While some users may have different preferences or concerns about the application, it continues to be a popular choice for many developers and organizations.

## Installation and Setup:
To install Docker Desktop on your local environment, follow these steps:

1. Download and install Docker Desktop:
   [https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/)
2. You might need to update your WSL (Windows Subsystem for Linux).
3. Open Docker Desktop.
4. Navigate to Settings.
5. Navigate to Kubernetes.
6. Select the "Enable Kubernetes" option.
7. Open a terminal (we've used Git Bash) and deploy the application using the following command:
      
   ```kubectl apply -f ./resources```

![img](https://snipboard.io/pYfiG9.jpg)

## Demo

1. For monitoring purposes, connect to the cluster using Lens: [https://k8slens.dev/](https://k8slens.dev/)

2. Find the server/service and perform a port forward in order to interact with the application from your browser.

## Conclusions

Overall, we believe it is a solution to be used only if you absolutely need to test on a Windows machine and don't want to spend much time on it, just deploying some pods locally.

We have found no simple solutions for Ingresses, Network Policies, Load Balancer, or Helm. If you want to deploy a more complex cluster, we suggest avoiding Docker Desktop.


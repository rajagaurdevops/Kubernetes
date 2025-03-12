what is kubernetes
-------------------
Kubernetes (K8s) is an open-source container orchestration system that automatically manages, deploys, scales, and monitors containers. It was originally developed by Google and is now maintained by the Cloud Native Computing Foundation (CNCF).

In Simple Words:
➡️ Kubernetes is like a manager that handles Docker containers by automatically running, restarting, and scaling them.

🔹 Why Do We Need Kubernetes?

If you only use Docker, you have to manually manage your containers. Kubernetes automates this process!
✅ 1. Auto Scaling & Load Balancing

➡️ If traffic increases: Kubernetes automatically adds new containers.
➡️ If traffic decreases: Kubernetes removes extra containers.
➡️ It uses a Load Balancer to distribute traffic across multiple containers.
✅ 2. Self-Healing (Automatic Restarting)
🔹 Basic Kubernetes Architecture

Kubernetes consists of two main components:
--------------------------------------------
    Master Node (Control Plane)
        API Server (Handles kubectl commands)
        Scheduler (Assigns Pods to Nodes)
        Controller Manager (Manages self-healing)
        etcd (Stores cluster configuration)

    Worker Nodes
        Kubelet (Connects nodes to the master)
        Container Runtime (Docker or Containerd)
        Kube Proxy (Manages networking)
        Pods (Groups of containers)

🔹 What is a Cluster?

A cluster is a group of connected computers (or servers) that work together as a single system to provide high availability, scalability, and reliability.

A Kubernetes cluster consists of a control plane plus a set of worker machines, called nodes, that run containerized applications. Every cluster needs at least one worker node in order to run Pods

🔹 What is Minikube?

Minikube is a lightweight tool that allows you to run a Kubernetes cluster on your local machine (Laptop or PC). It is mainly used for learning, development, and testing Kubernetes applications.

🔹 Minikube creates a single-node Kubernetes cluster inside a virtual machine (VM) or container on your system.


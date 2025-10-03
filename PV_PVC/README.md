# Kubernetes Storage and Volumes

This document explains Kubernetes **Volumes, PersistentVolumes (PV), PersistentVolumeClaims (PVC), Binding, Reclaim Policy, and Provisioning**.

---

## 1. What is a Kubernetes Volume?

A **Kubernetes Volume** is a **storage abstraction** that allows **containers in a Pod to store and share data**.  

- Container file systems are **ephemeral**, and data is lost on container restart.  
- Volumes provide **persistent storage for containers**, surviving restarts.

### Common Volume Types:

| Type                   | Description |
|------------------------|------------|
| emptyDir               | Temporary directory for the Pod; deleted when Pod is removed. |
| hostPath               | Mounts a path from the node’s filesystem. |
| configMap / secret     | Injects configuration or sensitive data into Pods. |
| persistentVolumeClaim  | Mounts a PersistentVolume (PV) as persistent storage. |
| nfs, cephfs, awsEBS, gcePD, azureDisk | External storage backends. |

### Example: emptyDir Volume
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: volume-demo
spec:
  containers:
  - name: app
    image: busybox
    command: ["sh", "-c", "echo Hello > /data/message && sleep 3600"]
    volumeMounts:
    - name: demo-volume
      mountPath: /data
  volumes:
  - name: demo-volume
    emptyDir: {}

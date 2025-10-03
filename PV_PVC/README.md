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
```

# Kubernetes Persistent Volumes and PVCs

This document explains Kubernetes **PersistentVolumes (PV), PersistentVolumeClaims (PVC), Binding, Reclaim Policy, and Provisioning**.

---

## 2. PersistentVolume (PV)

**PersistentVolume (PV)** is a **cluster-wide storage resource** independent of Pods.  

- Used for **persistent data** such as databases or logs.  
- Defined with **capacity, access modes, reclaim policy**, and optional **StorageClass**.

---

## 3. PV-PVC Binding

- **PVC (PersistentVolumeClaim)** requests storage.  
- **PV** provides the storage.  
- Kubernetes **binds a PVC to a suitable PV automatically** if available.  

### Binding Lifecycle

| Status     | Description |
|------------|------------|
| Available  | PV is free and not bound to any PVC. |
| Bound      | PV is bound to a PVC. |
| Released   | PVC is deleted, PV retains data. |
| Failed     | Binding or reclaim failed. |

---

## 4. Reclaim Policy

**Reclaim Policy** defines what happens to a PV after its PVC is deleted.  

| Policy   | Description |
|----------|------------|
| Retain   | PV is not deleted; data is preserved. |
| Delete   | PV and underlying storage are deleted. |
| Recycle (deprecated) | PV is cleaned and made available again. |

**Example:**
```yaml
persistentVolumeReclaimPolicy: Retain

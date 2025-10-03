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

---

## 2. PersistentVolume (PV)

**PersistentVolume (PV)** is a **cluster-wide storage resource** independent of Pods.  

- Used for **persistent data** such as databases or logs.  
- Defined with **capacity, access modes, reclaim policy**, and optional **StorageClass**.

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-demo
spec:
  capacity:
    storage: 5Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: manual
  hostPath:
    path: /mnt/data
```

---

## 3. PV-PVC Binding

- **PVC (PersistentVolumeClaim)** requests storage.  
- **PV** provides the storage.  
- Kubernetes **binds a PVC to a suitable PV automatically** if available.

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-demo
spec:
  accessModes:
    - ReadWriteOnce       
  resources:
    requests:
      storage: 5Gi        
  storageClassName: admin
```

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
```

---

## 5. Why PVC Remains Pending

A **PVC (PersistentVolumeClaim)** remains **Pending** when no suitable PV (PersistentVolume) is available.

**Common Reasons:**
- PV storage capacity is **less than PVC request**  
- **Access mode mismatch** (ReadWriteOnce, ReadWriteMany, ReadOnlyMany)  
- **StorageClass mismatch**  
- All matching PVs are already **bound**  
- Selector or **node affinity mismatch**  

---

## 6. Static vs Dynamic Provisioning

### Static Provisioning
- PVs are **manually created** by the admin.  
- PVC binds to **existing PVs**.  
- **Pros:** Full control  
- **Cons:** Manual, harder to scale  

### Dynamic Provisioning
- PVs are **automatically created** when a PVC is submitted.  
- Requires a **StorageClass**.  
- **Pros:** Automated, scalable  
- **Cons:** Less fine-grained control  

### Comparison

| Feature        | Static           | Dynamic          |
|----------------|-----------------|----------------|
| PV Creation    | Manual           | Automatic       |
| PVC Binding    | Existing PV      | Auto-created PV |
| Scalability    | Hard             | Easy            |
| Control        | High             | Moderate        |
| Cloud Support  | Limited          | Excellent       |

---

# What is StorageClass?
A StorageClass (SC) is a Kubernetes resource that describes how dynamic provisioning of PersistentVolumes (PVs) should happen<br>
It allows admins to define different “classes” of storage—for example, fast SSD storage vs slower HDD storage<br>
Users request a PVC with a specific StorageClass, and Kubernetes automatically creates a PV according to that class<br>

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: admin
provisioner: kubernetes.io/gce-pd
parameters:
  type: pd-standard
volumeBindingMode: Immediate
allowVolumeExpansion: true
reclaimPolicy: Delete

```

## Summary

- **PV (PersistentVolume)** = Storage resource in the cluster, independent of Pods.  
- **PVC (PersistentVolumeClaim)** = Storage request made by a Pod.  
- **Binding** = Connects a PV and PVC automatically based on capacity, access mode, and StorageClass.  
- **Reclaim Policy** = Defines what happens to the PV after its PVC is deleted (Retain, Delete, Recycle).  
- **Static vs Dynamic Provisioning** = Determines how PVs are created:
  - **Static:** PVs are pre-created manually by the admin.  
  - **Dynamic:** PVs are automatically created on PVC request using a StorageClass.  




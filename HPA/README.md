# 🚀 Horizontal Pod Autoscaler (HPA) in Kubernetes

## 🔹 What is HPA?
**HPA (Horizontal Pod Autoscaler)** is a Kubernetes resource that automatically adjusts the number of running Pods in a **Deployment**, **ReplicaSet**, or **StatefulSet** based on real-time metrics such as:
- **CPU utilization**
- **Memory usage**
- **Custom/application-specific metrics**

Instead of keeping a fixed number of Pods, **HPA scales Pods up or down** as workloads change.

---

## 🔹 Why Do We Need HPA?

Without HPA, you must manually decide how many Pods your application should run. However, workloads often fluctuate:

- 🚀 **During peak traffic** → More Pods are needed to handle load  
- 💤 **During low traffic** → Fewer Pods are sufficient (saving resources and cost)

### ✅ Benefits of HPA
- **Better performance:** Keeps apps responsive under high load  
- **High availability:** Prevents downtime by adding more Pods when needed  
- **Cost efficiency:** Reduces unnecessary resource usage during low demand  
- **Resilience:** Automatically adapts to changing workloads  

---

## 🔹 Example Scenario

Suppose you run an **e-commerce application**:

| Situation | Pod Count | Description |
|------------|------------|-------------|
| Normal day | 3 Pods | Handles usual traffic |
| Black Friday | 20 Pods | Auto-scales to handle high traffic |
| After sale | 3 Pods | Scales down to save cost |

---

## 🔹 Autoscaling Based on Resource Utilization

This example creates an **HPA** for an `nginx` Deployment that:
- Scales between **1 and 10 replicas**
- Triggers when **average CPU utilization** surpasses **50%**

---

## 📌 Steps to Configure HPA (Google Cloud Console)

1. Go to **Workloads** page in the [Google Cloud Console](https://console.cloud.google.com/kubernetes/workload).
2. Click the **name** of your `nginx` Deployment.
3. Click **Actions → Autoscale**.
4. Specify:
   - **Minimum replicas:** `1`  
   - **Maximum replicas:** `10`  
   - **Autoscaling metric:** `CPU`  
   - **Target:** `50%`
5. Click **Done** → **Autoscale**

---

## 📌 Verify HPA

To check Horizontal Pod Autoscalers in your cluster:
```bash
kubectl get hpa
```

Example

NAME    REFERENCE          TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
nginx   Deployment/nginx   0%/50%    1         10        3          61s


Horizontal Pod Autoscaling - Google Cloud

# 🔐 Kubernetes SSL/TLS Certificate Management with Ingress and Let’s Encrypt

This guide explains how to set up **automatic SSL/TLS certificates** in Kubernetes using **Cert-Manager**, **Ingress**, and **Let’s Encrypt**.

---

## 🌍 Let’s Encrypt Overview
**Let’s Encrypt** is a free, automated, and open Certificate Authority (CA) that issues SSL/TLS certificates.  

**Key Features**
- ✅ Free of charge  
- ⚡ Automated issuance and renewal  
- 🌐 Trusted by all modern browsers and OS  
- ⏳ Short-lived (90 days) for better security  

---

## 🔧 Cert-Manager Overview
**Cert-Manager** is a Kubernetes-native tool that automates the management and lifecycle of SSL/TLS certificates within a cluster. It handles certificate issuance, validation, renewal, and storage, ensuring workloads remain securely accessible over HTTPS.
  

**Core Functions**
- **Issuance** → Requests certificates from CAs (e.g., Let’s Encrypt)  
- **Renewal** → Automatically renews before expiry  
- **Validation** → Domain verification via `http01` or `dns01` solvers  
- **Secret Management** → Stores certs in Kubernetes Secrets  

---

## 🚀 Step 1: Install Cert-Manager
Apply the official manifest:

```
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.15.0/cert-manager.yaml
```

# Post-Installation
```
  Creates 'cert-manager' namespace
  Deploys: 'cert-manager', 'cert-manager-webhook', 'cert-manager-cainjector'
  Registers CRDs: Certificates, Issuers, ClusterIssuers, Orders, Challenges
  Creates ServiceAccounts, Roles, and RoleBindings

kubectl get pods -n cert-manager
kubectl get crds | grep cert-manager

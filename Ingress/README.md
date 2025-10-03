Kubernetes SSL/TLS Certificate Management with Ingress and Let’s Encrypt
This document provides a comprehensive guide for setting up automatic SSL/TLS certificates in Kubernetes using Cert-Manager, Ingress, and Let’s Encrypt.

Let’s Encrypt Overview
Let’s Encrypt is a free, automated, and open Certificate Authority (CA) that issues SSL/TLS certificates. It enables websites and applications to use HTTPS without manual intervention. Certificates issued by Let’s Encrypt are trusted by modern browsers and operating systems, have a short lifespan of 90 days, and support automatic renewal.

Key Features: - Free of charge - Automated issuance and renewal - Globally trusted - Short-lived certificates promoting strong security practices


Cert-Manager Overview
Cert-Manager  is a Kubernetes-native tool that automates the management and lifecycle of SSL/TLS certificates within a cluster. It handles certificate issuance, validation, renewal, and storage, ensuring workloads remain securely accessible over HTTPS.

Core Functions: 
Issuance: Requests certificates from CAs such as Let’s Encrypt 
Renewal: Automatically renews certificates before expiration
Validation: Verifies domain ownership using ACME solvers (http01 or dns01).
Secret Management: Stores certificates in Kubernetes Secrets for application use.
Cert-Manager minimizes manual intervention and ensures cluster workloads maintain HTTPS consistently.


Step 1: Install Cert-Manager
Apply the official Cert-Manager manifest:

kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.15.0/cert-manager.yaml

Post-Installation: - 
Creates the cert-manager namespace - Starts Deployments: cert-manager, cert-manager-webhook,  cert-manager-cainjector
Registers CRDs: Certificates, Issuers, ClusterIssuers, Orders, and Challenges 
Creates ServiceAccounts, Roles, and RoleBindings for cluster interaction 
Pods begin running and managing certificate requests automatically
Verify the installation:
kubectl get pods -n cert-manager
kubectl get crds | grep cert-manager

Step 2: Create an Issuer or ClusterIssuer
Issuer: Namespace-scoped, defines certificate issuance and management for resources in a specific namespace.

ClusterIssuer: Cluster-scoped, usable across all namespaces.

Example ClusterIssuer for Let’s Encrypt (Production):
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-production
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: admin@myapp.com
    privateKeySecretRef:
      name: letsencrypt-production-key
    solvers:
    - http01:
        ingress:
          class: "gce"
Explanation:
  server: Let’s Encrypt production endpoint 
  email:   Notification for renewals 
  privateKeySecretRef: Secret to store private key 
 solvers: Domain verification method (http01 via Ingress)


Step 3: Configure Ingress with TLS
Annotate the Ingress resource with the ClusterIssuer:
Example Ingress:
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: myapp-ingress
  annotations:
    kubernetes.io/ingress.class: "gce"
    cert-manager.io/cluster-issuer: "letsencrypt-production"
spec:
  tls:
  - hosts:
    - myapp.com
    secretName: myapp-tls
  rules:
  - host: myapp.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: myapp-service
            port:
              number: 80
Explanation: 
tls.secretName:  Secret where the certificate will be stored 
cert-manager.io/cluster-issuer:  Specifies the Issuer/ClusterIssuer
 Configures routing to the backend service

Step 4: Verify Certificate
kubectl describe certificate myapp-tls -n <namespace>
kubectl get secret myapp-tls -n <namespace>
Cert-Manager automatically manages certificate requests
Certificates renew automatically before expiration

Step 6: Check Certificate and Secret Details
 View the Certificate Resourcev
Cert-Manager creates a Certificate resource for every TLS certificate.

kubectl get certificates -n <namespace>
Example output:
NAME         READY   SECRET NAME   AGE
myapp-tls    True    myapp-tls     10m

Check the Secret
kubectl describe secret myapp-tls -n <namespace>
Or
kubectl get secret myapp-tls -n <namespace> -o yaml

Step 5: Monitoring and Troubleshooting
Check Cert-Manager logs:

kubectl logs -n cert-manager deploy/cert-manager
Common issues:
Incorrect DNS records pointing to Ingress
Mismatched Ingress class
Misconfigured ACME solvers

Reference 🎉
https://cert-manager.io/v1.13-docs/tutorials/getting-started-with-cert-manager-on-google-kubernetes-engine-using-lets-encrypt-for-ingress-ssl
Summary Flow
Install Cert-Manager → CRDs, Deployments, Webhooks
Create Issuer/ClusterIssuer → Connect to Let’s Encrypt
Configure Ingress → Annotate TLS and Issuer
Cert-Manager requests certificate → Secret storage
TLS enabled for workloads
Automatic certificate renewal
This configuration ensures Kubernetes applications are securely HTTPS-enabled, with automated certificate management and renewal.

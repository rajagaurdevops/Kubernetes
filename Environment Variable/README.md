# Kubernetes Environment Variables (Env) Guide

Kubernetes provides **Environment Variables (Env)** as a way to supply external configuration to Pods or containers. Instead of hardcoding configuration inside containers, Env variables make your setup flexible and manageable.

Env variables can come from multiple sources:
- **Literal values** (`value`)
- **ConfigMap** (`valueFrom: configMapKeyRef`)
- **Secret** (`valueFrom: secretKeyRef`)
- **Field references** (Pod metadata like namespace, name, etc.)

---

## Example 1: Literal Env Variables

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: env-demo-pod
spec:
  containers:
    - name: my-container
      image: nginx
      env:
        - name: APP_ENV
          value: "production"
        - name: APP_DEBUG
          value: "false"
```
Explanation:<br>

`APP_ENV` and `APP_DEBUG` environment variables are set inside the container<br>
Access them inside the container, e.g.:
```
echo $APP_ENV
```

## Example 2: Using ConfigMap

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  APP_ENV: "staging"
  APP_DEBUG: "true"
```
Pod Using ConfigMap as Env

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: env-configmap-pod
spec:
  containers:
    - name: my-container
      image: nginx
      env:
        - name: APP_ENV
          valueFrom:
            configMapKeyRef:
              name: app-config
              key: APP_ENV
        - name: APP_DEBUG
          valueFrom:
            configMapKeyRef:
              name: app-config
              key: APP_DEBUG
```

Explanation:

ConfigMap stores the configuration data<br>
Pod YAML uses valueFrom to map ConfigMap keys to environment variables

## Example 3: Using Secret

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: db-secret
type: Opaque
stringData:
  DB_USER: "admin"
  DB_PASSWORD: "mypassword"
```

Pod Using Secret as Env

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: env-secret-pod
spec:
  containers:
    - name: my-container
      image: nginx
      env:
        - name: DB_USER
          valueFrom:
            secretKeyRef:
              name: db-secret
              key: DB_USER
        - name: DB_PASSWORD
          valueFrom:
            secretKeyRef:
              name: db-secret
              key: DB_PASSWORD
```
Explanation:

Sensitive data like database credentials are stored in a Secret<br>
Pod maps Secret keys to environment variables for secure usage inside the container

# Key Points
Env variables provide container-level configuration<br>
Using ConfigMap or Secret increases flexibility and security<br>
Multiple sources can be combined: literal values + ConfigMap + Secret<br>

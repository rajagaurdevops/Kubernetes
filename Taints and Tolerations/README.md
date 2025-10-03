# Taints and Tolerations in Kubernetes
This repository contains practical questions and solutions related to taints and tolerations in Kubernetes. The questions are based on the video tutorial [Link to video](https://youtu.be/y4UarwGKZQQ).

## Question 1: Taint a node with the Noschedule taint effect and set the key-value pair to run: mypod.
Solution: Use the following command to apply the taint to the desired node:
```
kubectl taint nodes <node_name> run=mypod:NoSchedule
```

## Question 2: Create a pod named "test" and check the node on which it is scheduled.
Solution: Use the following command to create the pod and view its scheduled node:
```
kubectl create pod test
kubectl get pod test -o wide
```

## Question 3: Create a pod and add a toleration to it with the following specifications:
### Key: key1
### Operator: Equal
### Value: value1
### Effect: Noschedule
Solution: Use the following YAML definition to create the pod with the toleration:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  containers:
  - name: mycontainer
    image: nginx
tolerations:
- key: key1
  operator: Equal
  value: value1
  effect: NoSchedule
```

### Question 4: Remove the taint effect from the node that was previously tainted.
Solution: Use the following command to remove the taint from the node:
```
kubectl taint nodes <node_name> run=mypod:NoSchedule-
```


_____________________________________________________________________________________________________________________________________________
# Taints
  Node affinity is a Pod property that attracts it to certain nodes (as a preference or a hard requirement)<br>
  Taints work in the opposite way — they allow a node to repel a set of pods

# Tolerations
Applied on pods<br>
   Tolerations allow the scheduler to place pods on nodes that have matching taints<br>
   Important: Tolerations do not guarantee scheduling; the scheduler still considers other constraints

  To add a taint on a node:
  ```
  kubectl taint nodes <node_name> run=mypod:NoSchedule
 ```
# key: key1
# value: value1
# effect: NoSchedule
Meaning: No pod will be scheduled on node1 unless it has a matching toleration.

# Removing a Taint
```
kubectl taint nodes <node_name> run=mypod:NoSchedule-
```
# Adding Tolerations to Pods
  Tolerations are specified in the PodSpec

  ```yaml
    tolerations:
    - key: "key1"
      operator: "Equal"
      value: "value1"
      effect: "NoSchedule"

    - key: "key1"
      operator: "Exists"
      effect: "NoSchedule"
```

Either toleration above matches the taint<br>
The scheduler considers tolerations when selecting a node<br>
If .spec.nodeName is specified manually, the scheduler is bypassed<br>
However, if the node has a NoExecute taint, the kubelet can still evict the pod if there is no matching toleration.

#  Example Pod YAML

```yaml
        apiVersion: v1
        kind: Pod
        metadata:
          name: nginx
          labels:
            env: test
        spec:
          containers:
          - name: nginx
            image: nginx
            imagePullPolicy: IfNotPresent
          tolerations:
          - key: "example-key"
            operator: "Exists"
            effect: "NoSchedule"
```
  # Taint Effects
   1. NoExecute<br>
      Pods already running on the node without toleration → immediately evicted<br>
      Pods with toleration (no tolerationSeconds) → stay bound forever<br>
      Pods with toleration (tolerationSeconds set) → evicted after specified time

   2. NoSchedule<br>
        New pods without matching toleration → not scheduled<br>
        Existing pods are unaffected

   3. PreferNoSchedule<br>
       A "soft" version of NoSchedule<br>
       Scheduler will try to avoid placing the pod but does not guarantee it<br>




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
```
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


# Taint Effects
1. NoExecute
   Pods already running on the node without toleration → immediately evicted.
   Pods with toleration (no tolerationSeconds) → stay bound forever.
   Pods with toleration (tolerationSeconds set) → evicted after specified time.

2. NoSchedule
   New pods without matching toleration → not scheduled.
   Existing pods are unaffected.

3. PreferNoSchedule
   A "soft" version of NoSchedule.
   Scheduler will try to avoid placing the pod but does not guarantee it.
________________________________________________________________________________________________________________________________________
# Taints
  Node affinity is a Pod property that attracts it to certain nodes (as a preference or a hard requirement).
  Taints work in the opposite way — they allow a node to repel a set of pods

# Tolerations
Applied on pods.
   Tolerations allow the scheduler to place pods on nodes that have matching taints.
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

  




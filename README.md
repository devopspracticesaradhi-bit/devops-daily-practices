# Kubernetes Architecture

Kubernetes follows a **master-worker architecture**. The **control plane** manages the cluster, and the **worker nodes** run the workloads.

---

## Control Plane Components
- **API Server**: The entry point for all Kubernetes commands (`kubectl` / REST).
- **etcd**: Key-value store that stores the cluster state and configuration.
- **Controller Manager**: Ensures the desired state matches the actual state (e.g., replicas, node health).
- **Scheduler**: Assigns Pods to Nodes based on resources, affinity, and constraints.

---

## Worker Node Components
- **Kubelet**: Agent on each node; communicates with the API server and manages pods/containers.
- **Kube-Proxy**: Manages networking and load-balancing between pods and services.
- **Container Runtime**: Runs containers (e.g., containerd, CRI-O, Docker).

---

## Diagram

        +--------------------+
        |   Control Plane    |
        |--------------------|
        | API Server         |
        | etcd               |
        | Scheduler          |
        | Controller Manager |
        +--------------------+
                 |
     -----------------------------
     |            |             |
+----------+ +----------+ +----------+
| Worker 1 | | Worker 2 | | Worker 3 |
|----------| |----------| |----------|
| Kubelet  | | Kubelet  | | Kubelet  |
| Kube-Proxy| | Kube-Proxy| | Kube-Proxy|
| Containers| | Containers| | Containers|
+----------+ +----------+ +----------+



---

## Key Points
- The control plane ensures **desired state** is always maintained.
- Worker nodes actually **run the workloads**.
- Communication happens via **API server**.

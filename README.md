Kubernetes + Helm + Terraform – MongoDB Demo Platform

Cloud: AWS
Cluster: Amazon EKS
IaC: Terraform
Package Manager: Helm
Database: MongoDB Community
Application: Python + FastAPI

1. 📌 Project Objective

  The objective of this project is to:
  
  Provision a production-ready Kubernetes cluster using Terraform
  
  Deploy MongoDB Community using Helm with authentication and persistence
  
  Build and deploy a tiny demo application using a custom Helm chart
  
  Securely connect the app to MongoDB using Kubernetes Secrets
  
  Prove functionality using repeatable test cases
  
  Follow real-world DevOps best practices
  
  This project focuses heavily on:
  
  Infrastructure as Code (IaC)
  
  Helm chart authoring
  
  Kubernetes security
  
  Production-grade defaults
  
  Troubleshooting real operational issues

2. 🏗️ High-Level Architecture
  User
    |
    v
  orders-app (Kubernetes Service)
    |
    v
  MongoDB (Helm - Bitnami)
    |
    v
  Persistent EBS Volume (PVC via EBS CSI)
  
  
  Terraform provisions:
  
  VPC with public & private subnets
  
  Internet Gateway & NAT Gateway
  
  Amazon EKS Cluster
  
  Managed Node Group
  
  IAM Roles & Policies
  
  Helm deploys:
  
  MongoDB with authentication and persistence
  
  Demo app using a custom Helm chart

3. 🧰 Technology Stack
  Layer	Tool
  Cloud Provider	AWS
  IaC	Terraform
  Container Runtime	Docker
  Orchestration	Kubernetes (EKS)
  Package Manager	Helm
  Database	MongoDB Community
  App Runtime	Python (FastAPI, Uvicorn)
  Image Registry	AWS ECR

4. ⚙️ Infrastructure Setup (Terraform)
  4.1 Terraform Directory Structure
  infra/
  ├── main.tf
  ├── providers.tf
  ├── variables.tf
  ├── outputs.tf
  ├── terraform.tfvars
  modules/
  ├── vpc/
  └── eks/
  
  4.2 Infrastructure Provisioning
  cd infra
  terraform init
  terraform plan
  terraform apply
  
  
  Terraform creates:
  
  VPC & networking
  
  EKS Cluster
  
  Managed Node Group
  
  Security groups and IAM roles
  
  4.3 Kubernetes Access Configuration
  
  Since Terraform was executed from an EC2 instance using Session Manager, Kubernetes RBAC access was configured using:
  
  ✅ EKS Access Entries
  ✅ AmazonEKSClusterAdminPolicy
  
  This is the modern replacement for aws-auth ConfigMap.

5. 💾 MongoDB Deployment via Helm
  5.1 Helm Chart Used
  
  Bitnami MongoDB Helm chart
  
  Chosen for:
  
  Built-in authentication
  
  Stateful storage
  
  Probes
  
  Enterprise-grade maintenance
  
  5.2 MongoDB Configuration
  
  Key settings:
  
  Authentication enabled
  
  Root password stored in Kubernetes Secret
  
  PersistentVolumeClaim using gp2 StorageClass
  
  Service type: ClusterIP
  
  Liveness and readiness probes enabled
  
  CPU & memory requests/limits set
  
  5.3 MongoDB Deployment
  helm repo add bitnami https://charts.bitnami.com/bitnami
  helm repo update
  
  helm upgrade --install mongo bitnami/mongodb \
    -n mongo \
    -f values.dev.yaml
  
  5.4 MongoDB Verification
  kubectl get pods -n mongo
  kubectl get pvc -n mongo
  kubectl get svc -n mongo
  
  
  ✅ PVC Bound
  ✅ Pod Running
  ✅ Service reachable via:
  
  mongo-mongodb.mongo.svc.cluster.local:27017

6. 🧪 Demo Application Design
  6.1 API Endpoints
  Method	Endpoint	Description
  GET	/healthz	MongoDB connectivity check
  POST	/orders	Insert order into MongoDB
  GET	/orders/count	Fetch order count
  6.2 Application Configuration
  Variable	Source
  MONGO_URI	Kubernetes Secret
  MONGO_DB	Helm values
  MONGO_COLLECTION	Helm values
  6.3 Application Features
  
  Safe Mongo connection using pymongo
  
  Structured one-line logs per request
  
  Kubernetes-ready probes
  
  Environment-driven configuration
  
  Production-friendly resource limits

7. 🐳 Docker & AWS ECR
  7.1 Build Image
  docker build -t orders-app:v1 .
  
  7.2 Push Image to ECR
  aws ecr get-login-password --region us-east-1 \
   | sudo docker login --username AWS --password-stdin <ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com
  
  sudo docker tag orders-app:v1 <ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/orders-app:v1
  
  sudo docker push <ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/orders-app:v1

8. 🚀 Demo App Deployment (Custom Helm Chart)
  8.1 Helm Chart Structure
  helm/orders-app/
  ├── Chart.yaml
  ├── values.yaml
  └── templates/
      ├── deployment.yaml
      └── service.yaml
  
  8.2 App Deployment
  cd helm
  helm upgrade --install orders-app ./orders-app -n mongo
  
  8.3 Verification
  kubectl get pods -n mongo
  kubectl get svc -n mongo
  
  
  ✅ orders-app pod Running
  ✅ orders-app service available

9. ✅ Functional Testing (Acceptance Proof)
  9.1 Port Forward
  kubectl port-forward svc/orders-app -n mongo 8080:80
  
  9.2 API Tests
  curl http://localhost:8080/healthz
  
  curl -X POST http://localhost:8080/orders \
   -H "Content-Type: application/json" \
   -d '{"orderId":"order-001"}'
  
  curl http://localhost:8080/orders/count
  
  9.3 Log Verification
  kubectl logs deploy/orders-app -n mongo
  
  
  Example Output:
  
  method=POST path=/orders status=200 latency_ms=12
  method=GET path=/orders/count status=200 latency_ms=4
  
  
  ✅ Structured logs confirmed
  ✅ All endpoints return 200

10. 🛠️ Major Issues Faced & Resolutions
  Issue 1: Kubernetes Unauthorized Access
  
  Cause: No IAM role mapped
  Fix: Configured EKS Access Entry with AmazonEKSClusterAdminPolicy
  
  Issue 2: MongoDB Pod Stuck in Pending
  
  Cause: EBS CSI Driver missing
  Fix: Installed:
  
  Amazon EBS CSI Driver
  
  EKS Pod Identity Agent
  
  Issue 3: EBS CSI Controller CrashLoopBackOff
  
  Cause: Missing IAM role
  Fix: Created Pod Identity IAM role with AmazonEBSCSIDriverPolicy
  
  Issue 4: Helm YAML Parsing Errors
  
  Cause: Broken indentation in values.yaml
  Fix: Rebuilt entire values.yaml
  
  Issue 5: App Pod ImagePullBackOff
  
  Cause: Image tag v1 not present in ECR
  Fix: Rebuilt and pushed correctly to ECR
  
  Issue 6: no basic auth credentials While Pushing Image
  
  Cause: ECR login without sudo
  Fix: Logged into ECR again using:
  
  aws ecr get-login-password | sudo docker login
  
  Issue 7: Python Virtual Environment Permission Errors
  
  Cause: Project created using sudo
  Fix:
  
  sudo chown -R ssm-user:ssm-user ~/devops-daily-practices

11. 🔐 Security Practices

  No secrets stored in Git
  
  MongoDB password stored in Kubernetes Secret
  
  Pod Identity used for AWS permissions
  
  Secure image pulling from private ECR
  
  Least privilege IAM approach

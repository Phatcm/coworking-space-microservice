# coworking-space-microservice

This project provides a microservice architecture for a coworking space management application, designed to be deployed on AWS using EKS (Elastic Kubernetes Service), Docker, Terraform, and Helm. The application includes several components such as an analytics service, database, and a Kubernetes cluster setup for scaling the infrastructure. This also a part of my Udacity Cloud Devops Nanodegree project.

The README will provide a comprehensive overview of the deployment process and guidance on how to release new builds and deploy changes to environment.

---
## Technologies and Tools Used

- **Linux Environment**: This instruction is based on Linux environment command, if you use window or others please consider the changes.
- **Docker**: Containerizes the microservices to ensure consistent environments across development, testing, and production.
- **Kubernetes**: Manages the deployment and scaling of containerized applications on AWS EKS.
- **AWS EKS**: Provides a managed Kubernetes service for easy deployment and scaling of Kubernetes clusters.
- **Terraform**: Infrastructure as code (IaC) tool used to automate the provisioning and management of the infrastructure, including VPC, EKS, ECR, IAM roles, and more.
- **Helm**: A package manager for Kubernetes used to deploy the `metrics-server` chart for monitoring resource usage in the Kubernetes cluster.
- **AWS CodeBuild**: Continuous integration and build service that automates the process of building and deploying Docker images to Amazon ECR.

---
## Deployment Process
### 1. **Infrastructure Setup with Terraform**
The infrastructure for the coworking space microservice is set up using Terraform. The following resources are provisioned:
- VPC (Virtual Private Cloud)
- EKS Cluster
- ECR (Elastic Container Registry)
- IAM roles for authentication and permissions
- Kubernetes resources (deployments, services, and configs)

To deploy the infrastructure, run the following commands:
```bash
cd terraform
terraform init   # Initialize Terraform and download necessary providers
terraform plan   # Preview the changes Terraform will make
terraform apply  # Apply the infrastructure changes
aws eks --region us-east-1 update-kubeconfig --name terraform-cluster-1 #Update EKS kubeconfig
kubectl config current-context 
kubectl get svc 
```
Once applied, Terraform will create all necessary infrastructure components, including your EKS cluster and VPC.

### 2. **Building and Pushing Docker Images**
Currently the Codebuild is using web hook, so the step to use AWS Codebuild for docker image creation:
- Create Github access token with read & webhook permission in Setting > Developer setting > Fined grain token
- Login into AWS Portal
- Search for AWS Codebuild 
- Select Buil Projects in the left panel
- Update the Github permission by adding the token in Project details > Source
- Press Start Build to trigger the process
- Update ECR image url in k8s/coworking/coworking.yaml

### 3. **Create Database Service**
To deploy Postgresql database to EKS node:
```bash
cd ..
kubectl apply -f k8s/database/pvc.yaml # To deploy volume claim
kubectl apply -f k8s/database/pv.yaml 
kubectl apply -f k8s/postgresql-secret.yaml #create secret for postgresdb credentials
kubectl apply -f k8s/database/postgresql-deployment.yaml
kubectl apply -f k8s/database/postgresql-service.yaml
```
Create initial data for testing purpose:
- Establish the port-forward:
```bash
kubectl port-forward service/postgresql-service 5433:5432 & #forward the postgresql service to local port 5433
```
- Install postgresql:
```bash
apt update
apt install postgresql postgresql-contrib
```
- Connect to the database using psql and execute the sql files:
```bash
psql --host 127.0.0.1 -U myuser -d mydatabase -p 5433
\i src/db/1_create_tables.sql
\i src/db/2_seed_users.sql
\i src/db/3_seed_tokens.sql
```

### 4. **Create Coworking Service**
To deploy coworking service:
```bash
kubectl apply -f k8s/coworking/configmap.yaml   # To deploy volume claim
kubectl apply -f k8s/coworking/coworking.yaml 
kubectl get pod #Check for running pod
curl <lb-url>:5153/api/reports/daily_usage #Test the api route using public loadbalancer address
```


### 5. **Create Horizontal Pod Autoscaler**
To HPA service for coworking:
```bash
kubectl apply -f k8s/autoscaler/hpa.yaml
kubectl get hpa #Check for running pod
```

---
## Troubleshooting
1. In case of pod failure consider those to check for error logs:
```bash
kubectl get pod
kubectl logs <pod_name>
kubectl describe pod <pod_name>
```
2. To drop the infrastructure execute (stand in terraform folder):
```bash
terraform destroy
```
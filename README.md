# 🚀 Retail Store Microservices on Google Kubernetes Engine (GKE)

A production-style, cloud-native **Retail Store Sample Application** deployed on **Google Kubernetes Engine (GKE)**.  
This project demonstrates a real-world **microservices architecture**, Kubernetes best practices, and scalable cloud deployment patterns.

---

## 🧩 Architecture Overview

The application is built using a **loosely coupled microservices architecture**, where each service is independently deployable and scalable.

Client
│
▼
GKE Ingress (Cloud HTTP(S) Load Balancer)
│
▼
Frontend UI Service
│
├── Catalog Service
├── Cart Service
├── Orders Service
└── Checkout Service
│
├── Payment Processing
├── Inventory Validation
└── Order Placement

---

## 🔧 Key Features

### ✅ Microservices Deployment
- Frontend UI service
- Catalog service
- Cart service
- Orders service
- Checkout service

### 📈 Scalability & Performance
- Horizontal Pod Autoscaler (HPA) for auto-scaling based on CPU/memory
- Efficient resource utilization using GKE Compute Classes

### 🔒 Security & Networking
- HTTPS Ingress with TLS termination
- Managed Google Cloud Load Balancer integration
- Isolated Kubernetes namespaces for services

### 🛡️ Reliability & Resilience
- Pod Disruption Budgets (PDB) for zero-downtime upgrades
- Fault-tolerant microservices communication
- Rolling updates with Kubernetes Deployments

---

## ☸️ Kubernetes Deployment Topology


Internet
│
▼
Google Cloud Load Balancer
│
▼
Ingress Controller (GKE)
│
▼
Frontend Pod
│
Microservices Namespace
├── catalog-deployment
├── cart-deployment
├── orders-deployment
└── checkout-deployment


---

## 🚀 Technologies Used

- Google Kubernetes Engine (GKE)
- Kubernetes (Deployments, Services, Ingress, HPA, PDB)
- Docker Containers
- Google Cloud Load Balancer
- HTTPS / TLS Certificates
- Microservices Architecture

---

## 📦 Deployment Highlights

This project demonstrates:

- ✔ Cloud-native microservices deployment on GKE  
- ✔ Kubernetes Ingress-based traffic routing  
- ✔ Auto-scaling with HPA  
- ✔ High availability with PDB  
- ✔ Secure HTTPS communication  
- ✔ Production-grade cluster configuration  

---

## 📊 Learning Outcomes

By building this project, I explored:

- Kubernetes production patterns
- Service decomposition in microservices
- GKE networking & ingress controllers
- Scaling strategies using HPA
- Compute optimization using node provisioning strategies
- End-to-end cloud deployment lifecycle

---

## 📁 Repository Structure (Example)


.
├── k8s/
│ ├── frontend-deployment.yaml
│ ├── catalog-deployment.yaml
│ ├── cart-deployment.yaml
│ ├── orders-deployment.yaml
│ ├── checkout-deployment.yaml
│ ├── ingress.yaml
│ ├── hpa.yaml
│ └── pdb.yaml
├── docker/
├── terraform/ (optional)
└── README.md


---

## 🔮 Future Enhancements

- Add CI/CD pipeline using GitHub Actions or ArgoCD  
- Implement service mesh (Istio / Anthos Service Mesh)  
- Add observability (Prometheus + Grafana + Loki)  
- Implement canary deployments  
- Enable distributed tracing (Jaeger / OpenTelemetry)  

---

## Configurations

kubectl get namespaces --show-labels

kubectl get namespace default --show-labels

kubectl label namespace default cloud.google.com/default-compute-class=retail-cc-spot

kubectl get namespace default  --show-labels

---

## 👨‍💻 Author

**Aslam Chandio**  
Cloud & DevOps Engineer  
Specialized in Kubernetes, GCP, and Cloud-Native Systems

Linkedin: https://www.linkedin.com/in/aslam-chandio/

---

## ⭐ If you like this project

If you found this useful, feel free to ⭐ the repository and connect!

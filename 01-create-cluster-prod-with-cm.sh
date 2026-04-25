#!/bin/bash
set -e

echo "==============================="
echo "STEP-1: Create Prod VPC & Cloud Sql using Terraform"
echo "==============================="
cd p1-vpc-fw-vm-cloudsql-cm-custom-modules/environments/prod
terraform init 
terraform apply -auto-approve

echo
echo "==============================="
echo "STEP-2: Create Prod GKE Cluster using Terraform"
echo "==============================="
cd ../../../p2-gke-private-cluster/environments/prod
terraform init 
terraform apply -auto-approve

echo
echo "==============================="
echo "STEP-4: Configure kubeconfig"
echo "==============================="

# Get the complete kubeconfig command from terraform outputs
cd ../../../p2-gke-private-cluster/environments/prod
KUBECONFIG_CMD=$(terraform output -raw gke_cluster_to_configure_kubectl)

echo "Executing: $KUBECONFIG_CMD"
eval $KUBECONFIG_CMD

echo "✅ Kubeconfig configured successfully!"

# Verify kubeconfig is working by checking nodes
echo "Verifying GKE cluster connectivity..."
if kubectl get nodes > /dev/null 2>&1; then
    echo "✅ Successfully connected to GKE cluster!"
    echo "Current nodes in the cluster:"
    kubectl get nodes
else
    echo "❌ Failed to connect to GKE cluster. Please check your kubeconfig configuration."
    exit 1
fi

# Verify we can access the cluster info
echo
echo "Cluster Info:"
kubectl cluster-info


echo
echo "==============================="
echo "STEP-4.1: Verify kubeconfig connectivity"
echo "==============================="

echo
echo "==============================="
echo "STEP-4.2: Create Namespace for Ingress Resources"
echo "==============================="

kubectl create ns retail-ns

# Wait for Namespace to be ready
echo "Waiting for Namespace to be ready..."
sleep 10


echo
echo "==============================="
echo "STEP-5: Apply Compute Classes Yaml Manifests"
echo "==============================="
cd ../../../p3-computeclass-spot-manifests

kubectl apply -f 01-computeclass-spot.yaml
kubectl label namespace retail-ns cloud.google.com/default-compute-class=retail-cc-spot
kubectl get namespace retail-ns  --show-labels

# Wait for EC2NodeClass to be ready
echo "Waiting for Compute Classes to be ready..."
sleep 10

echo
echo "==============================="
echo "STEP-5: Apply Ingress Yaml Manifests"
echo "==============================="
cd ../p4-ingress-http-to-https-resources

kubectl apply -R -f 01-ingress-all-manifests -n retail-ns
kubectl get pods -n retail-ns
kubectl get ingress -n retail-ns

# Wait for Ingress Resources to be ready
echo "Waiting for Ingress Resources to be ready..."
sleep 10

echo
echo "==============================="
echo "SUMMARY"
echo "==============================="
echo "✅ VPC created successfully"
echo "✅ Cloud Sql created successfully"
echo "✅ GKE Cluster created successfully"

echo
echo "Your Prod GKE Cluster with NAP and ComputeClass is now fully configured and ready to use!"
echo "==============================="

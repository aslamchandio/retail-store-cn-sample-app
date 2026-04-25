#!/bin/bash
set -e

echo
echo "==============================="
echo "STEP-1: Delete Ingress Yaml Manifests"
echo "==============================="
cd p4-ingress-http-to-https-resources

kubectl delete -R -f 01-ingress-all-manifests -n retail-ns

# Wait for EC2NodeClass to be ready
echo "Waiting for Compute Classes to be deleted..."
sleep 10

echo
echo "==============================="
echo "STEP-2: Delete Compute Classes Yaml Manifests"
echo "==============================="
cd ../p3-computeclass-spot-manifests

kubectl delete -f 01-computeclass-spot.yaml 

# Wait for EC2NodeClass to be ready
echo "Waiting for Compute Classes to be deleted..."
sleep 10

echo
echo "==============================="
echo "STEP-2: Delete Namespace retail-ns"
echo "==============================="

kubectl delete ns retail-ns

echo "Waiting for Namespace to be deleted..."
sleep 10

echo
echo "==============================="
echo "STEP-1: Destroy Prod GKE Cluster"
echo "==============================="
cd ../p2-gke-private-cluster/environments/prod
terraform init
terraform destroy -auto-approve
rm -rf .terraform .terraform.lock.hcl
echo "✅ GKE Cluster destroyed"

echo
echo "==============================="
echo "STEP-8: Destroy Prod VPC & CloudSQL"
echo "==============================="
cd ../../../p1-vpc-fw-vm-cloudsql-cm-custom-modules/environments/prod
terraform init
terraform destroy -auto-approve
rm -rf .terraform .terraform.lock.hcl
echo "✅ VPC & CloudSQL destroyed"

echo
echo "==============================="
echo "✅ DESTRUCTION COMPLETE"
echo "==============================="
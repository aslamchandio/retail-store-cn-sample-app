# Resource: Access the configuration of the Google Cloud provider.
data "google_client_config" "default" {}

# HELM Provider
provider "helm" {
  kubernetes = {
    host                   = "https://${google_container_cluster.gke_cluster.endpoint}"
    cluster_ca_certificate = base64decode(google_container_cluster.gke_cluster.master_auth[0].cluster_ca_certificate)
    token                  = data.google_client_config.default.access_token
  }
}

# Terraform Kubernetes Provider
provider "kubernetes" {
  host = "https://${google_container_cluster.gke_cluster.endpoint}"
  cluster_ca_certificate = base64decode(google_container_cluster.gke_cluster.master_auth[0].cluster_ca_certificate)
  token = data.google_client_config.default.access_token
}
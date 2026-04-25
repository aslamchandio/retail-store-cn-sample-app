terraform {
  backend "gcs" {
    bucket = "aslam-tf-bucket"
    prefix = "prod/gke-private-cluster-project"

  }
}


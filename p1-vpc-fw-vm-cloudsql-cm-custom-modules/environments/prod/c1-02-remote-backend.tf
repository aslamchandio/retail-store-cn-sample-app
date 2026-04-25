terraform {
  backend "gcs" {
    bucket = "aslam-tf-bucket"
    prefix = "prod/vpc-fw-vm-natgtw-sql-sm-cidr-project"

  }
}


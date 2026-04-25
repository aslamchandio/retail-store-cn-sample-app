locals {
  mydomain         = "retail.techscloud.store"
  dns_managed_zone = "techscloud-store"
}

############################################
# DNS A Record
############################################


# Resource: Cloud DNS Record Set for A Record
resource "google_dns_record_set" "web_record" {
  project      = var.gcp_project_id
  managed_zone = local.dns_managed_zone
  name         = "${local.mydomain}."
  type         = "A"
  ttl          = 300
  rrdatas      = [google_compute_global_address.ingress_pip3.address]
}

############################################
# Static IP for Load Balancer / Ingress
############################################

resource "google_compute_global_address" "ingress_pip3" {
  name         = "${local.name}-ingress-pip"
  address_type = "EXTERNAL"
  ip_version   = "IPV4"
}



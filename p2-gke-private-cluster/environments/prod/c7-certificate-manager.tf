############################################
# DNS Authorization
############################################

resource "google_certificate_manager_dns_authorization" "web_auth" {
  location    = var.gcp_region_1
  name        = "${local.name}-web-dns-authorization"
  description = "web dns authorization"
  domain      = local.mydomain
}

############################################
# SSL Certificate Certificate manager certificate
############################################

resource "google_certificate_manager_certificate" "web_gcm" {
  location    = var.gcp_region_1
  name        = "${local.name}-web-ssl-certificate"
  description = "SSL certificate for ${local.mydomain}"
  scope       = "DEFAULT"
  labels = {
    env = "${local.name}"
  }
  managed {
    domains = [
      google_certificate_manager_dns_authorization.web_auth.domain
    ]
    dns_authorizations = [
      google_certificate_manager_dns_authorization.web_auth.id
    ]
  }
}

############################################
# DNS Validation Record
############################################

resource "google_dns_record_set" "web_cname" {
  project      = var.gcp_project_id
  managed_zone = local.dns_managed_zone
  name         = google_certificate_manager_dns_authorization.web_auth.dns_resource_record[0].name
  type         = google_certificate_manager_dns_authorization.web_auth.dns_resource_record[0].type
  ttl          = 300
  rrdatas      = [google_certificate_manager_dns_authorization.web_auth.dns_resource_record[0].data]
}

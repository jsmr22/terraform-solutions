
output "certificate_map" {
  value = google_certificate_manager_certificate_map.map.id
}
output "dns_authorization_cnames" {
  description = "CNAMEs to add in your DNS provider"
  value = [
  for dns_auth in google_certificate_manager_dns_authorization.dns_auth : {
    domain       = dns_auth.domain
    cname_name   = dns_auth.dns_resource_record[0].name
    cname_type   = dns_auth.dns_resource_record[0].type
    cname_data   = dns_auth.dns_resource_record[0].data
  }
  ]
}

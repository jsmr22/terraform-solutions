
locals {
  # Para cada certificado, genera una lista de dominios sin wildcards y elimina duplicados
  certificates_base_domains = flatten([
  for cert in var.certificates : [
  for domain in cert.domains : {
    certificate_name = cert.certificate_name
    domain           = replace(domain, "/^\\*\\./", "") # Reemplaza wildcards
  }
  ]
  ])
}

resource "google_certificate_manager_dns_authorization" "dns_auth" {
  for_each = {
  for cert_domain in local.certificates_base_domains :
  "${cert_domain.certificate_name}-${replace(cert_domain.domain, "/[\\*\\.]/", "-")}" => cert_domain
  }

  # Genera un nombre válido para la autorización DNS
  name   = "dns-auth-${replace(each.value.certificate_name, "/[\\*\\.]/", "-")}-${replace(each.value.domain, "/[\\*\\.]/", "-")}"
  domain = each.value.domain # Cada dominio individual
}


resource "google_certificate_manager_certificate" "certificate" {
  for_each = {
  for cert in var.certificates : cert.certificate_name => cert
  }

  name = each.value.certificate_name

  managed {
    domains            = each.value.domains
    dns_authorizations = [for auth in google_certificate_manager_dns_authorization.dns_auth : auth.id]
  }
}

resource "google_certificate_manager_certificate_map" "map" {
  name = var.map_certificate_name
}

resource "google_certificate_manager_certificate_map_entry" "map_entries" {
  # Convierte índices a cadenas y usa toset() para for_each
  for_each = {
  for cert in var.certificates : cert.certificate_name => cert.domains
  }

  # Usa el índice como nombre para asegurar un nombre válido y corto
  name = "entry-${each.key}"

  map          = google_certificate_manager_certificate_map.map.name
  certificates = [google_certificate_manager_certificate.certificate[each.key].id]

  # Usa el índice convertido a número para seleccionar el dominio correspondiente de la lista de dominios
  hostname     = each.value[0] # Se selecciona el primer dominio como ejemplo, puedes ajustarlo
}


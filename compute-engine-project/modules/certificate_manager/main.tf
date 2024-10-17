locals {
  # Reemplaza los wildcards y elimina los duplicados resultantes
  base_domains = distinct([for domain in var.domains : replace(domain, "/^\\*\\./", "")])
}



resource "google_certificate_manager_dns_authorization" "dns_auth" {
  for_each = toset(local.base_domains)

  # Genera un nombre válido para la autorización DNS
  name   = "dns-auth-${replace(each.key, "/[\\*\\.]/", "-")}"
  domain = each.key
}



resource "google_certificate_manager_certificate" "certificate" {
  name = var.certificate_name

  managed {
    domains            = var.domains
    dns_authorizations = [for auth in google_certificate_manager_dns_authorization.dns_auth : auth.id]
  }
}

resource "google_certificate_manager_certificate_map" "map" {
  name = "cert-map-name"
}

resource "google_certificate_manager_certificate_map_entry" "map_entries" {
  # Convierte índices a cadenas y usa toset() para for_each
  for_each = toset([for idx in range(length(var.domains)) : format("%d", idx)])

  # Usa el índice como nombre para asegurar un nombre válido y corto
  name = "entry-${each.key}" # Genera nombres como entry-0, entry-1, ...

  map          = google_certificate_manager_certificate_map.map.name
  certificates = [google_certificate_manager_certificate.certificate.id]

  # Usa el índice convertido a número para seleccionar el dominio correspondiente de la lista de dominios
  hostname     = var.domains[tonumber(each.key)]
}

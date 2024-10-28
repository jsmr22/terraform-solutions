locals {
  # Procesamos las reglas de firewall y reemplazamos los alias con direcciones IP reales
  firewall_rules_processed = [
  for rule in var.firewall_rules : {
    firewall_name        = rule.firewall_name
    network_name         = rule.network_name
    allowed_external_ips = [
    for ip in rule.allowed_external_ips : (
    contains(keys(var.ip_alias_map), ip) ? var.ip_alias_map[ip] : ip
    )
    ]
    allowed_protocols    = rule.allowed_protocols
    tags                 = rule.tags
    direction            = rule.direction
    priority             = rule.priority
    description          = rule.description
  }
  ]
}


resource "google_compute_firewall" "firewall_rules" {
  for_each = { for rule in local.firewall_rules_processed : rule.firewall_name => rule }

  name        = each.value.firewall_name
  network     = each.value.network_name
  direction   = each.value.direction
  priority    = each.value.priority
  description = each.value.description

  # Usamos las IPs procesadas donde los alias ya fueron reemplazados
  source_ranges = each.value.allowed_external_ips

  # Protocolo y puertos permitidos
  dynamic "allow" {
    for_each = each.value.allowed_protocols
    content {
      protocol = allow.value.protocol
      ports    = allow.value.ports
    }
  }

  target_tags = each.value.tags
}


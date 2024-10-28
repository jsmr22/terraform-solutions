resource "google_compute_security_policy" "cloud_armor" {
  for_each = { for policy in var.cloud_armor_policies : policy.policy_name => policy }

  name        = each.value.policy_name
  description = "Política de seguridad para Cloud Armor"

  dynamic "rule" {
    for_each = each.value.allowed_ips
    content {
      action   = "allow"
      priority = 1000 + index(each.value.allowed_ips, rule.value)

      match {
        versioned_expr = "SRC_IPS_V1"
        config {
          src_ip_ranges = [rule.value]
        }
      }
    }
  }

  # Agregar la regla predeterminada para manejar el tráfico que no coincida con las reglas anteriores
  rule {
    description = "Default deny rule"
    action      = "deny(403)"  # Bloquear el tráfico que no coincida
    priority    = 2147483647   # Prioridad predeterminada para reglas en Cloud Armor

    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]  # Aplicar a cualquier IP
      }
    }
  }
}


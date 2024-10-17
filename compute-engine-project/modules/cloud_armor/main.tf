
resource "google_compute_security_policy" "default" {
  name   = var.cloud_armor_policy_name
  description = "Policy to protect my application"

  rule {
    action = "allow"
    priority = 1000
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = var.load_balancer_allowed_ips
      }
    }
  }

  rule {
    action = "deny(403)"
    priority = 2147483647
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
  }
}


output "cloud_armor_policy" {
  value = "${google_compute_security_policy.default.self_link}"
}
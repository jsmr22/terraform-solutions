resource "google_compute_firewall" "default" {
  name    = var.firewall_name
  network = var.network_name
  source_ranges=var.allowed_external_ips

  dynamic "allow" {
    for_each = var.allowed_protocols
    content {
      protocol = allow.value
      ports    = var.allowed_ports
    }
  }
  source_tags = ["bastion"]
  priority = 1000
}
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = var.network_name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["bastion"]
  priority=900
}
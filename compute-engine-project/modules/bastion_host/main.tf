
resource "google_compute_instance" "bastion_host" {
  name         = var.bastion_host_name
  machine_type = var.bastion_host_machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.bastion_host_machine_image
    }
  }

  network_interface {
    subnetwork = var.subnetwork_name
    access_config {}
  }

  tags = ["bastion"]
}

# Create a VPC network
resource "google_compute_network" "vpc_network" {
  project=var.project_id
  name=var.network_name
  auto_create_subnetworks = false
}
resource "google_compute_subnetwork" "private_subnet" {
  name          = "${var.compute_subnetwork_name}-private"
  ip_cidr_range = var.compute_subnetwork_range_private
  network       = google_compute_network.vpc_network.id
  region        = var.region
}
resource "google_compute_subnetwork" "bastion_subnet" {
  name          = "${var.compute_subnetwork_name}-bastion"
  ip_cidr_range = var.compute_subnetwork_range_public
  network       = google_compute_network.vpc_network.id
  region        = var.region

}

resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-db-peering"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc_network.id
}
resource "google_service_networking_connection" "default" {
  network                 = google_compute_network.vpc_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}
resource "google_compute_global_address" "ip" {
  name = var.external_ip_name
}


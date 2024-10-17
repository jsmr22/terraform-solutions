resource "google_compute_router" "nat_router" {
  count = var.cloud_nat_enable ? 1 : 0
  name    = "nat-router"
  network = var.network_name
  region  = var.region
}
resource "google_compute_router_nat" "nat_config" {
  count = var.cloud_nat_enable ? 1 : 0
  name   = "nat-config"
  router = google_compute_router.nat_router[count.index].name
  region = var.region

  nat_ip_allocate_option = "AUTO_ONLY"

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
  name                    = var.subnetwork_name
  source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}

resource "google_compute_router" "nat_router" {
  for_each = { for nat in var.cloud_nat : nat.name => nat }

  name    = "${each.value.name}-router"
  network = each.value.network
  region  = each.value.region
}

resource "google_compute_router_nat" "nat_config" {
  for_each = { for nat in var.cloud_nat : nat.name => nat }
  depends_on = [google_compute_router.nat_router]

  name   = each.value.name
  router = google_compute_router.nat_router[each.key].name
  region = each.value.region

  nat_ip_allocate_option = each.value.ip_allocate_option
  nat_ips=each.value.static_ip
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = each.value.subnet
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}
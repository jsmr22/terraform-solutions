locals {
  flattened_subnets = flatten([
  for net in var.networks : [
  for subnet in net.subnets : {
    name      = subnet.name
    region    = subnet.region
    cidr_range = subnet.cidr_range
    network   = net.name
  }
  ]
  ])
}

resource "google_compute_network" "vpc_network" {
  for_each = { for net in var.networks : net.name => net }

  project                = var.project_id
  name                   = each.value.name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  for_each = { for s in local.flattened_subnets : s.name => s }
  depends_on = [google_compute_network.vpc_network]

  name          = each.value.name
  ip_cidr_range = each.value.cidr_range
  network       = each.value.network
  region        = each.value.region
}

resource "google_compute_global_address" "independent_global_address" {
  for_each = { for addr in var.ip_addresses : addr.name => addr if addr.region == "" }
  depends_on = [google_compute_network.vpc_network]

  name          = each.value.name
  address_type  = each.value.address_type
  prefix_length = each.value.prefix_length
}
resource "google_compute_address" "independent_regional_address" {
  for_each = { for addr in var.ip_addresses : addr.name => addr if addr.region != "" }
  depends_on = [google_compute_network.vpc_network]

  name          = each.value.name
  address_type  = each.value.address_type
  prefix_length = each.value.prefix_length
  region        = each.value.region   # Aquí se usa la región para IPs regionales
}

resource "google_vpc_access_connector" "connector" {
  for_each = { for connector in var.vpc_connectors : connector.name => connector}
  depends_on = [google_compute_subnetwork.subnet]

  name          = each.value.name
  subnet {
    name = each.value.subnet
  }
  machine_type = each.value.machine_type
  min_instances = each.value.min_instances
  max_instances = each.value.max_instances
}



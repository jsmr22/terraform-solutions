output "network_id" {
  value = "${google_compute_network.vpc_network.id}"
}
output "network_name" {
  value = "${google_compute_network.vpc_network.name}"
}
output "subnetwork_name" {
  value = "${google_compute_subnetwork.private_subnet.name}"
}
output "subnetwork_bastion_name" {
  value = "${google_compute_subnetwork.bastion_subnet.name}"
}
output "external_ip" {
  value = "${google_compute_global_address.ip.address}"
}
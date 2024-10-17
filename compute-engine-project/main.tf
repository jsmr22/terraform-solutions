

module "network" {
  source = "./modules/network"
  network_name=var.network_name
  region=var.region
  project_id=var.project_id
  compute_subnetwork_range_private=var.compute_subnetwork_range_private
  compute_subnetwork_range_public=var.compute_subnetwork_range_public
  external_ip_name=var.external_ip_name
  compute_subnetwork_name=var.compute_subnetwork_name
}

module "firewall" {
  source       = "./modules/firewall"
  network_name = module.network.network_name
  allowed_ports=var.allowed_ports
  allowed_protocols=var.allowed_protocols
  firewall_name=var.firewall_name
  allowed_external_ips=var.allowed_external_ips
}


module "service_account"{
  source = "./modules/service_account"
  account_name=var.account_name
  display_name=var.display_name
  project_id=var.project_id
  depends_on = [module.network]
  iam_roles=var.iam_roles
  key_rotation_time=var.key_rotation_time
}

module "database" {
  source = "./modules/database"
  database_enable=var.database_enable
  db_name=var.db_name
  db_region=var.db_region
  db_version=var.db_version
  db_size=var.db_size
  db_availability_type=var.db_availability_type
  database_tier=var.database_tier
  network_id=module.network.network_id
  project_id=var.project_id
  db_zone=var.zone


  depends_on = [module.service_account]
}

module "bastion_host" {
  source = "./modules/bastion_host"
  count = var.bastion_host_enable ? 1 : 0
  bastion_host_name=var.bastion_host_name
  bastion_host_machine_type=var.bastion_host_machine_type
  bastion_host_machine_image=var.bastion_host_machine_image
  subnetwork_name=module.network.subnetwork_bastion_name
  zone=var.zone
}

module "compute_engine" {
  source = "./modules/compute_engine"
  zones_instance_count=var.zones_instance_count
  compute_engine_name="${var.compute_engine_name}"
  compute_engine_type=var.compute_engine_type
  compute_engine_zone=var.zone
  project_id=var.project_id
  boot_disk_os=var.boot_disk_os
  boot_disk_size=var.boot_disk_size
  subnetwork_name=module.network.subnetwork_name
  compute_engine_additional_disk_name="${var.compute_engine_name}-additional-disk"
  compute_engine_additional_disk_type=var.compute_engine_additional_disk_type
  compute_engine_additional_disk_size=var.compute_engine_additional_disk_size
  metadata_startup_script=var.metadata_startup_script
}

module "certificate_manager" {
  source = "./modules/certificate_manager"
  count = var.certificate_manager_enable ? 1 : 0
  certificate_name=var.certificate_name
  domains = var.domains
}

module "cloud_armor" {
  source = "./modules/cloud_armor"
  cloud_armor_policy_name=var.cloud_armor_policy_name
  load_balancer_allowed_ips=var.load_balancer_allowed_ips
}

module "load_balancer" {
  source = "./modules/load_balancer"
  external_ip=module.network.external_ip
  zone                = var.zone
  certificate=var.certificate_manager_enable ? module.certificate_manager[0].certificate_map : ""
  url_paths=var.url_paths
  health_checks=var.health_checks
  cloud_armor_policy=module.cloud_armor.cloud_armor_policy
  load_balancer_name=var.load_balancer_name
  logging_enable=var.logging_enable
  logging_sample_rate=var.logging_sample_rate
  instance_groups=[for link in module.compute_engine.self_links : link]
}

module "cloud_nat" {
  source = "./modules/cloud_nat"
  cloud_nat_enable=var.cloud_nat_enable
  region=var.region
  subnetwork_name=module.network.subnetwork_name
  network_name=module.network.network_name
}






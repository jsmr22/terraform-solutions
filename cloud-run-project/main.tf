

module "network" {
  source = "./modules/network"
  networks=var.networks
  project_id=var.project_id
  ip_addresses = var.ip_addresses
  vpc_connectors=var.vpc_connectors
}

module "cloud_nat" {
  source = "./modules/cloud_nat"
  count           = var.cloud_nat_enable ? 1 : 0
  cloud_nat=var.cloud_nat
  depends_on = [module.network]
}

module "firewall" {
  source       = "./modules/firewall"
  count           = var.firewall_enable ? 1 : 0
  ip_alias_map = module.network.global_addresses
  firewall_rules=var.firewall_rules
  depends_on = [module.network]
}
module "memorystore" {
  source = "./modules/memorystore"
  count           = var.memorystore_enable ? 1 : 0
  memorystore=var.memorystore
  depends_on = [module.network]
}

module "cloud_run" {
  source = "./modules/cloud_run"
  count           = var.cloud_run_enable ? 1 : 0
  memorystore_host=var.memorystore_enable ? module.memorystore[0].redis_instance_ip : ""
  project_id=var.project_id
  cloud_run_services=var.cloud_run_services
  depends_on = [module.network,module.memorystore,module.cloud_armor]
}

module "certificate_manager" {
  source = "./modules/certificate_manager"
  count = var.certificate_manager_enable ? 1 : 0
  map_certificate_name=var.map_certificate_name
  certificates=var.certificates
}
module "cloud_armor" {
  source = "./modules/cloud_armor"
  count           = var.cloud_armor_enable ? 1 : 0
  cloud_armor_policies=var.cloud_armor_policies
}

module "load_balancer" {
  source = "./modules/load_balancer"
  count           = var.load_balancer_enable ? 1 : 0
  load_balancers=var.load_balancers
  project_id = var.project_id
  depends_on = [module.certificate_manager,module.cloud_run]
}

/*
module "service_account"{
  source = "./modules/service_account"
  account_name=var.account_name
  display_name=var.display_name
  project_id=var.project_id
  depends_on = [module.network]
  iam_roles=var.iam_roles
  key_rotation_time=var.key_rotation_time
}

module "cloud_armor" {
  source = "./modules/cloud_armor"
  cloud_armor_policy_name=var.cloud_armor_policy_name
  load_balancer_allowed_ips=var.load_balancer_allowed_ips
}
*/





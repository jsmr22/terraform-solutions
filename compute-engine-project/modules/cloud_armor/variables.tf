# Variable para la lista de IPs permitidas para el balanceador de carga en las reglas de firewall
variable "load_balancer_allowed_ips" {
  description = "Lista de IPs externas permitidas para las reglas de firewall del balanceador de carga."
  type        = list(string)
}

# Variable para el nombre de la política de Cloud Armor
variable "cloud_armor_policy_name" {
  description = "Nombre de la política de Cloud Armor."
  type        = string
}

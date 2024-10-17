# Variable para el nombre de la subred que permitirá Cloud NAT
variable "subnetwork_name" {
  description = "Subred para permitir el Cloud NAT."
  type        = string
}

# Variable para el nombre de la red asociada al Cloud NAT
variable "network_name" {
  description = "Red asociada al Cloud NAT."
  type        = string
}

# Variable para la región en la que se desplegará Cloud NAT
variable "region" {
  description = "Región donde se desplegará el Cloud NAT."
  type        = string
}

# Variable para habilitar o deshabilitar Cloud NAT
variable "cloud_nat_enable" {
  description = "Indica si Cloud NAT estará habilitado (true) o no (false)."
  type        = bool
}

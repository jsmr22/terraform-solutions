# Variable para el nombre de la red
variable "network_name" {
  description = "Nombre de la red asociada a las reglas de firewall."
  type        = string
}

# Variable para la lista de puertos permitidos en las reglas de firewall
variable "allowed_ports" {
  description = "Lista de puertos permitidos para las reglas de firewall."
  type        = list(string)
}

# Variable para la lista de protocolos permitidos en las reglas de firewall
variable "allowed_protocols" {
  description = "Lista de protocolos permitidos para las reglas de firewall."
  type        = list(string)
}

# Variable para el nombre de la regla de firewall
variable "firewall_name" {
  description = "Nombre de la regla de firewall."
  type        = string
}

# Variable para la lista de IPs externas permitidas en las reglas de firewall
variable "allowed_external_ips" {
  description = "Lista de IPs externas permitidas para las reglas de firewall."
  type        = list(string)
}

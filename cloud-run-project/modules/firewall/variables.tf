variable "firewall_rules" {
  description = "List of firewall rules"
  type = list(object({
    firewall_name        = string
    network_name         = string
    allowed_external_ips = list(string)
    allowed_protocols    = list(object({
      protocol = string
      ports    = list(string)
    }))
    tags                 = list(string) # Etiquetas opcionales para aplicar la regla a instancias específicas
    direction            = string       # INGRESS (entrada) o EGRESS (salida)
    priority             = number       # Prioridad de la regla de firewall
    description          = string       # Descripción opcional de la regla
  }))
  default = []
}
variable "ip_alias_map" {
  description = "Map of alias to IP addresses from the network module"
  type        = map(string)
}




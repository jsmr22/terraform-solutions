# Variable "networks" define una lista de redes VPC con sus respectivas subredes.
variable "networks" {
  description = "Lista de redes VPC con sus subredes"
  type = list(object({
    name = string                      # Nombre de la red VPC
    subnets      = list(object({       # Lista de subredes dentro de la VPC
      name        = string             # Nombre de la subred
      cidr_range  = string             # Rango de direcciones IP (CIDR)
      subnet_type = string             # Tipo de subred: 'private' o 'public'
      region       = string            # Región de la subred
    }))
  }))
}
variable "project_id" {
  type        = string
  description = "ID del proyecto de GCP."
}

# Variable "global_addresses" define una lista de direcciones IP globales que pueden ser usadas dentro de la configuración de recursos de red en Google Cloud.
variable "ip_addresses" {
  description = "Lista de direcciones IP globales"
  type = list(object({
    name          = string            # Nombre de la dirección IP global
    address_type  = string            # Tipo de dirección ('INTERNAL' o 'EXTERNAL')
    prefix_length = number            # Longitud del prefijo CIDR (solo para direcciones internas)
    region=string
  }))
}

variable "vpc_connectors" {
  description = "List of VPC connectors"
  type = list(object({
    name         = string
    subnet       = string
    machine_type = string
    min_instances = number
    max_instances = number
  }))
}


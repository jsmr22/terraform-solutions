variable "cloud_nat" {
  description = "List of Cloud NAT configurations"
  type = list(object({
    name               = string
    network            = string
    region             = string
    subnet             = string
    ip_allocate_option = string
    static_ip          = list(string)
  }))
  default = []
}


# Variable para habilitar o deshabilitar Cloud NAT


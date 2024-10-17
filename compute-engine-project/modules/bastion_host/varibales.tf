# Variable para el nombre de la subred
variable "subnetwork_name" {
  description = "Nombre de la subred dentro de la VPC en la que se desplegarán las instancias de Compute Engine."
  type        = string
}

# Variable para especificar la zona de despliegue
variable "zone" {
  description = "Zona en la que se desplegarán los recursos."
  type        = string
}

# Variable para el nombre del bastion host
variable "bastion_host_name" {
  description = "Nombre de la instancia de bastion host."
  type        = string
}

# Variable para el tipo de máquina del bastion host
variable "bastion_host_machine_type" {
  description = "Tipo de máquina que se utilizará para el bastion host."
  type        = string
}

# Variable para la imagen de máquina del bastion host
variable "bastion_host_machine_image" {
  description = "Imagen de máquina que se utilizará para el bastion host."
  type        = string
}

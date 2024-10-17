# Variable para el ID del proyecto de Google Cloud
variable "project_id" {
  description = "ID del proyecto de GCP."
  type        = string
}

# Variable para la región de la red
variable "region" {
  description = "Región de la red."
  type        = string
}

# Variable para el nombre de la red
variable "network_name" {
  description = "Nombre de la red."
  type        = string
}

# Variable para el nombre de la subred
variable "compute_subnetwork_name" {
  description = "Nombre de la subred."
  type        = string
}

# Variable para el rango de IPs privadas de la subred
variable "compute_subnetwork_range_private" {
  description = "Rango de la subred para IPs privadas."
  type        = string
}

# Variable para el rango de IPs públicas de la subred
variable "compute_subnetwork_range_public" {
  description = "Rango de la subred para IPs públicas."
  type        = string
}

# Variable para el nombre de la IP externa
variable "external_ip_name" {
  description = "Nombre de la IP externa."
  type        = string
}

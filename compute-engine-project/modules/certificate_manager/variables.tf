# Variable para la lista de dominios del certificado gestionado
variable "domains" {
  description = "Lista de dominios para el certificado gestionado."
  type        = list(string)
}

# Variable para el nombre del certificado
variable "certificate_name" {
  description = "Nombre del certificado gestionado."
  type        = string
}

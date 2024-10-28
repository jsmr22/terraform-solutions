# Variable para el ID del proyecto de Google Cloud
variable "project_id" {
  description = "ID del proyecto de GCP."
  type        = string
}

# Variable para el nombre de la cuenta de servicio
variable "account_name" {
  description = "Nombre de la cuenta de servicio."

  # Validación para asegurar que el nombre de la cuenta cumpla con los requisitos
  validation {
    condition     = can(regex("[a-z]([-a-z0-9]*[a-z0-9])", var.account_name)) && length(var.account_name) >= 6 && length(var.account_name) <= 30
    error_message = "El valor de account_name debe ser un nombre válido, comenzando con \"[a-z]([-a-z0-9]*[a-z0-9])\", y debe tener entre 6 y 30 caracteres."
  }
  type        = string
}

# Variable para el nombre para mostrar de la cuenta de servicio
variable "display_name" {
  description = "Nombre para mostrar de la cuenta de servicio."
  type        = string
}

# Variable para la lista de roles de IAM a asignar a la cuenta de servicio
variable "iam_roles" {
  description = "Lista de roles de GCP a asignar a la cuenta de servicio."
  type        = list(string)
}

# Variable para el tiempo de rotación de la clave de la cuenta de servicio en días
variable "key_rotation_time" {
  description = "Número de días predeterminados para la rotación de la clave de la cuenta de servicio."
  type        = number
}

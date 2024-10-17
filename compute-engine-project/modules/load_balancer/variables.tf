# Variable para la zona donde se desplegarán los recursos
variable "zone" {
  description = "Zona de despliegue para los recursos."
  type        = string
}

# Variable para la lista de rutas en el URL Map
variable "url_paths" {
  description = "Lista de rutas para el URL Map. Todas las rutas apuntan al mismo backend service."
  type        = list(string)
}

# Variable para la IP externa
variable "external_ip" {
  description = "IP externa asignada al balanceador de carga."
  type        = string
}

# Variable para el certificado SSL
variable "certificate" {
  description = "Certificado SSL utilizado por el balanceador de carga."
  type        = string
}

# Variable para la política de Cloud Armor
variable "cloud_armor_policy" {
  description = "Política de Cloud Armor asociada al balanceador de carga."
  type        = string
}

# Variable para los grupos de instancias
variable "instance_groups" {
  description = "Lista de grupos de instancias que forman parte del backend del balanceador de carga."
  type        = list(string)
}

# Variable para los health checks con sus parámetros
variable "health_checks" {
  description = "Lista de health checks con sus parámetros."
  type        = list(object({
    name         = string  # Nombre del health check
    request_path = string  # Ruta de la solicitud utilizada para el health check
    port         = number  # Puerto utilizado para el health check
  }))
}

# Variable para el nombre del balanceador de carga
variable "load_balancer_name" {
  description = "Nombre del balanceador de carga."
  type        = string
}
# Variable para habilitar el logging en el backend service
variable "logging_enable" {
  description = "Habilita o deshabilita el logging del backend service. Debe ser 'true' para activar el registro de solicitudes."
  type        = bool
}

# Variable para la tasa de muestreo del logging
variable "logging_sample_rate" {
  description = "Define la tasa de muestreo del logging para el backend service. Un valor de 1.0 registra el 100% de las solicitudes; un valor más bajo registra una fracción de ellas."
  type        = number
}
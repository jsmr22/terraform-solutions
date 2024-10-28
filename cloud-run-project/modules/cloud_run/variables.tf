variable "cloud_run_services" {
  description = "List of Cloud Run services configurations, each with multiple containers"
  type = list(object({
    name                  = string
    backend_name=string
    backend_security_policy=string
    region                = string
    memory                = string
    ingress=string
    deletion_protection=bool
    min_instances=number
    max_instances         = number
    cpu                   = optional(number, 1)   # Número de CPUs, por defecto 1
    concurrency           = optional(number, 80)  # Número de solicitudes concurrentes, por defecto 80
    allow_unauthenticated = optional(bool, false) # Permitir acceso no autenticado, por defecto no
    environment_variables = optional(map(string), {}) # Variables de entorno a nivel de servicio, por defecto vacío
    vpc_connector         = optional(string, null)  # Conector VPC opcional
    vpc_egress_settings   = optional(string, "all-traffic") # Control de egress, valores: ALL_TRAFFIC o PRIVATE_RANGES_ONLY
    timeout_seconds       = optional(number, 300)   # Timeout, por defecto 300 segundos
    service_account       = optional(string, null)  # Cuenta de servicio opcional
    revision_name         = optional(string, null)  # Nombre de la revisión, opcional
    backend_service_protocol=string
    traffic               = optional(list(object({
      type   = string
      revision=optional(string, null)
      percent      = number
    })), [])
    containers = list(object({
      name                  = string                  # Nombre del contenedor
      image                 = string                  # Imagen del contenedor
      container_port        = optional(number, 8080)  # Puerto del contenedor, por defecto 8080
      environment_variables = optional(map(string), {}) # Variables de entorno para el contenedor, por defecto vacío
      secrets               = optional(list(object({
        secret_name   = string
        env_name      = string
        secret_version = string # Versión del secret, por ejemplo, 'latest'
      })), []) # Secretos específicos para el contenedor
    }))
  }))
}
variable "project_id" {
  type        = string
  description = "ID del proyecto de GCP."
}
variable "memorystore_host" {
  type        = string
}
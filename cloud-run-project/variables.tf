# ID del proyecto de GCP
variable "project_id" {
  type        = string
  description = "ID del proyecto de GCP."
}

# Región predeterminada para los recursos
variable "region" {
  type        = string
  description = "Región predeterminada para los recursos de GCP."
}

# Zona predeterminada para los recursos
variable "zone" {
  type        = string
  description = "Zona predeterminada para los recursos de GCP."
}

variable "networks" {
  description = "Lista de redes VPC con sus subredes"
  type = list(object({
    name = string
    subnets      = list(object({
      name        = string
      cidr_range  = string
      region       = string
      subnet_type = string   # Puede ser 'private' o 'public' para diferenciar
    }))
  }))
}

variable "ip_addresses" {
  description = "Lista de direcciones IP globales"
  type = list(object({
    name = string
    address_type = string
    prefix_length = number
    region=string
  }))
}

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
variable "cloud_nat_enable" {
  description = "Indica si Cloud NAT estará habilitado (true) o no (false)."
  type        = bool
}

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
variable "firewall_enable" {
  description = "Indica si Cloud NAT estará habilitado (true) o no (false)."
  type        = bool
}
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

variable "cloud_run_enable" {
  description = "Indica si Cloud RUN estará habilitado (true) o no (false)."
  type        = bool
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
variable "memorystore_enable" {
  description = "Indica si Cloud RUN estará habilitado (true) o no (false)."
  type        = bool
}
variable "memorystore" {
  description = "List of Memorystore instances"
  type = list(object({
    name               = string
    tier               = string
    memory_size_gb     = number
    region             = string
    zone               = string
    redis_version      = string
    authorized_network = string
  }))
}
variable "certificates" {
  type = list(object({
    certificate_name = string
    domains          = list(string)
  }))
}
variable "certificate_manager_enable" {
  description = "Indica si el certificate manager estará habilitado (true) o no (false)."
  type        = bool
}

variable "load_balancers" {
  type = list(object({
    load_balancer_name     = string
    ip_address=string
    logging_enable         = bool
    logging_sample_rate    = number
    map_certificate        = string
    default_backend_service = string
    http_rule              = bool
    https_rule             = bool
    certificate            = string

    host_rules = list(object({
      domain = list(string)
      name=string
      path_rules = list(object({
        path    = list(string)
        backend = string
        rewrite = object({
          enabled = bool          # Si queremos aplicar el rewrite
          rewrite_to = string     # A qué path queremos reescribir
        })
      }))
    }))
  }))
}


variable "load_balancer_enable" {
  description = "Indica si el load balancer estará habilitado (true) o no (false)."
  type        = bool
}
variable "map_certificate_name" {

  type        = string
}
variable "cloud_armor_policies" {
  description = "Lista de políticas de Cloud Armor con los nombres de política y las IPs permitidas."
  type = list(object({
    policy_name = string
    allowed_ips = list(string)
  }))
}
variable "cloud_armor_enable" {
  description = "Indica si el cloud armor estará habilitado (true) o no (false)."
  type        = bool
}

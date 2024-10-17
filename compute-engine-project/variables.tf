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

# Nombre de la red
variable "network_name" {
  type        = string
  description = "Nombre de la red en la que se despliegan los recursos."
}

# Nombre de la cuenta de servicio
variable "account_name" {
  type        = string
  description = "Nombre de la cuenta de servicio."
}

# Nombre para mostrar de la cuenta de servicio
variable "display_name" {
  type        = string
  description = "Nombre para mostrar de la cuenta de servicio."
}

# Habilitar o deshabilitar la base de datos
variable "database_enable" {
  type        = bool
  description = "Si es true, se crea la base de datos; si es false, no se crea."
}

# Nombre de la base de datos
variable "db_name" {
  type        = string
  description = "Nombre de la base de datos."
}

# Región de la base de datos
variable "db_region" {
  type        = string
  description = "Región donde se desplegará la base de datos."
}

# Versión de la base de datos
variable "db_version" {
  type        = string
  description = "Versión de la base de datos (por ejemplo, 'MYSQL_5_7')."
}

# Tamaño de la base de datos en GB
variable "db_size" {
  type        = number
  description = "Tamaño de la base de datos en GB."
}

# Tipo de disponibilidad de la base de datos
variable "db_availability_type" {
  type        = string
  description = "Tipo de disponibilidad de la base de datos (por ejemplo, 'ZONAL', 'REGIONAL')."
}

# Especificaciones de la base de datos
variable "database_tier" {
  type        = string
  description = "Especificaciones de la base de datos (por ejemplo, 'db-f1-micro')."
}

# Lista de roles de IAM a asignar a la cuenta de servicio
variable "iam_roles" {
  type        = list(string)
  description = "Lista de roles de GCP a asignar a la cuenta de servicio."
}

# Tamaño del disco de arranque en GB para las instancias de Compute Engine
variable "boot_disk_size" {
  type        = string
  description = "Tamaño del disco de arranque en GB para las instancias de Compute Engine."
}

# Sistema operativo del disco de arranque para las instancias de Compute Engine
variable "boot_disk_os" {
  type        = string
  description = "Sistema operativo del disco de arranque para las instancias de Compute Engine."
}

# Nombre de la instancia de Compute Engine
variable "compute_engine_name" {
  type        = string
  description = "Nombre de la instancia de Compute Engine."
}

# Tipo de máquina para la instancia de Compute Engine
variable "compute_engine_type" {
  type        = string
  description = "Tipo de máquina para la instancia de Compute Engine (por ejemplo, 'n1-standard-1')."
}

# Nombre de la subred dentro de la VPC
variable "compute_subnetwork_name" {
  type        = string
  description = "Nombre de la subred dentro de la VPC en la que se desplegarán las instancias de Compute Engine."
}

# Rango de la subred para IPs privadas
variable "compute_subnetwork_range_private" {
  type        = string
  description = "Rango de la subred para IPs privadas."
}

# Rango de la subred para IPs públicas
variable "compute_subnetwork_range_public" {
  type        = string
  description = "Rango de la subred para IPs públicas."
}

# Nombre de la IP externa
variable "external_ip_name" {
  type        = string
  description = "Nombre de la IP externa asociada a los recursos."
}

# Lista de puertos permitidos para las reglas de firewall
variable "allowed_ports" {
  type        = list(string)
  description = "Lista de puertos permitidos para las reglas de firewall."
}

# Lista de IPs externas permitidas para las reglas de firewall
variable "allowed_external_ips" {
  type        = list(string)
  description = "Lista de IPs externas permitidas para las reglas de firewall."
}

# Lista de protocolos permitidos para las reglas de firewall
variable "allowed_protocols" {
  type        = list(string)
  description = "Lista de protocolos permitidos para las reglas de firewall."
}

# Días predeterminados para rotar la clave de la cuenta de servicio
variable "key_rotation_time" {
  type        = number
  description = "Número de días predeterminados para la rotación de la clave de la cuenta de servicio."
}

# Si es true, se habilita Cloud NAT; si es false, no se habilita
variable "cloud_nat_enable" {
  type        = bool
  description = "Si es true, se habilita Cloud NAT; si es false, no se habilita."
}

# Nombre del firewall
variable "firewall_name" {
  type        = string
  description = "Nombre de la regla de firewall."
}

# Lista de rutas para el URL Map
variable "url_paths" {
  type        = list(string)
  description = "Lista de rutas para el URL Map. Todas las rutas apuntan al mismo backend service."
}

# Script de inicio que se ejecutará al iniciar la instancia de Compute Engine
variable "metadata_startup_script" {
  type        = string
  description = "Script de inicio que se ejecutará al iniciar la instancia de Compute Engine."
}

# Mapa de zonas y el número de instancias por zona
variable "zones_instance_count" {
  type        = map(number)
  description = "Mapa de zonas y el número de instancias por zona."
}

# Habilitar o deshabilitar el administrador de certificados
variable "certificate_manager_enable" {
  type        = bool
  description = "Si es true, se crea el administrador de certificados; si es false, no se crea."
}

# Habilitar o deshabilitar el bastion host
variable "bastion_host_enable" {
  type        = bool
  description = "Si es true, se crea el bastion host; si es false, no se crea."
}

# Lista de health checks con sus parámetros
variable "health_checks" {
  type        = list(object({
    name        = string
    request_path = string
    port         = number
  }))
  description = "Lista de health checks con sus parámetros."
}

# Lista de dominios para el certificado SSL gestionado
variable "domains" {
  type        = list(string)
  description = "Lista de dominios para el certificado SSL gestionado."
}

# Nombre del balanceador de carga
variable "load_balancer_name" {
  type        = string
  description = "Nombre del balanceador de carga."
}

# Nombre de la política de Cloud Armor
variable "cloud_armor_policy_name" {
  type        = string
  description = "Nombre de la política de Cloud Armor."
}

# Nombre del certificado SSL
variable "certificate_name" {
  type        = string
  description = "Nombre del certificado SSL gestionado."
}

# Nombre del bastion host
variable "bastion_host_name" {
  type        = string
  description = "Nombre de la instancia de bastion host."
}

# Tipo de máquina del bastion host
variable "bastion_host_machine_type" {
  type        = string
  description = "Tipo de máquina que se utilizará para el bastion host."
}

# Imagen de máquina del bastion host
variable "bastion_host_machine_image" {
  type        = string
  description = "Imagen de máquina que se utilizará para el bastion host."
}
# Tipo del disco adicional para la instancia de Compute Engine
variable "compute_engine_additional_disk_type" {
  type        = string
  description = "Tipo del disco adicional para la instancia de Compute Engine (por ejemplo, 'pd-standard', 'pd-ssd')."
}

# Tamaño del disco adicional en GB para la instancia de Compute Engine
variable "compute_engine_additional_disk_size" {
  type        = string
  description = "Tamaño del disco adicional en GB para la instancia de Compute Engine."
}

# Lista de IPs externas permitidas para el balanceador de carga
variable "load_balancer_allowed_ips" {
  type        = list(string)
  description = "Lista de IPs externas permitidas para el balanceador de carga."
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


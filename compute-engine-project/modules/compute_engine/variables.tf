# Variable para el ID del proyecto de Google Cloud
variable "project_id" {
  description = "ID del proyecto de Google Cloud en el que se desplegarán los recursos."
  type        = string
}

# Variable para el tamaño del disco de arranque en GB
variable "boot_disk_size" {
  description = "Tamaño del disco de arranque en GB para las instancias de Compute Engine."
  type        = string
}

# Variable para el sistema operativo del disco de arranque
variable "boot_disk_os" {
  description = "Sistema operativo del disco de arranque para las instancias de Compute Engine (por ejemplo, 'debian-10', 'ubuntu-2004')."
  type        = string
}

# Variable para la zona de despliegue de Compute Engine
variable "compute_engine_zone" {
  description = "Zona de Google Cloud en la que se crearán las instancias de Compute Engine (por ejemplo, 'us-central1-a')."
  type        = string
}

# Variable para el nombre de la instancia de Compute Engine
variable "compute_engine_name" {
  description = "Nombre de la instancia de Compute Engine que se va a crear."
  type        = string
}

# Variable para el tipo de máquina de Compute Engine
variable "compute_engine_type" {
  description = "Tipo de máquina para la instancia de Compute Engine (por ejemplo, 'n1-standard-1')."
  type        = string
}

# Variable para el nombre del disco adicional de Compute Engine
variable "compute_engine_additional_disk_name" {
  description = "Nombre del disco adicional para la instancia de Compute Engine."
  type        = string
}

# Variable para el tipo del disco adicional de Compute Engine
variable "compute_engine_additional_disk_type" {
  description = "Tipo del disco adicional para la instancia de Compute Engine (por ejemplo, 'pd-standard', 'pd-ssd')."
  type        = string
}

# Variable para el tamaño del disco adicional en GB
variable "compute_engine_additional_disk_size" {
  description = "Tamaño del disco adicional en GB para la instancia de Compute Engine."
  type        = string
}

# Variable para el nombre de la subred dentro de la VPC
variable "subnetwork_name" {
  description = "Nombre de la subred dentro de la VPC en la que se desplegarán las instancias de Compute Engine."
  type        = string
}

# Variable para el script de inicio de las instancias
variable "metadata_startup_script" {
  description = "Script de inicio que se ejecutará al iniciar la instancia de Compute Engine."
  type        = string
}

# Variable para el mapeo de zonas y número de instancias por zona
variable "zones_instance_count" {
  description = "Mapa de zonas y el número de instancias por zona."
  type        = map(number)
}

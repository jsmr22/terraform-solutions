# Variable para el nombre de la base de datos
variable "db_name" {
  description = "Nombre de la base de datos."
  type        = string
}

# Variable para la versión de la base de datos
variable "db_version" {
  description = "Versión de la base de datos."
  type        = string
}

# Variable para el tamaño de la base de datos en GB
variable "db_size" {
  description = "Tamaño en GB de la base de datos."
  type        = string
}

# Variable para las especificaciones de la base de datos
variable "database_tier" {
  description = "Especificaciones de la base de datos."
  type        = string
}

# Variable para la red de la base de datos
variable "network_id" {
  description = "ID de la red a la que pertenece la base de datos."
  type        = string
}

# Variable para el tipo de disponibilidad de la base de datos
variable "db_availability_type" {
  description = "Tipo de disponibilidad de la base de datos."
  type        = string
}

# Variable para el ID del proyecto de la base de datos
variable "project_id" {
  description = "ID del proyecto en el que se desplegará la base de datos."
  type        = string
}

# Variable para la región de la base de datos
variable "db_region" {
  description = "Región donde se desplegará la base de datos."
  type        = string
}

# Variable para habilitar o deshabilitar la creación de la base de datos
variable "database_enable" {
  description = "Si es true, se crea la base de datos; si es false, no se crea."
  type        = bool
}

# Variable para la zona de la base de datos
variable "db_zone" {
  description = "Zona donde se desplegará la base de datos."
  type        = string
}

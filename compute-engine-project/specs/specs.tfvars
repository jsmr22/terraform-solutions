#### General settings ####
project_id = "XXXX"  # ID del proyecto de GCP en donde se crearan los recursos
region     = "europe-southwest1"       # Región predeterminada para los recursos
zone       = "europe-southwest1-b"     # Zona predeterminada para los recursos



#### Network module ####
network_name                   = "vpc-XXXX"            # Nombre de la red
compute_subnetwork_name        = "subnet-compute-XXXX" # Nombre de la subred para Compute Engine
compute_subnetwork_range_private = "10.0.0.0/24"                    # Rango privado de la subred
compute_subnetwork_range_public  = "10.0.1.0/24"                    # Rango público de la subred
external_ip_name               = "external-global-ip"               # Nombre de la IP externa


#### Cloud Nat module ####
cloud_nat_enable = true  # Habilitar Cloud NAT


#### Firewall module ####
firewall_name         = "compute-engine-necessary-connections" # Nombre de la regla de firewall
allowed_protocols     = ["tcp"]                               # Protocolos permitidos para las reglas de firewall
allowed_ports         = ["80", "8080", "21", "22", "443", "5432", "8000", "8001", "8080", "8180", "8443", "8888"] # Puertos permitidos
allowed_external_ips  = ["35.235.240.0/20", "35.191.0.0/16", "130.211.0.0/22"] # IPs externas permitidas;
# El primer rango es para acceso desde la consola de Google, los otros dos para permitir health checks.


#### Database module ####
database_enable        = true                          # Deshabilitar base de datos
database_tier          = "db-custom-2-8192"            # Especificaciones de la base de datos
db_version             = "POSTGRES_15"                 # Versión de la base de datos
db_region              = "europe-west4"                # Región de la base de datos
db_name                = "db-XXXX"         # Nombre de la base de datos
db_availability_type   = "REGIONAL"                    # Tipo de disponibilidad de la base de datos
db_size                = 80                            # Tamaño de la base de datos en GB


#### Bastion Host module ####
bastion_host_enable       = true                          # Habilitar bastion host
bastion_host_name         = "bastion-host"                # Nombre del bastion host
bastion_host_machine_type = "e2-micro"                    # Tipo de máquina del bastion host
bastion_host_machine_image = "debian-cloud/debian-11"     # Imagen del sistema operativo del bastion host


#### Compute Engine module ####
zones_instance_count = {
  "europe-southwest1-b" = 1,
  "europe-southwest1-a" = 2
} # Mapa de zonas y el número de instancias por zona

compute_engine_name                   = "compute-XXXX"    # Nombre de la instancia de Compute Engine
compute_engine_type                   = "e2-medium"              # Tipo de la instancia de Compute Engine
boot_disk_os                          = "ubuntu-os-cloud/ubuntu-2404-lts-amd64" # Sistema operativo del disco de arranque
boot_disk_size                        = "50"                     # Tamaño del disco de arranque en GB
compute_engine_additional_disk_type   = "pd-standard"            # Tipo del disco adicional
compute_engine_additional_disk_size   = "30"                     # Tamaño del disco adicional en GB
metadata_startup_script               = "./scripts/initial_script.sh" # Ruta al script de inicio


#### Load Balancer module ####
load_balancer_name = "load-balancer-XXXX" # Nombre del balanceador de carga
health_checks = [                         # Configuración de health checks
  {
    name = "check-1",
    request_path = "/",
    port = 80
  }
]
url_paths = ["/"] # Rutas de URL para el balanceador de carga
logging_enable=true             # Habilitar logging
logging_sample_rate=1.0        # Tasa de muestreo (1.0 = 100% de las solicitudes se registrarán)


#### Certificate manager module ####
certificate_manager_enable = true        # Habilitar administrador de certificados
certificate_name           = "certificate-XXXX" # Nombre del certificado
domains = ["XXXX.com", "*.XXXX.com"]


#### Cloud Armor module ####
cloud_armor_policy_name     = "cloud-armor-policy"      # Nombre de la política de Cloud Armor
load_balancer_allowed_ips   = ["220.96.146.110"]        # IPs permitidas para el balanceador de carga


#### Service account module ####
account_name      = "XXXX"                       # Nombre de la cuenta de servicio
display_name      = "XXXX service account" # Nombre para mostrar de la cuenta de servicio
iam_roles         = ["roles/owner", "roles/iam.workloadIdentityUser"] # Lista de roles asignados a la cuenta de servicio
key_rotation_time = 180                               # Tiempo en días para rotar la clave de la cuenta de servicio

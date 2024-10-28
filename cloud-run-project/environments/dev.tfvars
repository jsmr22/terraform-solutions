#############################################
#######       GENERAL SETTINGS       ########
#############################################
project_id = "XXX"  # ID del proyecto de GCP en donde se crearan los recursos
region     = "europe-west1"       # Región predeterminada para los recursos
zone       = "europe-west1-b"     # Zona predeterminada para los recursos


#############################################
#######        NETWORK MODULE        ########
#############################################
# Lista de redes VPC
networks = [
  {
    name       = "XXXX"   # Nombre de la red VPC

    # Lista de subredes asociadas a la red VPC
    subnets = [
      {
        name        = "subnet1-compute-XXX-development"  # Nombre de la primera subred
        cidr_range  = "10.0.0.0/24"                        # Rango de direcciones IP para esta subred
        subnet_type = "private"                            # Tipo de subred: 'private' (solo accesible internamente)
        region      = "europe-west1"                  # Región en la que se desplegará esta subred
      },
      {
        name        = "subnet2-cloud-run-connector"  # Nombre de la segunda subred
        cidr_range  = "10.0.1.0/28"                        # Rango de direcciones IP para esta subred
        subnet_type = "private'"                             # Tipo de subred: 'public' (accesible externamente)
        region      = "europe-west1"                  # Región en la que se desplegará esta subred
      }
    ]
  }
]
ip_addresses = [
  {
    name          = "load-balancer-ip-XXX"
    address_type  = "EXTERNAL"
    prefix_length = null
    region        = ""  # Esto creará una dirección global
  },
  {
    name          = "load-balancer-ip-XXX"
    address_type  = "EXTERNAL"
    prefix_length = null
    region        = ""  # Esto creará una dirección global
  },
  {
    name          = "cloud-nat-ip"
    address_type  = "EXTERNAL"
    prefix_length = null
    region        = "europe-west1"  # Esto creará una dirección regional
  }
]
vpc_connectors=[
  {
    name="cloud-run-connector"
    subnet="subnet2-cloud-run-connector"
    region="europe-west1"
    machine_type="e2-micro"
    min_instances=2
    max_instances=3
  }
]



#############################################
#######       CLOUD NAT MODULE       ########
#############################################
cloud_nat_enable = false  # Habilitar Cloud NAT
cloud_nat = [
  {
    name="cloud-nat"
    network="vpc-XXX-development"
    region="europe-west1"
    subnet="subnet1-compute-XXX-development"
    ip_allocate_option="MANUAL_ONLY"
    static_ip=["cloud-nat-ip"]
  }
]


#############################################
#######       FIREWALL MODULE        ########
#############################################
firewall_enable=false
firewall_rules = [
  {
    firewall_name        = "firewall-rule-1"
    network_name         = "vpc-XXX-development"
    allowed_external_ips = ["0.0.0.0/0"]
    allowed_protocols    = [
      {
        protocol = "tcp"
        ports    = ["22", "80", "443", "8080"]
      }
    ]
    tags                 = ["web", "http-server"]
    direction            = "INGRESS"
    priority             = 1000
    description          = "Allow HTTP, HTTPS, and SSH from any IP"
  },
  {
    firewall_name        = "firewall-rule-2"
    network_name         = "vpc-XXX-development"
    allowed_external_ips = ["192.168.1.0/24","load-balancer-ip"]
    allowed_protocols    = [
      {
        protocol = "tcp"
        ports    = ["22"]
      }
    ]
    tags                 = ["ssh"]
    direction            = "INGRESS"
    priority             = 900
    description          = "Allow SSH from internal subnet"
  }
]


#############################################
#######      CLOUD ARMOR MODULE      ########
#############################################
cloud_armor_enable = true
cloud_armor_policies = [
  {
    policy_name = "cloud-armor-policy-1"
    allowed_ips = []
  },
  {
    policy_name = "cloud-armor-policy-2"
    allowed_ips = []
  }
]


#############################################
#######       CLOUD RUN MODULE       ########
#############################################
cloud_run_enable=true
cloud_run_services = [
  {
    name                  = "XXX-terraform"
    backend_name="XXX-terraform-backend"
    backend_service_protocol="HTTP"
    backend_security_policy="cloud-armor-policy-1"
    region                = "europe-west1"
    memory                = "1024Mi"
    ingress="INGRESS_TRAFFIC_ALL"
    deletion_protection = false
    min_instances = 0
    max_instances         = 10
    cpu                   = 2
    concurrency           = 100
    allow_unauthenticated = true
    timeout_seconds       = 600
    revision_name         = "rev-12"
    vpc_connector="cloud-run-connector"
    vpc_egress_settings="PRIVATE_RANGES_ONLY"
    traffic = [
      {
        type      = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
        percent   = 100
      }
    ]
    containers = [
      {
        name                  = "container-1"
        image                 = "XXX"
        container_port        = 3000
        environment_variables = {
          ENV_1       = "test"
        }
        secrets = [
          {
            secret_name   = "SECRET_1"
            env_name      = "SECRET_1"
            secret_version = "latest"
          }
        ]
      }
    ]
  },
  {
    name                  = "XXX-B-terraform"
    backend_name="XXX-B-terraform-backend"
    backend_service_protocol="HTTP"
    backend_security_policy="cloud-armor-policy-1"
    region                = "europe-west1"
    memory                = "1024Mi"
    ingress="INGRESS_TRAFFIC_ALL"
    deletion_protection = false
    min_instances = 0
    max_instances         = 10
    cpu                   = 2
    concurrency           = 100
    allow_unauthenticated = true
    timeout_seconds       = 600
    revision_name         = "rev-12"
    vpc_connector="cloud-run-connector"
    vpc_egress_settings="PRIVATE_RANGES_ONLY"
    traffic = [
      {
        type      = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
        percent   = 100
      }
    ]
    containers = [
      {
        name                  = "container-1"
        image                 = "XXX"
        container_port        = 3000
        environment_variables = {
          ENV_1       = "test"
        }
        secrets = [
          {
            secret_name   = "SECRET_1"
            env_name      = "SECRET_1"
            secret_version = "latest"
          }
        ]
      }
    ]
  }
]



#############################################
#######  CERTIFICATE MANAGER MODULE  ########
#############################################
certificate_manager_enable = true        # Habilitar administrador de certificados
map_certificate_name="cert-XXX-map"
certificates=[
  {
    certificate_name="XXX-certificate"
    domains=["*.domain"]
  }
]


#############################################
#######     LOAD BALANCER MODULE     ########
#############################################
load_balancer_enable=true
load_balancers = [
  {
    load_balancer_name  = "lb-service"
    ip_address="load-balancer-XXX"
    logging_enable      = true
    logging_sample_rate = 0.7
    map_certificate     = "cert-XXX-map"
    default_backend_service = "XXX-terraform-backend"
    http_rule           = true
    https_rule          = true
    certificate         = "XXX-certificate"

    # Nuevo campo para definir las reglas de dominio y path_matcher explícitamente
    host_rules = [
        {
          domain      = ["domain","*"]
          name="host-rule-1"
          path_rules  = [
            {
              path    = ["/client","/client/*"]
              backend = "XXX-terraform-backend"
              rewrite = {
                enabled = true       # Queremos reescribir esta ruta
                rewrite_to = "/"     # Reescribir a la raíz
              }
            },
            {
              path    = ["/job","/job/*"]
              backend = "XXX-B-terraform-backend"
              rewrite = {
                enabled = true
                rewrite_to = "/"     # Reescribir a la raíz
              }
            }
          ]
        }
    ]
  },
  {
    load_balancer_name  = "lb-service-profesional"
    ip_address="load-balancer-ip-profesional"
    logging_enable      = true
    logging_sample_rate = 0.7
    map_certificate     = "cert-XXX-map"
    default_backend_service = "XXX-terraform-backend"
    http_rule           = true
    https_rule          = true
    certificate         = "XXX-certificate"

    # Nuevo campo para definir las reglas de dominio y path_matcher explícitamente
    host_rules = [
      {

        domain      = ["domain","*"]
        name="XXX-host-rule"
        path_rules  = [
      {
        path    = ["/","/*"]
        backend = "XXX-terraform-backend"
        rewrite = {
        enabled = true
        rewrite_to = "/"     # Reescribir a la raíz
      }
      }
      ]


      }
    ]
  }
]








#### Service account module ####
account_name      = "XXX"                       # Nombre de la cuenta de servicio
display_name      = "XXX service account" # Nombre para mostrar de la cuenta de servicio
iam_roles         = ["roles/owner", "roles/iam.workloadIdentityUser"] # Lista de roles asignados a la cuenta de servicio
key_rotation_time = 180                              # Tiempo en días para rotar la clave de la cuenta de servicio

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


variable "project_id" {
  type        = string
  description = "ID del proyecto de GCP."
}
variable "certificates" {
  type = list(object({
    certificate_name = string
    domains          = list(string)
  }))
}
variable "map_certificate_name"{
  type        = string
}
variable "cloud_armor_policies" {
  description = "Lista de políticas de Cloud Armor con los nombres de política y las IPs permitidas."
  type = list(object({
    policy_name = string
    allowed_ips = list(string)
  }))
}


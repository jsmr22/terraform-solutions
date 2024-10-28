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
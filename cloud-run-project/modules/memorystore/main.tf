resource "google_redis_instance" "redis_instance" {
  for_each = { for memorystore in var.memorystore : memorystore.name => memorystore }

  name           = each.value.name
  tier           = each.value.tier
  memory_size_gb = each.value.memory_size_gb

  region      = each.value.region
  location_id = each.value.zone

  redis_version = each.value.redis_version

  authorized_network = each.value.authorized_network

}
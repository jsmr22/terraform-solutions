output "redis_instance_ip" {
  description = "IP address of the first Redis instance"
  value = values(google_redis_instance.redis_instance)[0].host
}

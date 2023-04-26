output "internal-ip" {
  value = yandex_compute_instance.b-node.network_interface[0].ip_address
}

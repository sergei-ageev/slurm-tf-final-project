output "ip_loadbalancer" {
  value = "${[for s in yandex_lb_network_load_balancer.this.listener: s.external_address_spec.*.address].0[0]}"
  description = "White IP of the loadbalancer"
}

resource "yandex_lb_target_group" "this"  {

  name = "${var.prefix}-this"
  labels = var.labels

  target {
    subnet_id = "${yandex_compute_instance_group.this.instances.*.network_interface.0.subnet_id[0]}"
    address = "${yandex_compute_instance_group.this.instances.*.network_interface.0.ip_address[0]}"
  }
  target {
    subnet_id = "${yandex_compute_instance_group.this.instances.*.network_interface.0.subnet_id[1]}"
    address = "${yandex_compute_instance_group.this.instances.*.network_interface.0.ip_address[1]}"
  }
  target {
    subnet_id = "${yandex_compute_instance_group.this.instances.*.network_interface.0.subnet_id[2]}"
    address = "${yandex_compute_instance_group.this.instances.*.network_interface.0.ip_address[2]}"
  }
}

resource "yandex_lb_network_load_balancer" "this" {
  name = "${var.prefix}-this"
  labels = var.labels
  listener {
    name = "http-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = yandex_lb_target_group.this.id
    healthcheck {
      name = "http-healthcheck"
      tcp_options {
        port = 80
      }
    }
  }
}

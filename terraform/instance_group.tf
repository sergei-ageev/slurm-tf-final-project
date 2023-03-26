data "yandex_compute_image" "my_image" {
  name = "${var.vm_image_name}-${var.vm_image_version}"
}

resource "yandex_compute_instance_group" "this" {
  name                = "t${var.prefix}this"
  folder_id           = "b1gplecpgan65ikemi9h"
  service_account_id  = "ajeo2udg2fptmbc1jmuf"
  deletion_protection = false
  labels = var.labels
  instance_template {
    platform_id = "standard-v1"
    resources {
      cores  = var.resources.cores
      memory = var.resources.memory
    }
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = data.yandex_compute_image.my_image.id
      }
    }
    network_interface {
      network_id = "${yandex_vpc_network.this.id}"
      subnet_ids = "${yandex_vpc_subnet.this.*.id}"
    }
    
    network_settings {
      type = "STANDARD"
    }
  }

  scale_policy {
    fixed_scale {
      size = var.vm_count
    }
  }

  allocation_policy {
    zones = var.az
  }

  deploy_policy {
    max_unavailable = 2
    max_creating    = 2
    max_expansion   = 2
    max_deleting    = 2
  }
}
resource "yandex_vpc_network" "this" {
  name = "${var.prefix}-network"
  labels = var.labels
}

resource "yandex_vpc_subnet" "this" {
  count = 3
  name = "${var.prefix}-ru-central1-${count.index}"
  v4_cidr_blocks = ["${(var.cidr_blocks[count.index])}"]
  zone           = var.az[count.index]
  network_id     = "${yandex_vpc_network.this.id}"
  labels = var.labels
}

# Yandex Cloud NGINX VM Image based on Ubuntu 20.04 LTS
#
# Provisioner docs:
# https://www.packer.io/docs/builders/yandex
#

variable "YC_FOLDER_ID" {
  type    = string
  default = env("YC_FOLDER_ID")
}

variable "YC_ZONE" {
  type    = string
  default = env("YC_ZONE")
}

variable "YC_SUBNET_ID" {
  type    = string
  default = env("YC_SUBNET_ID")
}

variable "IMAGE_VERSION" {
  type = string
  default = "1"
}

source "yandex" "yc-toolbox" {
  folder_id           = "${var.YC_FOLDER_ID}"
  source_image_family = "centos-7"
  ssh_username        = "centos"
  use_ipv4_nat        = "true"
  image_description   = "Yandex Cloud Ubuntu Nginx image"
  image_family        = "my-images"
  image_name          = "nginx-${var.IMAGE_VERSION}"
  subnet_id           = "${var.YC_SUBNET_ID}"
  disk_type           = "network-hdd"
  zone                = "${var.YC_ZONE}"
}

build {
  sources = ["source.yandex.yc-toolbox"]

  provisioner "ansible" {
    user          = "centos"
    use_proxy    = "false"
    command       = "ansible-playbook"
    playbook_file = "./ansible/playbook.yml"
    ssh_authorized_key_file = "./ssh/id_ed25519.pub"
    # ansible_env_vars = ["ANSIBLE_HOST_KEY_CHECKING=False"]
    # extra_arguments = ["--private-key=./ssh/id_ed25519","--become-user=root","--become-method=sudo"]
    extra_arguments = ["--private-key=./ssh/id_ed25519"]
  }
}

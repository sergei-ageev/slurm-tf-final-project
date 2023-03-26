prefix = "test"

vm_image_name = "nginx"
vm_image_version = "1"

vm_count = 1

labels = {
    "project" = "terraform-practice"
  }

resources = ({
    cores = 2
    memory = 4
})

cidr_blocks = [
    "10.2.1.0/24",
    "10.2.2.0/24",
    "10.2.3.0/24"
    ]

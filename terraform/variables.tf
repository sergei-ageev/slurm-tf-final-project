variable "prefix" {
    type = string
    description = "prefix for resources"
}

variable "labels" {
    type = map(string)
    description = "Labels to add to resources"
}

variable vm_image_name {
    type = string
    description = "Name of the image for virtual machines"
}

variable vm_count {
    type = number
    description = "Amount of virtual machines"
}
variable vm_image_version {
    type = string
    description = "Number of the version of the image for virtual machines"
}

variable "resources" {
    type = object({
        cores  = number
        memory = number
    })
    description = "Resources for virtual machines"
}

variable "cidr_blocks" {
    type = list(string)
    description = "subnets for virtual machines"
}

variable "az" {
    type = list(string)
    default = [
        "ru-central1-a",
        "ru-central1-b",
        "ru-central1-c"
    ]
    description = "Access zones for virtual machines"
}

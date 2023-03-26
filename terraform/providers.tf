terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~> 0.80"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = "XXXXXX"
  cloud_id  = "XXXXXX"
  folder_id = "XXXXXX"
}

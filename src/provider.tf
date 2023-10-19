terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      # source = "terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex" # Alternate link
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = var.token # Set OAuth or IAM token
  cloud_id  = var.cloud_id # Set your cloud ID
  folder_id = var.folder_id # Set your cloud folder ID
  zone      = var.default_zone # Availability zone by default, one of ru-central1-a, ru-central1-b, ru-central1-c
}

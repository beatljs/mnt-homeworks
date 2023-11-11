resource "yandex_compute_instance" "my_jenkins_vm" {
  for_each = var.vms_resources
  name        = "${each.value.name}"
  platform_id = "standard-v1"

  resources {
    cores  = each.value.cores
    memory = each.value.mem
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.centos-7.image_id
      type = "network-hdd"
      size = each.value.disk_size
    }   
  }

  metadata = {
    ssh-keys = local.ssh-key
    user-data = "${file("cloud-init.yml")}"
  }

  scheduling_policy { preemptible = true }

  network_interface { 
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  allow_stopping_for_update = true
}


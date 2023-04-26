resource "yandex_vpc_network" "net" {
  name = "hxnet"
}

resource "yandex_vpc_subnet" "sub-a" {
  v4_cidr_blocks = ["10.2.22.0/24"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.net.id
}

resource "yandex_compute_instance" "b-node" {
  name        = "app"
  platform_id = "standard-v3"
  zone        = yandex_vpc_subnet.sub-a.zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8rqervg4dejhr6fo35" # Ubuntu 22
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.sub-a.id
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

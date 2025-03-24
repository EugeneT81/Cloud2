resource "yandex_vpc_subnet" "public-subnet" {
  name           = var.subnet_name1
  v4_cidr_blocks = ["192.168.10.0/24"]
  zone           = var.zone
  network_id     = yandex_vpc_network.netology-net.id
}




resource "yandex_compute_instance_group" "lamp-instance-group" {
  name                = "lamp-instance-group"
  service_account_id  = yandex_iam_service_account.sa.id
  deletion_protection = false
  instance_template {
    platform_id = "standard-v1"
    resources {
      memory = 2
      cores  = 2
    }
    boot_disk {
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
        size     = 10
      }
    }
    network_interface {
      network_id = yandex_vpc_network.netology-net.id
      subnet_ids = ["${yandex_vpc_subnet.public-subnet.id}"]
      nat        = true
    }
    metadata = {
      user-data = <<EOF
#!/bin/bash
echo '<html><img src="http://${yandex_storage_bucket.s3.bucket_domain_name}/picture.png"/></html>' > /var/www/html/index.html
EOF
      ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
    }

    network_settings {
      type = "STANDARD"
    }

    scheduling_policy {
      preemptible = true
    }
  }

  scale_policy {
    fixed_scale {
      size = 2
    }
  }

  allocation_policy {
    zones = ["ru-central1-b"]
  }

  deploy_policy {
    max_unavailable = 2
    max_creating    = 2
    max_expansion   = 2
    max_deleting    = 2
  }

  health_check {
    http_options {
      port    = 80
      path    = "/"
    }
  }

  load_balancer {
  }
}
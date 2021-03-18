provider "yandex" {
token = "AgAAAAACrPfHAATuwY852nM7XEwwo4KPE5nulzc"
cloud_id = "b1g9oct2paetbeh14fm7"
folder_id = "b1ghu7l81sg19dm91m06"
zone = "ru-central1-c"
}

resource "yandex_compute_instance" "vm-1" {
name = "terraform1"

resources {
cores = 4
memory = 4
}

boot_disk {
initialize_params {
image_id = "fd81d2d9ifd50gmvc03g"
size="10"
}
}

network_interface {
subnet_id = yandex_vpc_subnet.subnet-1.id
nat = true
#nat_ip_address = "178.154.252.55"
}

#metadata = {
# ssh-keys = "${file("~/.ssh/id_rsa.pub")}"
#}

metadata = {
	user-data = "${file("meta.txt")}"
}
}

resource "yandex_compute_instance" "vm-2" {
name = "terraform2"

resources {
cores = 4
memory = 4
}

boot_disk {
initialize_params {
image_id = "fd81d2d9ifd50gmvc03g"
size="10"
}
}

network_interface {
subnet_id = yandex_vpc_subnet.subnet-1.id
nat = true
#nat_ip_address = "178.154.252.150"
}

metadata = {
	user-data = "${file("meta.txt")}"
}

#metadata = {
# ssh-keys = "${file("~/.ssh/id_rsa.pub")}"
#}
}

resource "yandex_vpc_network" "network-1" {
name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
name = "subnet1"
zone = "ru-central1-c"
network_id = yandex_vpc_network.network-1.id
v4_cidr_blocks = ["192.168.10.0/24"]
}


output "internal_ip_address_vm_1" {
value = yandex_compute_instance.vm-1.network_interface.0.ip_address
}

output "internal_ip_address_vm_2" {
value = yandex_compute_instance.vm-2.network_interface.0.ip_address
}

output "external_ip_address_vm_1" {
value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}

output "external_ip_address_vm_2" {
value = yandex_compute_instance.vm-2.network_interface.0.nat_ip_address
}


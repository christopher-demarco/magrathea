variable "admin" { default = "magrathea" }
variable "admin_key" { default = "keys/magrathea.pub" }
variable "names" { default = ["alpha"] }
variable "subdomain" { default = "" }
variable "region" { default = "us-east4" }

provider "google" {
  version = "0.1.3"
  credentials = "${file("keys/magrathea.json")}"
  project = "magrathea-178523"
  region = "${var.region}"
}

resource "google_compute_instance" "workstation" {
  count = "${length(var.names)}"
  name = "${var.names[count.index]}"
  #machine_type = "f1-micro"
  machine_type = "n1-standard-1"
  #machine_type = "n1-highcpu-2"
  zone = "${var.region}-a"
  boot_disk { initialize_params { image = "ubuntu-1704" } }
  network_interface { network = "default" access_config { } }
  metadata { sshKeys = "${var.admin}:${file("${var.admin_key}")}" }
}

data "google_dns_managed_zone" "workstation" {
  name = "foamninja"
}

resource "google_dns_record_set" "workstation" {
  count = "${length(var.names)}"
  name = "${element(google_compute_instance.workstation.*.name, count.index)}.${var.subdomain}${data.google_dns_managed_zone.workstation.dns_name}"
  type = "A"
  ttl = 60
  managed_zone = "${data.google_dns_managed_zone.workstation.name}"
  rrdatas = ["${element(google_compute_instance.workstation.*.network_interface.0.access_config.0.assigned_nat_ip, count.index)}"]
}

output "workstations" { value = "${google_compute_instance.workstation.*.network_interface.0.access_config.0.assigned_nat_ip}" }

output "hostnames" { value = "${google_compute_instance.workstation.*.name}" }

# magrathea:workstation/terraform.tf
# Copyright (c) 2017 Christopher DeMarco
# Licensed under Apache License v2.0

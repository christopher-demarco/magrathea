variable "admin" { default = "magrathea" }
variable "admin_key" { default = "keys/magrathea.pub" }
variable "names" { default = ["alpha"] }
variable "subdomain" { default = "" }
variable "region" { default = "us-west-1" }

variable "ssh_key_path" {
  default = {
    pub = "keys/magrathea.pub"
    priv = "keys/magrathea"
  }
}

provider "aws" {
  region = "${var.region}"
  profile = "magrathea"
}
  
resource "aws_key_pair" "magrathea" {
  key_name = "magrathea"
  public_key = "${file(var.ssh_key_path["pub"])}"
}

resource "aws_instance" "magrathea" {
  count = 1 #"${length(var.names)}"
  ami = "ami-7f15271f"
  instance_type = "t2.small"
  associate_public_ip_address = true
  key_name = "magrathea"
  vpc_security_group_ids = ["${aws_security_group.magrathea.id}"]
  tags { Name = "${var.names[count.index]}${replace(var.subdomain, ".", "")}" }
}

resource "aws_security_group" "magrathea" {
  ingress {
    from_port = 22 to_port = 22 protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }    
  ingress {
    from_port = 80 to_port = 80 protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0 to_port = 0 protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags { Name = "magrathea" }
}

resource "aws_route53_record" "magrathea" {
  count = 1 #"${length(var.names)}"
  zone_id = "Z2I8Y3PRV9V1P8"
  name = "${var.names[count.index]}${replace(var.subdomain, ".", "")}.foam.ninja"
  type = "A"
  ttl = "60"
  records = ["${element(aws_instance.magrathea.*.public_ip, count.index)}"]
}


output "workstations" { value = "${aws_instance.magrathea.*.public_ip}" } 
output "hostnames" { value = "${aws_route53_record.magrathea.*.name}" }


# magrathea:workstation/terraform.tf
# Copyright (c) 2017 Christopher DeMarco
# Licensed under Apache License v2.0

packer {
  required_version = ">= 1.9.0"

  required_plugins {
    amazon = {
      version = ">= 1.3.0"
      source  = "github.com/hashicorp/amazon"
    }
    ansible = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

locals {
  timestamp = formatdate("YYYYMMDD-HHmmss", timestamp())
}

data "amazon-ami" "ubuntu_22_04" {
  region  = var.aws_region
  owners  = ["099720109477"]

  filters = {
    name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
    state               = "available"
  }

  most_recent = true
}

source "amazon-ebs" "alex_hardened" {
  region        = var.aws_region
  instance_type = var.instance_type
  source_ami    = data.amazon-ami.ubuntu_22_04.id
  ssh_username  = "ubuntu"

  ami_name        = "alex-hardened-ubuntu22-${local.timestamp}"
  ami_description = "Alex's hardened Ubuntu 22.04 homelab image"

  encrypt_boot = true

  tags = {
    Name    = "alex-hardened-ubuntu22"
    BuiltAt = local.timestamp
  }
}

build {
  sources = ["source.amazon-ebs.alex_hardened"]

  provisioner "shell" {
    inline = ["sudo apt-get install -y python3"]
  }

  provisioner "ansible" {
    playbook_file    = "${path.root}/ansible/main.yml"
    galaxy_file      = "${path.root}/ansible/requirements.yml"
    roles_path       = "${path.root}/ansible/roles"
    ansible_env_vars = ["ANSIBLE_HOST_KEY_CHECKING=False"]
  }

  post-processor "manifest" {
    output     = "${path.root}/output/ami-manifest.json"
    strip_path = true
  }
}

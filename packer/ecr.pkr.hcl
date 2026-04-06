packer {
  required_version = ">= 1.9.0"

  required_plugins {
    docker = {
      version = ">= 1.0.9"
      source  = "github.com/hashicorp/docker"
    }
  }
}

locals {
  timestamp      = formatdate("YYYYMMDD-HHmmss", timestamp())
  full_image_uri = "${var.ecr_registry}/${var.ecr_repository}"
}

source "docker" "alex_image" {
  image  = "ubuntu:22.04"
  commit = true

  changes = [
    "LABEL name=\"Alex's homelab image\"",
    "LABEL created=${local.timestamp}",
    "USER appuser",
  ]
}

build {
  sources = ["source.docker.alex_image"]

  provisioner "shell" {
    environment_vars = ["DEBIAN_FRONTEND=noninteractive"]
    inline = [
      "apt-get update -qq",
      "apt-get install -y --no-install-recommends ca-certificates curl tini",
      "groupadd --gid 1001 appuser",
      "useradd --uid 1001 --gid appuser --no-create-home --shell /sbin/nologin appuser",
      "mkdir -p /app && chown appuser:appuser /app",
      "apt-get clean && rm -rf /var/lib/apt/lists/*",
    ]
  }

  post-processor "docker-tag" {
    repository = local.full_image_uri
    tags       = [var.image_tag, local.timestamp]
  }

  post-processor "docker-push" {
    ecr_login    = true
    login_server = var.ecr_registry
  }

  post-processor "manifest" {
    output     = "${path.root}/output/ecr-manifest.json"
    strip_path = true
  }
}

packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source  = "github.com/hashicorp/docker"
    }
    ansible = {
      version = "~> 1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

source "docker" "ubuntu" {
  image  = "ubuntu:latest"
  commit = true
}

build {
  name    = "voting-app"
  sources = ["source.docker.ubuntu"]
  
  provisioner "shell" {
    inline = [
      "apt-get update",
      "apt-get install -y python3"
    ]
  }

  provisioner "ansible" {
    playbook_file   = "./ansible/playbook.yml"
    extra_arguments = ["--scp-extra-args", "'-O'"]
  }

  post-processor "docker-tag" {
    repository = "voting-app"
    tags       = ["latest"]
    only       = ["docker.ubuntu"]
  }
}

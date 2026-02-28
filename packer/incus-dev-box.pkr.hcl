packer {
  required_plugins {
    virtualbox = {
      source  = "github.com/hashicorp/virtualbox"
      version = ">= 1.0.0"
    }
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = ">= 1.0.0"
    }
  }
}

source "virtualbox-iso" "debian" {
  vm_name       = "incus-sync-dev"

  # Debian 13 (trixie)
  iso_url       = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-13.3.0-amd64-netinst.iso"
  iso_checksum  = "sha256:c9f09d24b7e834e6834f2ffa565b33d6f1f540d04bd25c79ad9953bc79a8ac02"

  guest_os_type = "Debian_64"
  disk_size     = 40000
  memory        = 8192
  cpus          = 4

  headless      = false

  http_directory = "http"

  boot_wait = "10s"
  boot_command = [
    "<esc><wait>",
    "install <wait>",
    "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg <wait>",
    "auto <wait>",
    "priority=critical <wait>",
    "locale=en_US.UTF-8 <wait>",
    "keyboard-configuration/xkb-keymap=us <wait>",
    "<enter>"
  ]

  ssh_username           = "dev"
  ssh_password           = "dev"
  ssh_timeout            = "60m"
  ssh_handshake_attempts = 200

  shutdown_command = "echo 'dev' | sudo -S shutdown -P now"

  guest_additions_path = "VBoxGuestAdditions_{{ .Version }}.iso"

  vboxmanage = [
    ["modifyvm", "{{.Name}}", "--nested-hw-virt", "on"],
    ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"]
  ]

  output_directory = "output-incus-sync-dev"
}

build {
  sources = ["source.virtualbox-iso.debian"]

  provisioner "shell" {
    script          = "scripts/01-base.sh"
    execute_command = "echo 'dev' | sudo -S bash '{{ .Path }}'"
  }

  provisioner "shell" {
    script          = "scripts/02-python.sh"
    execute_command = "echo 'dev' | sudo -S bash '{{ .Path }}'"
  }

  provisioner "shell" {
    script = "scripts/03-rust.sh"
  }

  provisioner "shell" {
    script          = "scripts/04-go.sh"
    execute_command = "echo 'dev' | sudo -S bash '{{ .Path }}'"
  }

  provisioner "shell" {
    script          = "scripts/06-docker.sh"
    execute_command = "echo 'dev' | sudo -S bash '{{ .Path }}'"
  }

  provisioner "shell" {
    script          = "scripts/07-postgresql.sh"
    execute_command = "echo 'dev' | sudo -S bash '{{ .Path }}'"
  }

  provisioner "shell" {
    script          = "scripts/08-ollama.sh"
    execute_command = "echo 'dev' | sudo -S bash '{{ .Path }}'"
  }

  provisioner "shell" {
    script = "scripts/09-nodejs.sh"
  }

  provisioner "shell" {
    script          = "scripts/10-woodpecker.sh"
    execute_command = "echo 'dev' | sudo -S bash '{{ .Path }}'"
  }

  provisioner "shell" {
    script = "scripts/11-project-setup.sh"
  }

  provisioner "shell" {
    script          = "scripts/99-cleanup.sh"
    execute_command = "echo 'dev' | sudo -S bash '{{ .Path }}'"
  }

  post-processor "vagrant" {
    output = "incus-sync-dev.box"
  }
}
variable "vm_name" {
  type    = string
  default = "incus-sync-dev"
}

variable "iso_url" {
  type    = string
  default = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.9.0-amd64-netinst.iso"
}

variable "iso_checksum" {
  type    = string
  default = "sha256:1a8f55e9a06ec93688e09a76a08a8a4cdfc7c6c77be7e9d79fc5a63cd6e4e816"
}

variable "disk_size" {
  type    = string
  default = "40960"
}

variable "memory" {
  type    = string
  default = "4096"
}

variable "cpus" {
  type    = string
  default = "4"
}

variable "ssh_username" {
  type    = string
  default = "vagrant"
}

variable "ssh_password" {
  type    = string
  default = "vagrant"
}
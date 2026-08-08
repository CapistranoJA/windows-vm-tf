variable "libvirt_uri" {
  description = "Libvirt provider URI"
  type = string
  default = "qemu:///system"
}

variable "pool_name" {
  description = "Libvirt storage pool name"
  type = string
  default = "windows-11"
}

variable pool_path {
  description = "Libvirt storage pool path"
  type = string
  default = "/data/lib/libvirt/images/windows-11"
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type = string
  default = "windows-11-workstation"
}

variable "disk_size" {
  description = "Size of the virtual machine disk in GB"
  type = number
  default = 80
}

variable "windows_iso_path" {
  description = "Path to the Windows ISO file"
  type = string
}

variable "virtio_iso_path" {
  description = "Path to the VirtIO ISO file"
  type = string
}

variable "network_name" {
  description = "Name of the libvirt network"
  type = string
  default = "libvirt-homelab-nat"
}

variable "network_domain" {
  description = "Domain name for the libvirt network"
  type = string
  default = "homelab.local"
}

variable "network_cidr" {
  description = "CIDR for the windows VM"
  type = string
}
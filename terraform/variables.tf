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
# Windows VM - Using as terraform practice

## Scope:

### OS

Windows 11

### Purpose

Recently switched from windows 11 to fedora 44. Some proprietary apps that I use are not Linux compatible. It initially started as a dual boot, Fedora-windows. 

The problem was switching between environments is tedious, and maintaining 2 full OS installations also consumed additional disk space.

The solution I came up with was to remove the Windows installation and use a Windows VM whenever Windows-specific applications are required.

The VM will also serve as a Terraform practice environment, allowing me to experiment with infrastructure provisioning and VM lifecycle management without affecting my primary Fedora environment.


### Virtualization

* **Hypervisor** : QEMU/KVM
* **Provider** : dmacvicar/libvirt

### Terraform 

#### Provider

`dmacvicar/libvirt` is used since it supports QEMU/KVM.

#### Pool

The location of pool is in: `/data/lib/libvirt/images/windows-11/`

#### Volume

`qcow2` was selected since it does not take up 80GB instantly, and scaling the volume is a possibility considering the VM will be used for Windows-related tasks/work (which is probably a lot of time, considering my work relies on niche proprietary windows apps)

#### Network

Created the homelab network that windows will use. This network will also be used by other projects as well. The network created is isolated from the default libvirt network so my main project portfolio can reuse it. Planning on making it a module or data source soon.


#### Domain

This was the hardest part of this practice lol. The `dmacvicar/libvirt` provider basically mirrors raw libvirt XML, so half the fields require knowing QEMU/libvirt internals (ACPI, UEFI/NVRAM, machine types) that are very new knowledge to me. For version 0.9.8, `libvirt_domain` resource's documentation in [registry.terraform.io](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs/resources/domain) (By the time this was made) was incomplete and missing nested attributes. `terraform providers schema -json` ended up as the actual source of truth. 

Still it worked, and once `terraform apply` was executed, virt-manager shows the VM is there.
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

This was the hardest part of this practice lol. The `dmacvicar/libvirt` provider basically mirrors raw libvirt XML, so half the fields require knowing QEMU/libvirt internals like ACPI, UEFI/NVRAM, and machine types, which were all very new concepts to me.

For version `0.9.8`, the `libvirt_domain` resource documentation in [registry.terraform.io](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs/resources/domain) was incomplete at the time this was written, with some of the nested attributes missing documentation. `terraform providers schema -json` ended up being the actual source of truth more than once.

Still it worked. Once `terraform apply` was executed and finished, virt-manager showed the VM is there.
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
* **Provider** : TBD


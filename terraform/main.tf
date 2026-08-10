provider "libvirt" {
  uri = var.libvirt_uri
}


resource "libvirt_pool" "windows" {
  name = var.pool_name
  type = "dir"
  target = {
    path = var.pool_path
  }

}

resource "libvirt_volume" "windows_disk" {
  name          = "${var.vm_name}.qcow2"
  pool          = libvirt_pool.windows.name
  capacity      = var.disk_size
  #capacity_unit = "GiB"
  target = {
    format = {
      type = "qcow2"
    }
  }
}

resource "libvirt_network" "windows_network" {
  name      = var.network_name
  autostart = true
  domain = {
    name = var.network_domain
  }

  forward = {
    mode = "nat"
  }
  ips = [{
    family  = "ipv4"
    address = cidrhost(var.network_cidr, 1)
    netmask = cidrnetmask(var.network_cidr)

    dhcp = {
      enabled = true
      ranges = [{
        start = cidrhost(var.network_cidr, 150)
        end   = cidrhost(var.network_cidr, 200)
      }]
    }
  }]
}

resource "libvirt_domain" "windows_vm" {
  name        = var.vm_name
  memory      = var.memory
  memory_unit = "MiB"
  vcpu        = var.vcpus
  type        = "kvm"

  autostart = false

  cpu = {
    mode = "host-passthrough"
  }

  os = {
    type         = "hvm"
    type_arch    = "x86_64"
    type_machine = "q35"

    firmware        = "efi"
    loader          = "/usr/share/edk2/ovmf/OVMF_CODE.secboot.fd"
    loader_readonly = "yes"
    loader_type     = "pflash"
    loader_secure   = "yes"
    nv_ram = {
      nv_ram   = "/var/lib/libvirt/qemu/nvram/${var.vm_name}_VARS.fd"
      template = "/usr/share/edk2/ovmf/OVMF_VARS.fd"
    }

    boot_devices = [
      {
        dev = "cdrom"
      },
      {
        dev = "hd"
      }
    ]
  }

  features = {
    acpi = true
  }

  devices = {
    inputs = [
    {
      type = "tablet"
      bus  = "usb"
    }
  ]
    disks = [{
      device = "disk"
      driver = {
        name = "qemu"
        type = "qcow2"
      }
      source = {
        volume = {
          pool   = libvirt_pool.windows.name
          volume = libvirt_volume.windows_disk.name
        }
      }
      target = {
        dev = "vda",
        bus = "virtio"
      }
      },
      {
        device    = "cdrom"
        read_only = true
        source = {
          file = {
            file = var.windows_iso_path
          }
        }
        target = {
          dev = "sda"
          bus = "sata"
        }
      },
      {
        device    = "cdrom"
        read_only = true
        source = {
          file = {
            file = var.virtio_iso_path
          }
        }
        target = {
          dev = "sdb"
          bus = "sata"
        }
      }
    ]
    interfaces = [
      {
        source = {
          network = {
            network = libvirt_network.windows_network.name
          }
        }
        model = {
          type = "virtio"
        }
      }
    ]
    graphics = [
      {
        spice = {
          auto_port = true
        }
      }
    ]
    tpms = [
      {
        model = "tpm-crb"
        backend = {
          emulator = {
            version = "2.0"
          }
        }
      }
    ]
  }
}
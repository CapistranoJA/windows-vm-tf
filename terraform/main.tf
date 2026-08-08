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
  name = "${var.vm_name}.qcow2"
  pool = libvirt_pool.windows.name
  capacity = var.disk_size
  capacity_unit = "GiB"
  target = {
    format = {
      type = "qcow2"
    }
  }
}

resource "libvirt_network" "windows_network" {
  name = var.network_name
  autostart = true
  domain = {
    name = var.network_domain
  }

  forward = {
    mode = "nat"
    nat = {
      addresses = [{
        start = cidrhost(var.network_cidr, 1)
        end   = cidrhost(var.network_cidr, 254)
      }]
    }
  }
  ips = [{
    family = "ipv4"
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
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
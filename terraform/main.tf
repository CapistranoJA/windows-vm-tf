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
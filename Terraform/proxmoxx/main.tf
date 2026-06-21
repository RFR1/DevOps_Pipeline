resource "proxmox_virtual_environment_vm" "test_vm" {

  node_name = var.proxmox_node
  started = true
  on_boot = true

  agent {
    enabled = true
  }

  clone {
    vm_id = 920
  }

  cpu {
    cores = 2
    type  = "host"
  }

  memory {
    dedicated = 2048
  }

  disk {
    datastore_id = "local"
    interface    = "scsi0"
    size         = 30
  }

  network_device {
    bridge = "vmbr0"
  }

  operating_system {
    type = "l26"
  }

  initialization {
    datastore_id = "local"
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_account {
      username = "User"

      keys = [
        trimspace(file(pathexpand(var.ssh_public_key_path)))
      ]
    }
  }
}
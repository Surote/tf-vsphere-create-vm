data "vsphere_datacenter" "datacenter" {
  name = var.datacenter_name
}

data "vsphere_datastore" "datastore" {
  name          = "Datastore1"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_datastore" "datastore2" {
  name          = "Datastore2"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = var.vmnetwork
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = "Cluster"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

output "network_id" {
  value         = data.vsphere_network.network.id
}

resource "vsphere_virtual_machine" "tf-worker" {
  for_each = var.compute
  name = each.value.name
  num_cpus         = each.value.cpu
  memory           = each.value.memory
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore2.id
  folder = var.folder
  guest_id = "rhel8_64Guest"
  enable_disk_uuid = true
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label = "disk0"
    size  = each.value.disksize
    thin_provisioned = true
    
  }
  cdrom {
    datastore_id = data.vsphere_datastore.datastore.id
    path         = "ISO/discovery_image_ipi-demo-dis.iso"
  }
}
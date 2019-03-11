provider "vsphere" {
  user           = "root"
  password       = "1234567"
  vsphere_server = "192.168.10.3"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "datacenter"
}

data "sphere_datastore" "datastore" {
  name          = "192.168.10.3-HDD"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
  name          = "datacenter\terraform"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

provider "vsphere" {
  user           = "administrator@vsphere.local"
  password       = "Hnky@1234"
  vsphere_server = "192.168.10.118"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "datacenter"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "cluster"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "Ubuntu1604"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datastore" "datastore" {
  name          = "192.168.10.3-HDD"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

#data "vsphere_resource_pool" "pool" {
#  name          = "terraform"
#  datacenter_id = "${data.vsphere_datacenter.dc.id}"
#}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

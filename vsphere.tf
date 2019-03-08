resource "vsphere_virtual_machine" "vm" {
  name             = "terraform-clonetest"
  resource_pool_id = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  num_cpus = 1 
  memory   = 2048
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"

 # scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }


  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {
      linux_options {
        host_name = "terraform-clonetest"
        domain    = "test.internal"
      }

      network_interface {
        ipv4_address = "192.168.10.110"
        ipv4_netmask = 24
      }

      ipv4_gateway = "192.168.10.254"
    }
  }
}

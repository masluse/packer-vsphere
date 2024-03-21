# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source
packer {
  required_plugins {
    vsphere = {
      version = "~> 1"
      source  = "github.com/hashicorp/vsphere"
    }
  }
}


source "vsphere-iso" "example_windows" {
  CPUs                 = local.cpu_num
  RAM                  = local.mem_size
  RAM_reserve_all      = true
  communicator         = "winrm"
  convert_to_template  = true
  datastore            = local.vsphere_datastorel
  disk_controller_type = ["pvscsi"]
  firmware             = "uefi"
  floppy_files = ["./setup/autounattend.xml",
    "./setup/setup.ps1",
    "./setup/vmtools.ps1",
  ]
  folder              = local.vsphere_folder
  guest_os_type       = "windows2022srv_64Guest"
  host                = local.vsphere_host
  insecure_connection = "true"
  iso_paths           = local.os_iso_path
  network_adapters {
    network      = local.vsphere_network
    network_card = "vmxnet3"
  }
  storage {
    disk_size             = local.disk_size
    disk_thin_provisioned = true
  }
  username       = local.vsphere_username
  password       = local.vsphere_password
  vcenter_server = local.vsphere_server
  vm_name        = local.vsphere_template_name
  winrm_password = local.winrm_password
  winrm_username = "Administrator"
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  sources = ["source.vsphere-iso.example_windows"]

  provisioner "windows-shell" {
    inline = ["dir c:\\"]
  }
}

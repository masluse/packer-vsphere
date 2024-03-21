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
  CPUs                 = {{user `cpu_num`}}
  RAM                  = {{user `mem_size`}}
  RAM_reserve_all      = true
  communicator         = "winrm"
  convert_to_template  = true
  datastore	       = {{user `vsphere_datastore`}}
  disk_controller_type = ["pvscsi"]
  firmware             = "uefi"
  floppy_files         = ["./setup/autounattend.xml",
                          "./setup/setup.ps1",
                          "./setup/vmtools.ps1",
                          ]
  folder               = {{user `vsphere_folder`}}
  guest_os_type        = "windows2022srv_64Guest"
  host                 = {{user `vsphere_host`}}
  insecure_connection  = "true"
  iso_paths            = {{user `os_iso_path`}}
  network_adapters {
    network = {{user `vsphere_portgroup_name`}}
    network_card = "vmxnet3"
  }
  storage {
    disk_size             = {{user `disk_size`}}
    disk_thin_provisioned = true
  }
  username       = {{user `vsphere_username`}}
  password	 = {{user `vsphere_password`}}
  vcenter_server = {{user `vsphere_server`}}
  vm_name        = {{user `vsphere_template_name`}}
  winrm_password = {{user}}
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

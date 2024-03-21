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

locals {
    vsphere_server = "vcenter.teleport.mregli.com"
    vsphere_user = "administrator@vsphere.local"
    vsphere_password = "HalloM3in*"
    vsphere_template_name = "win2022clone_withupdates"
    vsphere_folder = "Windows Server 2022"
    vsphere_host = "10.27.9.3"
    vsphere_portgroup_name = "Lab"
    vsphere_datastore = "Synology"
    winrm_password = "DerkleinePrinz*"
    cpu_num = 4
    mem_size = 8192
    disk_size = 102400
    os_iso_path = "[ISO] windows/en-us_windows_server_2022_updated_july_2023_x64_dvd_541692c3.iso"
}

source "vsphere-iso" "example_windows" {
  CPUs                 = local.cpu_num
  RAM                  = local.mem_size
  RAM_reserve_all      = true
  communicator         = "winrm"
  convert_to_template  = true
  datastore            = local.vsphere_datastore
  disk_controller_type = ["pvscsi"]
  firmware             = "efi"
  floppy_files = ["./setup/autounattend.xml",
    "./setup/setup.ps1",
    "./setup/vmtools.ps1",
  ]
  folder              = local.vsphere_folder
  guest_os_type       = "windows2019srv_64Guest"
  host                = local.vsphere_host
  insecure_connection = "true"
  iso_paths           = [local.os_iso_path]
  network_adapters {
    network      = local.vsphere_portgroup_name
    network_card = "vmxnet3"
  }
  storage {
    disk_size             = local.disk_size
    disk_thin_provisioned = true
  }
  username       = local.vsphere_user
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
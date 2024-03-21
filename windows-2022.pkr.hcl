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
  CPUs                 = 1
  RAM                  = 4096
  RAM_reserve_all      = true
  communicator         = "winrm"
  disk_controller_type = ["pvscsi"]
  guest_os_type        = "windows9Server64Guest"
  host                 = "10.27.9.3"
  insecure_connection  = "true"
  iso_paths            = ["[ISO] windows/en-us_windows_server_2022_updated_july_2023_x64_dvd_541692c3.iso"]
  datastore	       = "Synology"
  network_adapters {
    network = "Lab"
    network_card = "vmxnet3"
  }
  storage {
    
    disk_size             = 32768
    disk_thin_provisioned = true
  }
  username       = "administrator@vsphere.local"
  password	 = "HalloM3in*"
  vcenter_server = "vcenter.teleport.mregli.com"
  vm_name        = "example-windows"
  winrm_password = "jetbrains*"
  winrm_username = "jetbrains"
  cd_files = [
    "./setup/Autounattend.xml",
    "./setup/setup.ps1"
    "./setup/vmtools.cmd"
  ]
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

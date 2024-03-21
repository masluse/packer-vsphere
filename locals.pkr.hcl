locals {
    vsphere_server = "vcenter.teleport.mregli.com",
    vsphere_user = "administrator@vsphere.local",
    vsphere_password = "HalloM3in*",
    vsphere_template_name = "win2022clone_withupdates",
    vsphere_folder = "Windows Server 2022",
    vsphere_host = "10.27.9.3",
    vsphere_portgroup_name = "Lab",
    vsphere_datastore = "Synology",
    winadmin_password = "DerkleinePrinz*",
    cpu_num = 4,
    mem_size = 8192,
    disk_size = 102400,
    os_iso_path = [
        "[ISO] windows/en-us_windows_server_2022_updated_july_2023_x64_dvd_541692c3.iso"
    ]
}
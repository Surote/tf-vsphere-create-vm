variable "vsphere_user" {
  type = string
  default = "redhat"
}
variable "vsphere_password" {
  type = string
  default = "no"
}
variable "vsphere_server" {
  type = string
  default = "172.16.15.28"
}
variable "folder" {
    type = string
}
variable "templatelocation" {
    type = string
}
variable "vmnetwork" {
    type = string
}
variable "datacenter_name" {
    type = string
}
variable "compute" {
    type = map(object({
        name = string,
        disksize = number,
        cpu = number,
        memory = number
    }))
}
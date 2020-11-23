variable "username" {
  type    = string
  default = ""
}

variable "password" {
  type    = string
  default = ""
}

variable "controller_ip" {
  type    = string
  default = ""
}

variable "region" {
  default = ""
}

variable "firewall_image" {
  type    = string
  default = ""
}

variable "fw_iam_role" {
  type = string
}

variable "fw_bootstrap_bucket" {
  type    = string
  default = ""
}

variable "aviatrix_firenet_vpc_name" {
  description = "Aviatrix Firenet VPC Name"
  type        = string
}

variable "aviatrix_tgw_name_primary" {
  description = "Aviatrix Transit Gateway Primary Name"
  type        = string
}

variable "aviatrix_tgw_name_secondary" {
  description = "Aviatrix Transit Gateway Secondary Name"
  type        = string
}

variable "panorama_ip" {
  description = "Private Address of Panorama"
  type        = string
}

variable "panorama_vm_auth_key" {
  description = "Panorama VM-Auth-Key for Bootstrapping"
  type        = string
}

variable "panorama_template_stack" {
  description = "Primary Template associated with Aviatrix Transit Gateway non HA"
  type        = string
}

variable "panorama_template_stack_ha" {
  description = "Primary Template associated with Aviatrix Transit Gateway HA"
  type        = string
}

variable "panorama_device_group_name" {
  description = "Panorama Device Group name to associate with firewall during bootstrap process"
  type        = string
  default     = ""
}

variable "panorama_device_group_name_1" {
  description = "Panorama Device Group name to associate with firewall during bootstrap process unique NAT rulebase for firewall1"
  type        = string
  default     = ""
}

variable "panorama_device_group_name_2" {
  description = "Panorama Device Group name to associate with firewall during bootstrap process unique NAT rulebase for firewall1"
  type        = string
  default     = ""
}

variable "custom_egress_cidr_azA" {
  description = "If a customer wants to use a subnet built, not by the Aviatrix defaults, please update the cidr range in this variable"
  type        = string
  default     = ""
}

variable "custom_egress_cidr_azB" {
  description = "If a customer wants to use a subnet built, not by the Aviatrix defaults, please update the cidr range in this variable"
  type        = string
  default     = ""
}

variable "aviaxtrix_attachment_map" {
  description = "Map to associate attachment boolean values"
  default = {}
}
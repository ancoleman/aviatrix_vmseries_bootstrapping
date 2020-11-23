variable "firewalls" {
  description = "Map of firewalls to loop through, and connect to appropriate Aviatrix Gateway"
}

variable "prefix" {
  description = "Boolean to determine if name will be prepended with avx-"
  type        = bool
  default     = true
}

variable "suffix" {
  description = "Boolean to determine if name will be appended with -spoke"
  type        = bool
  default     = true
}

variable "name" {
  description = "Optionally provide a custom name for VPC and Gateway resources."
  type        = string
  default     = ""
}

locals {
  lower_name        = length(var.name) > 0 ? replace(lower(var.name), " ", "-") : replace(lower(var.region), " ", "-")
  prefix            = var.prefix ? "avx-" : ""
  suffix            = var.suffix ? "-firenet" : ""
  name              = "${local.prefix}${local.lower_name}${local.suffix}"
//  subnet            = var.insane_mode ? cidrsubnet(var.cidr, 3, 6) : aviatrix_vpc.default.subnets[0].cidr
//  ha_subnet         = var.insane_mode ? cidrsubnet(var.cidr, 3, 7) : aviatrix_vpc.default.subnets[2].cidr
//  insane_mode_az    = var.insane_mode ? "${var.region}${var.az1}" : null
//  ha_insane_mode_az = var.insane_mode ? "${var.region}${var.az2}" : null
}

variable "region" {
  description = "The AWS region to deploy this module in"
  type        = string
}

variable "inspection_enabled" {
  description = "Set to false to disable inspection"
  type        = bool
  default     = true
}

variable "egress_enabled" {
  description = "Set to true to enable egress"
  type        = bool
  default     = false
}

variable "firewall_image" {
  description = "The firewall image to be used to deploy the NGFW's"
  type        = string
}

variable "vpc_id" {
  description = "VPC-ID where to deploy firewalls"
  type = string
}

variable "iam_role" {
  description = "The IAM role for bootstrapping"
  type        = string
  default     = null
}
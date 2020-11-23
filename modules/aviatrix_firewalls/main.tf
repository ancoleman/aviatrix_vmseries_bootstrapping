#Firewall instances
resource "aviatrix_firewall_instance" "firewall_instance" {
  for_each               = var.firewalls
  firewall_name          = "${local.name}-${each.key}"
  firewall_size          = each.value.fw_instance_size
  vpc_id                 = var.vpc_id
  firewall_image         = var.firewall_image
  egress_subnet          = each.value.egress_subnet_cidr
  firenet_gw_name        = each.value.aviatrix_tgw_name
  firewall_image_version = each.value.firewall_image_version
  iam_role               = var.iam_role
  bootstrap_bucket_name  = each.value.bootstrap_bucket_name
  management_subnet      = each.value.management_subnet_cidr
}

#Firenet
resource "aviatrix_firenet" "firenet" {
  vpc_id             = var.vpc_id
  inspection_enabled = var.inspection_enabled
  egress_enabled     = var.egress_enabled
  dynamic "firewall_instance_association" {
    for_each = var.firewalls
    content {
      firenet_gw_name      = aviatrix_firewall_instance.firewall_instance[firewall_instance_association.key].firenet_gw_name
      instance_id          = aviatrix_firewall_instance.firewall_instance[firewall_instance_association.key].instance_id
      vendor_type          = "Generic"
      firewall_name        = aviatrix_firewall_instance.firewall_instance[firewall_instance_association.key].firewall_name
      lan_interface        = aviatrix_firewall_instance.firewall_instance[firewall_instance_association.key].lan_interface
      management_interface = aviatrix_firewall_instance.firewall_instance[firewall_instance_association.key].management_interface
      egress_interface     = aviatrix_firewall_instance.firewall_instance[firewall_instance_association.key].egress_interface
      attached             = firewall_instance_association.value.attached
    }
  }
}

// Aviatrix and Palo Alto Networks Firewall instance Bootstrapping to Panorama

## MUST USE TERRAFORM WORKSPACE AND TARGET VAR FILE APPROPRIATELY
## terraform init
## terraform workspace new useast1 or <insert your workspace name here>
## terraform workspace new useast2 or <insert your workspace name here>
## switch to the workspace you want to target the tfvars file from
## terraform workspace select <workspace name>
## terraform init
## terraform plan -var-file=<your var file name>
## terraform apply -var-file=<your var file name>

module "bootstrap-fw1" {
  source          = "./modules/bootstrap"
  prefix          = "${var.fw_bootstrap_bucket}-fw1"
  global_tags     = {}
  vm-auth-key     = var.panorama_vm_auth_key
  panorama-server = var.panorama_ip
  tplname         = var.panorama_template_stack
  dgname          = var.panorama_device_group_name_1
}

module "bootstrap-fw2" {
  source          = "./modules/bootstrap"
  prefix          = "${var.fw_bootstrap_bucket}-fw2"
  global_tags     = {}
  vm-auth-key     = var.panorama_vm_auth_key
  panorama-server = var.panorama_ip
  tplname         = var.panorama_template_stack_ha
  dgname          = var.panorama_device_group_name_2
}

data "aviatrix_vpc" "firenet" {
  name = var.aviatrix_firenet_vpc_name
}

# Aviatrix Transit Firenet Firewall Instance Build out
module "firenet_firewalls" {
  source             = "./modules/aviatrix_firewalls"
  egress_enabled     = true
  inspection_enabled = true
  region             = var.region
  firewall_image     = var.firewall_image
  iam_role           = var.fw_iam_role
  vpc_id             = data.aviatrix_vpc.firenet.vpc_id
  firewalls = {
    fw1 = {
      aviatrix_tgw_name      = var.aviatrix_tgw_name_primary
      bootstrap_bucket_name  = module.bootstrap-fw1.bucket_name
      firewall_image_version = "9.1.3"
      management_subnet_cidr = data.aviatrix_vpc.firenet.subnets[0].cidr
      egress_subnet_cidr     = var.custom_egress_cidr_azA != "" ? var.custom_egress_cidr_azA : data.aviatrix_vpc.firenet.subnets[1].cidr
      fw_instance_size       = "c5.2xlarge"                      # Change to size according to the VM-Series being deployed VM300,VM500,VM700
      attached               = var.aviaxtrix_attachment_map["fw1"] # Enable this to true when ready to attach directly to the gateway
    }
    fw2 = {
      aviatrix_tgw_name      = var.aviatrix_tgw_name_secondary
      bootstrap_bucket_name  = module.bootstrap-fw2.bucket_name
      firewall_image_version = "9.1.3"
      management_subnet_cidr = data.aviatrix_vpc.firenet.subnets[2].cidr
      egress_subnet_cidr     = var.custom_egress_cidr_azB != "" ? var.custom_egress_cidr_azB : data.aviatrix_vpc.firenet.subnets[3].cidr
      fw_instance_size       = "c5.2xlarge"                      # Change to size according to the VM-Series being deployed VM300,VM500,VM700
      attached               = var.aviaxtrix_attachment_map["fw2"] # Enable this to true when ready to attach directly to the gateway
    }
  }
}
provider "aviatrix" {
  controller_ip = var.controller_ip
  username      = var.username
  password      = var.password
  version       = "2.16.3"
}

provider "aws" {
  ### ADD AWS CREDENTIALS
  region  = var.region
}
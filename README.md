Aviatrix and Palo Alto Networks VM-Series integration on AWS for Bootstrapping

Assumptions:
* Multi-Region Deployment
* Aviatrix Environment has already been deployed
* Proper AWS and Aviatrix access has been granted
* Panorama is accessible via security groups and routing

Requirements:
* Terraform Version 0.12.29
* Aviatrix Provider Version: 2.16.3
* AWS Provider Version: ~3.16.0

Quick Steps:

1. ```git clone https://github.com/ancoleman/aviatrix_vmseries_bootstrapping.git```
1. ```cd aviatrix_vmseries_bootstrapping```
1. ```terrform workspace new <your workspace name>```
1. ```terraform init```
1. Update ```provider.tf``` with AWS credentials
1. Update ```terraform.auto.tfvars``` with Aviatrix credentials
1. Update ```<your file>.tfvars``` with the appropriate values
1. Update ```files/license/authcodes``` with the Palo Alto Networks VM-Series Auth Code
1. ```terraform plan -var-file=<your tfvars file>```
1. ```terraform apply --auto-approve -var-file=<your tfvars file>```


*Note: if you want to build more than 2 firewalls update ```main.tf```*

*Note: if you choose to build more than 2 firewalls also update your tfvars to support the additions*

*Note: if you want to support adding content updates, plugins, or software version upgrades during bootstrapping you must build out the additional directories in ```files/```*
* For software upgrades add ```files/software/<panos software version binary>```
* For content upgrades add ```files/content/<panos content update binaries>```
* For plugin upgrades add ```files/plugins/<panos plugin binaries>```
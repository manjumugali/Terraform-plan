# Terraform-plan

1. To install terraform please follow the below link instructions 
   https://www.terraform.io/downloads.html

2. Please update varibles.tf file before applying the terraform commands
   -> region : in which reagion you are going to create AWS resources.
   -> access_key & secret_keys : To commicate with AWS account

3. please follow the below commands
   1. terraform init : Initialize a Terraform working directory
   2. terraform plan : Generate and show an execution plan
   3. terraform apply : Builds or changes infrastructure
   4. terraform destroy : Destroy Terraform-managed infrastructure etc...
    for more details folow the link https://www.terraform.io/docs/commands/index.html


4. Finally run this command
   terraform output kubeconfig > ~/.kube/config


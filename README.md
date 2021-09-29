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

Main commands:
  init          Prepare your working directory for other commands
  validate      Check whether the configuration is valid
  plan          Show changes required by the current configuration
  apply         Create or update infrastructure
  destroy       Destroy previously-created infrastructure

All other commands:
  console       Try Terraform expressions at an interactive command prompt
  fmt           Reformat your configuration in the standard style
  force-unlock  Release a stuck lock on the current workspace
  get           Install or upgrade remote Terraform modules
  graph         Generate a Graphviz graph of the steps in an operation
  import        Associate existing infrastructure with a Terraform resource
  login         Obtain and save credentials for a remote host
  logout        Remove locally-stored credentials for a remote host
  output        Show output values from your root module
  providers     Show the providers required for this configuration
  refresh       Update the state to match remote systems
  show          Show the current state or a saved plan
  state         Advanced state management
  taint         Mark a resource instance as not fully functional
  test          Experimental support for module integration testing
  untaint       Remove the 'tainted' state from a resource instance
  version       Show the current Terraform version
  workspace     Workspace management

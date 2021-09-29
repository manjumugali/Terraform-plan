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

  1.init        ->   Prepare your working directory for other commands.
  
  2.validate    ->   Check whether the configuration is valid.

  3.plan        ->   Show changes required by the current configuration.
  
  4.apply       ->   Create or update infrastructure.
  
  5.destroy     ->   Destroy previously-created infrastructure.

All other commands:
  1.console      ->  Try Terraform expressions at an interactive command prompt.
  2.fmt          ->  Reformat your configuration in the standard style.
  3.force-unlock ->  Release a stuck lock on the current workspace.
  4.get          ->  Install or upgrade remote Terraform modules.
  5.graph        ->  Generate a Graphviz graph of the steps in an operation.
  6.import       ->  Associate existing infrastructure with a Terraform resource.
  7.login        ->  Obtain and save credentials for a remote host.
  8.logout       ->  Remove locally-stored credentials for a remote host.
  9.output       ->  Show output values from your root module.
  10.providers   ->  Show the providers required for this configuration.
  11.refresh     ->  Update the state to match remote systems.
  12.show        ->  Show the current state or a saved plan.
  13.state       ->  Advanced state management.
  14.taint       ->  Mark a resource instance as not fully functional.
  15.test        ->  Experimental support for module integration testing.
  16.untaint     ->  Remove the 'tainted' state from a resource instance.
  17.version     ->  Show the current Terraform version.
  18.workspace   ->  Workspace management.

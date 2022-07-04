terraform {
  source = "${get_parent_terragrunt_dir()}/modules//vpc"
}

include {
  path = find_in_parent_folders("terragrunt.hcl")
}

locals {
  env_var    = yamldecode(file(find_in_parent_folders("env.yaml")))
  global_var = yamldecode(file(find_in_parent_folders("global.yaml")))
}

inputs = {
  name            = "wwcl-${local.env_var.env}"
  cidr_block      = "13.0.0.0/16"
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets  = ["13.0.1.0/24", "13.0.2.0/24", "13.0.3.0/24"]
  private_subnets = ["13.0.10.0/24", "13.0.11.0/24", "13.0.12.0/24"]
  
  tags = {
    Env       = "${local.env_var.env}"
    Managed_by = "${local.global_var.manage_by}" 
  }
}

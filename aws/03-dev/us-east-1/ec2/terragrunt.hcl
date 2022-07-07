terraform {
  source = "${get_parent_terragrunt_dir()}/modules//ec2"
}

include {
  path = find_in_parent_folders("terragrunt.hcl")
}

dependencies {
  paths = ["../vpc"]
}

locals {
  env_var    = yamldecode(file(find_in_parent_folders("env.yaml")))
  global_var = yamldecode(file(find_in_parent_folders("global.yaml")))
}

inputs = {
  name = "basic-${local.env_var.env}"
  
  tags = {
    Env       = "${local.env_var.env}"
    Managed_by = "${local.global_var.manage_by}" 
  }
}
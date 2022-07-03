terraform {
  source = "${get_parent_terragrunt_dir()}/modules//vpc"
}

include {
  path = find_in_parent_folders("terragrunt.hcl")
}

inputs = {
  name = "main"
  cidr_block = "14.3.0.0/24"
}
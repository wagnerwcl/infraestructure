terraform {
  source = "${get_parent_terragrunt_dir()}/modules//ec2"
}

include {
  path = find_in_parent_folders("terragrunt.hcl")
}


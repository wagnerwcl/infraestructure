terraform {
  source = "${get_parent_terragrunt_dir()}/modules//billing"
}

include {
  path = find_in_parent_folders("terragrunt.hcl")
}
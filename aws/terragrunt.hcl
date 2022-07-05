terraform {

  extra_arguments "conditional_vars" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "refresh",
      "destroy",
    ]
  }
}

generate "provider" {
  path = "auto_provider.tf"
  if_exists = "overwrite"
  contents = <<-EOF
    provider "aws" {
      region  = "us-east-1"
      profile = "wwcl"
    }
  EOF
}

generate "versions" {
  path      = "tf-versions.tf"
  if_exists = "overwrite"
  contents = <<-EOF
  terraform {
    required_version = "~> 1.2.4"
    required_providers {
      aws     = "~> 4.20.1"
    }
  }
  EOF
}

remote_state {

  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
    contents  = <<EOF
      terraform {
          backend = "s3"
      }
      EOF
  }

  config = {
    bucket         = "terraform-state-659234864749"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terragrunt-manage-locks"
    profile        = "wwcl"
  }
}

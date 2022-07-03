variable "name" {
  description = "Name for VPC resources"
  type = string
  default = null
}

variable "cidr_block" {
  description = "The IPv4 CIDR block for the VPC"
  type = string
  default = null
}

variable "instance_tenancy" {
  description = ""
  type = string
  default = null
}

#############################
# Terragrunt
#############################

variable "env" {}
variable "region" {}
variable "manage_by" {}
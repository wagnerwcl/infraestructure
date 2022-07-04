#############################
# default
#############################

variable "name" {
  description = "Name for resources"
  type = string
  default = null
}

variable "tags" {
  description = "A lista of tags to add all resources"
  type = map(string)
  default = {}  
}

#############################
# aws_vpc
#############################

variable "create_vpc" {
  description = "Define if a VPC must be create"
  type = bool
  default = true  
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
# aws_subnet
#############################

variable "public_subnets" {
  description = "A lista of public subnets"
  type = list(string)
  default = []
}

variable "private_subnets" {
  description = "A list of private subnets"
  type = list(string)
  default = []
}

variable "azs" {
  description = "A list of availability zones"
  type = list(string)
  default = []
}

#############################
# ambient
#############################

# variable "env" {}
# variable "region" {}
# variable "manage_by" {}
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
# aws_instance
#############################

variable "create_instance" {
  description = "Enable creation of instance"
  type = bool
  default = true
}

variable "instance_type" {
  description = ""
  type = string
  default = "t2.micro"
}
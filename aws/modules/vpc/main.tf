
resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = var.instance_tenancy

  tags = {
    Name = "${var.name}-${var.env}"
    Env  = var.env
    Manage_By = var.manage_by
  }

}
##########################
# Data
##########################

data "aws_ami" "amazon" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*"]
  }
}

##########################
# Instance
##########################

resource "aws_instance" "main" {
  count         = var.create_instance ? 1 : 0 
  ami           = data.aws_ami.amazon.id
  instance_type = var.instance_type

  tags = merge(
    {"Name" = "${var.name}"},
    var.tags,
  )
}


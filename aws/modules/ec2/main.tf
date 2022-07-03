
data "aws_ami" "amazon" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-arm64-*"]
  }
}

output "amazon_image_id" {
  value = data.aws_ami.amazon.id
}




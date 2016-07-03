variable "public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioners can
connect.

Example: ~/.ssh/terraform.pub
DESCRIPTION
  default = "~/.ssh/terraform.pub"
}

variable "key_name" {
  description = "terraform"
  default = "terraform"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default = "eu-west-1"
}

variable "aws_amis" {
  default = {
    eu-west-1 = "ami-c39604b0"
    us-east-1 = "ami-de7ab6b6"
    us-west-1 = "ami-3f75767a"
    us-west-2 = "ami-21f78e11"
  }
}

variable "vpc-cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}

variable "eu-west-1a-public-cidr" {
    description = "CIDR for the Public Subnet in eu-west-1a"
    default = "10.0.1.0/24"
}

variable "eu-west-1b-public-cidr" {
    description = "CIDR for the Public Subnet in eu-west-1b"
    default = "10.0.2.0/24"
}

provider "aws" {
  region     = "eu-west-1"
}

resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

# web tier
resource "aws_instance" "web" {
  ami           = "ami-c39604b0"
  instance_type = "t2.micro"
  count = 2
  tags {
        Name = "${concat("web", count.index)}"
  }
  security_groups = ["SSH"]
  key_name = "terraform"
  connection {
       user = "ec2-user"
  }
  provisioner "chef"  {
        environment = "_default"
        run_list = ["role[base]"]
        node_name = "${concat("web", count.index)}"
        server_url = "https://api.opscode.com/organizations/quick"
        validation_client_name = "quick-validator"
        validation_key = "${file("/etc/chef/quick-validator.pem")}"
  }
}


# database tier
resource "aws_instance" "db" {
  ami           = "ami-c39604b0"
  instance_type = "t2.micro"
  count = 1
  tags {
        Name = "${concat("db", count.index)}"
  }
  security_groups = ["SSH"]
  key_name = "terraform"
  connection {
       user = "ec2-user"
  }
  provisioner "chef"  {
        environment = "_default"
        run_list = ["role[base]"]
        node_name = "${concat("db", count.index)}"
        server_url = "https://api.opscode.com/organizations/quick"
        validation_client_name = "quick-validator"
        validation_key = "${file("/etc/chef/quick-validator.pem")}"
  }
}



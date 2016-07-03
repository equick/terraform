# web tier
resource "aws_instance" "web0" {
  ami           = "ami-c39604b0"
  instance_type = "t2.micro"
  availability_zone = "eu-west-1a"
  tags {
        Name = "web0"
  }
  key_name = "terraform"
  connection {
       user = "ec2-user"
  }
  provisioner "chef"  {
        environment = "_default"
        run_list = ["role[base]"]
        node_name = "web0"
        server_url = "https://api.opscode.com/organizations/quick"
        validation_client_name = "quick-validator"
        validation_key = "${file("/etc/chef/quick-validator.pem")}"
  }
  subnet_id = "${aws_subnet.eu-west-1a-public.id}"
  security_groups = ["${aws_security_group.ssh.id}","${aws_security_group.http.id}","${aws_security_group.allow_any_egress.id}"]
  associate_public_ip_address = true
}


resource "aws_instance" "web1" {
  ami           = "ami-c39604b0"
  instance_type = "t2.micro"
  availability_zone = "eu-west-1b"
  tags {
        Name = "web1"
  }
  key_name = "terraform"
  connection {
       user = "ec2-user"
  }
  provisioner "chef"  {
        environment = "_default"
        run_list = ["role[base]","recipe[linuxproblems::db]","recipe[linuxproblems::web]"]
        node_name = "web1"
        server_url = "https://api.opscode.com/organizations/quick"
        validation_client_name = "quick-validator"
        validation_key = "${file("/etc/chef/quick-validator.pem")}"
  }
  subnet_id = "${aws_subnet.eu-west-1b-public.id}"
  security_groups = ["${aws_security_group.ssh.id}","${aws_security_group.http.id}","${aws_security_group.allow_any_egress.id}"]
  associate_public_ip_address = true
}


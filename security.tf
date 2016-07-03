resource "aws_security_group" "ssh" {
    name = "vpc_ssh"
    description = "Allow incoming ssh connections."

    ingress {
      from_port = 22 
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "sshSG"
    }
}

resource "aws_security_group" "efs" {
    name = "efs"
    description = "Allow efs mount."

    ingress {
      from_port = 2049
      to_port = 2049
      protocol = "tcp"
      cidr_blocks = ["${var.eu-west-1a-public-cidr}","${var.eu-west-1b-public-cidr}"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "efsSG"
    }
}


resource "aws_security_group" "allow_any_egress" {
    name = "vpc_allow_any_egress"
    description = "Allow all outgoing connections."

    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "anyEgressSG"
    }
}


resource "aws_security_group" "http" {
    name = "vpc_http"
    description = "Allow incoming http connections."

    ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "httpSG"
    }
}

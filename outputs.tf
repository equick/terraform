#output "address" {
#  value = "${aws_elb.web.dns_name}"
#}


output "web0" {
  value = "${aws_instance.webserver.0.public_ip}"
}

output "web1" {
  value = "${aws_instance.webserver.1.public_ip}"
}

output "db0" {
  value = "${aws_instance.db.0.public_ip}"
}

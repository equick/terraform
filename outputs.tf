#output "address" {
#  value = "${aws_elb.web.dns_name}"
#}


output "web0" {
  value = "${aws_instance.web0.public_ip}"
}

output "web1" {
  value = "${aws_instance.web1.public_ip}"
}

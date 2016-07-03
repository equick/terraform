# Elastic Filesystem
resource "aws_efs_file_system" "wiki_efs" {
  reference_name = "wiki_efs"
  tags {
    Name = "wiki_efs"
  }
}

resource "aws_efs_mount_target" "wiki_efs-eu-west-1a" {
  file_system_id = "${aws_efs_file_system.wiki_efs.id}"
  subnet_id = "${aws_subnet.eu-west-1a-public.id}"
  security_groups = ["${aws_security_group.efs.id}"]
}

resource "aws_efs_mount_target" "wiki_efs-eu-west-1b" {
  file_system_id = "${aws_efs_file_system.wiki_efs.id}"
  subnet_id = "${aws_subnet.eu-west-1b-public.id}"
  security_groups = ["${aws_security_group.efs.id}"]
}

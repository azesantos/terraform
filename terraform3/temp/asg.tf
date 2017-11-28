#resource "random_id" "aze-ami" {
#   byte_length = 8
#}

#resource "aws_ami_from_instance" "golden" {
#    name = "ami-${random_id.aze-ami.b64}"
#    source_instance_id = "${aws_instance.aze-dev.id}"
#    provisioner "local-exec" {
#      command = <<EOT
#cat <<EOF > userdata
##!/bin/bash
#/usr/bin/aws s3 sync s3://${aws_s3_bucket.aze-code.bucket} /var/www/html/
#/bin/touch /var/spool/cron/root
#sudo /bin/echo '*/5 * * * * aws s3 sync s3://${aws_s3_bucket.aze-code.bucket} /var/www/html/' >> /var/spool/cron/root
#EOF
#EOT
#  }
#}

resource "aws_launch_configuration" "LC" {
   name_prefix = "lc-"
   image_id = "ami-aa1b34cf"
   instance_type = "${var.INS_TYPE}"
   security_groups = ["${aws_security_group.SG_WEB.id}", "${aws_security_group.SG_SSH.id}"]
#   iam_instance_profile = "${aws_iam_instance_profile.s3_azeaccess.id}"
   key_name = "${aws_key_pair.SSHKEY.id}"
   user_data = "${file("userdata")}"
   lifecycle {
      create_before_destroy = true
   }
}

resource "random_id" "RANDOM" {
 byte_length = 8
}

resource "aws_autoscaling_group" "ASG" {
  availability_zones = ["${var.AWS_REGION}a", "${var.AWS_REGION}b"]
  name = "asg-${aws_launch_configuration.LC.id}"
  max_size = "${var.ASG_MAX}"
  min_size = "${var.ASG_MIN}"
  health_check_grace_period = "${var.ASG_GRACE}"
  health_check_type = "${var.ASG_HCT}"
  desired_capacity = "${var.ASG_CAP}"
  force_delete = true
  load_balancers = ["${aws_elb.ELB.id}"]
  vpc_zone_identifier = ["${aws_subnet.SN_PRIVATE1.id}", "${aws_subnet.SN_PRIVATE2.id}"]
  launch_configuration = "${aws_launch_configuration.LC.name}"

  tag {
    key = "Name"
    value = "${var.ASG_INS}"
    propagate_at_launch = true
    }

  lifecycle {
    create_before_destroy = true
  }
}

resource "random_id" "aze-ami" {
   byte_length = 8
}

resource "aws_ami_from_instance" "golden" {
    name = "ami-${random_id.aze-ami.b64}"
    source_instance_id = "${aws_instance.aze-dev.id}"
    provisioner "local-exec" {
      command = <<EOT
cat <<EOF > userdata
#!/bin/bash
/usr/bin/aws s3 sync s3://${aws_s3_bucket.aze-code.bucket} /var/www/html/
/bin/touch /var/spool/cron/root
sudo /bin/echo '*/5 * * * * aws s3 sync s3://${aws_s3_bucket.aze-code.bucket} /var/www/html/' >> /var/spool/cron/root
EOF
EOT
  }
}

resource "aws_launch_configuration" "aze-lc" {
   name_prefix = "lc-"
   image_id = "${aws_ami_from_instance.golden.id}"
   instance_type = "${var.LC_INSTANCE_TYPE}"
   security_groups = ["${aws_security_group.aze-private.id}"]
   iam_instance_profile = "${aws_iam_instance_profile.s3_azeaccess.id}"
   key_name = "${aws_key_pair.aze-auth.id}"
   user_data = "${file("userdata")}"
   lifecycle {
      create_before_destroy = true
   }
}

resource "random_id" "aze-asg" {
 byte_length = 8
}


resource "aws_autoscaling_group" "asg" {
  availability_zones = ["${var.AWS_REGION}a", "${var.AWS_REGION}b"]
  name = "asg-${aws_launch_configuration.aze-lc.id}"
  max_size = "${var.ASG_MAX}"
  min_size = "${var.ASG_MIN}"
  health_check_grace_period = "${var.ASG_GRACE}"
  health_check_type = "${var.ASG_HCT}"
  desired_capacity = "${var.ASG_CAP}"
  force_delete = true
  load_balancers = ["${aws_elb.prod.id}"]
  vpc_zone_identifier = ["${aws_subnet.aze-private1.id}", "${aws_subnet.aze-private2.id}"]
  launch_configuration = "${aws_launch_configuration.aze-lc.name}"

  tag {
    key = "Name"
    value = "aze-asgins"
    propagate_at_launch = true
    }

  lifecycle {
    create_before_destroy = true
  }
}

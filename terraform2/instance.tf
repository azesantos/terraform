#################################
##########  INSTANCE  ###########
#################################

resource "aws_instance" "aze-dev" {
    instance_type = "${var.DEV_INSTANCE_TYPE}"
    ami = "${var.DEV_AMI}"
    tags {
      Name = "aze-dev"
    }

    key_name = "${aws_key_pair.aze-auth.id}"
    vpc_security_group_ids = ["${aws_security_group.aze-public.id}"]
    iam_instance_profile = "${aws_iam_instance_profile.s3_azeaccess.id}"
    subnet_id = "${aws_subnet.aze-public.id}"

    provisioner "local-exec" {
       command = <<EOD
cat <<EOF > aws_hosts 
[dev] 
${aws_instance.aze-dev.public_ip} 
[dev:vars] 
s3code=${aws_s3_bucket.aze-code.bucket} 
EOF
EOD
    }

    provisioner "local-exec" {
#	user = "${var.INSTANCE_USERNAME}"
        command = "sleep 6m && ansible-playbook -i aws_hosts wordpress.yml"
    }
}

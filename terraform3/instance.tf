#################################
##########  INSTANCE  ###########
#################################
#
#resource "aws_instance" "INS_NAT" {
#    instance_type = "${var.INS_TYPE}"
#    ami = "ami-021e3167"
#    tags {
#      Name = "${var.INS_NAT}"
#    }
#
#    key_name = "${aws_key_pair.SSHKEY.id}"
#    vpc_security_group_ids = ["${aws_security_group.SG_PUBLIC.id}"]
#    subnet_id = "${aws_subnet.SN_PUBLIC2.id}"
#}
#
resource "aws_instance" "INS_BASTION" {
    instance_type = "${var.INS_TYPE}"
    ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
    tags {
      Name = "${var.INS_BASTION}"
    }

    key_name = "${var.SSH_KEYNAME}"
    vpc_security_group_ids = ["sg-c5abf3ad", "sg-4ca9f124"]
    subnet_id = "subnet-c86093a0"
}

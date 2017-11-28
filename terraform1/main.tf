provider "aws" {
   region     = "${var.AWS_REGION}"
   profile    = "${var.AWS_PROFILE}"
}

#################################
##########  KEY PAIR  ###########
#################################

resource "aws_key_pair" "SSHKEY" {
   key_name = "${var.SSH_KEYNAME}"
   public_key = "${file("${var.SSH_PUBLICPATH}")}"
}

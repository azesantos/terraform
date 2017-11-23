#################################
#######  SECURITY GROUPS  #######
#################################

resource "aws_security_group" "SG_BASTION" {
   name = "SG_BASTION"
   description = "Allow Access to Bastion Server"
   vpc_id = "${aws_vpc.VPC.id}"

   ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["${var.LOCALIP}"]
   }

   egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
   }

   tags {
      Name = "${var.SG_BASTION}"
   }
}

resource "aws_security_group" "SG_PUBLIC" {
   name = "SG_PUBLIC"
   description = "Allow external access"
   vpc_id = "${aws_vpc.VPC.id}"

   ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
   }
   egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
   }

   tags {
      Name = "${var.SG_PUBLIC}"
   }
}

resource "aws_security_group" "SG_SSH" {
   name = "SG_SSH"
   description = "Access private instances via Bastion Server"
   vpc_id = "${aws_vpc.VPC.id}"

   ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["${aws_instance.INS_BASTION.private_ip}/32"]
   }

   egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
   }

   tags {
      Name = "${var.SG_SSH}"
   }
}

resource "aws_security_group" "SG_WEB" {
   name = "SG_WEB"
   description = "Access private instances via Bastion Server"
   vpc_id = "${aws_vpc.VPC.id}"

   ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["${aws_instance.INS_NAT.private_ip}/32"]
   }

   egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
   }

   tags {
      Name = "${var.SG_WEB}"
   }
}

resource "aws_security_group" "SG_RDS" {
   name = "SG_RDS"
   description = "Used for DB Instances"
   vpc_id = "${aws_vpc.VPC.id}"

   ingress {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      security_groups  = ["${aws_security_group.SG_PUBLIC.id}", "${aws_security_group.SG_BASTION.id}"]
   }

   tags {
      Name = "${var.RDS}"
   }
}

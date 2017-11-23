#################################
#######  SECURITY GROUPS  #######
#################################

resource "aws_security_group" "aze-public" {
   name = "aze-sgpub"
   description = "Used for public and load  balancers"
   vpc_id = "${aws_vpc.aze-vpc.id}"

  ## SSH ##

   ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["${var.LOCALIP}"]
   }

  ## HTTP ##

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
      Name = "aze-sgpub"
   }
}

resource "aws_security_group" "aze-private" {
   name = "aze-sgpriv"
   description = "Used for private instances"
   vpc_id = "${aws_vpc.aze-vpc.id}"

   ## SSH ##

   ingress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["11.0.10.0/25"]
   }

   egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
   }

   tags {
      Name = "aze-sgpriv"
   }
}

resource "aws_security_group" "aze-rds" {
   name = "aze-sgrds"
   description = "Used for DB Instances"
   vpc_id = "${aws_vpc.aze-vpc.id}"

   ingress {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      security_groups  = ["${aws_security_group.aze-public.id}", "${aws_security_group.aze-private.id}"]
   }

   tags {
      Name = "aze-sgrds"
   }
}


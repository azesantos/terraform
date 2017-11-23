#################################
#######  CREATE SUBNETS  ########
#################################

## PUBLIC SUBNET 1 ##
resource "aws_subnet" "SN_PUBLIC1" {
   vpc_id = "${aws_vpc.VPC.id}"
   cidr_block = "11.0.10.0/25"
   map_public_ip_on_launch = true
   availability_zone = "us-east-2a"

   tags {
      Name = "${var.SN_PUBLIC1}"
   }
}

## PUBLIC SUBNET 2 ##
resource "aws_subnet" "SN_PUBLIC2" {
   vpc_id = "${aws_vpc.VPC.id}"
   cidr_block = "11.0.10.128/25"
   map_public_ip_on_launch = true
   availability_zone = "us-east-2b"

   tags {
      Name = "${var.SN_PUBLIC2}"
   }
}

## PRIVATE SUBNET 1 ##

resource "aws_subnet" "SN_PRIVATE1" {
   vpc_id = "${aws_vpc.VPC.id}"
   cidr_block = "11.0.11.0/25"
   map_public_ip_on_launch = false
   availability_zone = "us-east-2a"

   tags {
      Name = "${var.SN_PRIVATE1}"
   }
}

## PRIVATE SUBNET 2 ##

resource "aws_subnet" "SN_PRIVATE2" {
   vpc_id = "${aws_vpc.VPC.id}"
   cidr_block = "11.0.11.128/25"
   map_public_ip_on_launch = false
   availability_zone = "us-east-2b"

   tags {
      Name = "${var.SN_PRIVATE2}"
   }
}

## RDS SUBNET 1 ##

resource "aws_subnet" "SN_RDS1" {
   vpc_id = "${aws_vpc.VPC.id}"
   cidr_block = "11.0.12.0/25"
   map_public_ip_on_launch = false
   availability_zone = "us-east-2a"

  tags {
         Name = "${var.SN_RDS1}"
   }
}

## RDS SUBNET 2 ##

resource "aws_subnet" "SN_RDS2" {
   vpc_id = "${aws_vpc.VPC.id}"
   cidr_block = "11.0.12.128/25"
   map_public_ip_on_launch = false
   availability_zone = "us-east-2b"

   tags {
      Name = "${var.SN_RDS2}"
   }
}


#################################
#####  SUBNET ASSOCIATIONS  #####
#################################


resource "aws_route_table_association" "RTA_PUBLIC1" {
   subnet_id = "${aws_subnet.SN_PUBLIC1.id}"
   route_table_id = "${aws_route_table.RT_PUBLIC.id}"
}

resource "aws_route_table_association" "RTA_PUBLIC2" {
   subnet_id = "${aws_subnet.SN_PUBLIC2.id}"
   route_table_id = "${aws_route_table.RT_PUBLIC.id}"
}

resource "aws_route_table_association" "RTA_PRIVATE1" {
   subnet_id = "${aws_subnet.SN_PRIVATE1.id}"
   route_table_id = "${aws_route_table.RT_PRIVATE.id}"
}

resource "aws_route_table_association" "RTA_PRIVATE2" {
   subnet_id = "${aws_subnet.SN_PRIVATE2.id}"
   route_table_id = "${aws_route_table.RT_PRIVATE.id}"
}

resource "aws_route_table_association" "RTA_RDS1" {
   subnet_id = "${aws_subnet.SN_RDS1.id}"
   route_table_id = "${aws_route_table.RT_PRIVATE.id}"
}

resource "aws_route_table_association" "RTA_RDS2" {
   subnet_id = "${aws_subnet.SN_RDS2.id}"
   route_table_id = "${aws_route_table.RT_PRIVATE.id}"
}

resource "aws_db_subnet_group" "SNG_RDS" {
   name = "tf_sngrds"
   subnet_ids = ["${aws_subnet.SN_RDS1.id}", "${aws_subnet.SN_RDS2.id}"]
   tags {
      Name = "${var.SNG_RDS}"
   }
}

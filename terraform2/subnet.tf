#################################
#######  CREATE SUBNETS  ########
#################################

## PUBLIC SUBNET ##
resource "aws_subnet" "aze-public" {
   vpc_id = "${aws_vpc.aze-vpc.id}"
   cidr_block = "11.0.10.0/25"
   map_public_ip_on_launch = true
   availability_zone = "us-east-2a"

   tags {
      Name = "aze-public"
   }
}

## PRIVATE SUBNET 1 ##

resource "aws_subnet" "aze-private1" {
   vpc_id = "${aws_vpc.aze-vpc.id}"
   cidr_block = "11.0.11.0/25"
   map_public_ip_on_launch = false
   availability_zone = "us-east-2a"

   tags {
      Name = "aze-private1"
   }
}

## PRIVATE SUBNET 2 ##

resource "aws_subnet" "aze-private2" {
   vpc_id = "${aws_vpc.aze-vpc.id}"
   cidr_block = "11.0.12.0/25"
   map_public_ip_on_launch = false
   availability_zone = "us-east-2b"

   tags {
      Name = "aze-private2"
   }
}

## S3 VPC endpoint ##

resource "aws_vpc_endpoint" "aze-privates3" {
   vpc_id = "${aws_vpc.aze-vpc.id}"
   service_name = "com.amazonaws.${var.AWS_REGION}.s3"
   route_table_ids = ["${aws_vpc.aze-vpc.main_route_table_id}", "${aws_route_table.aze-public.id}"]
   policy = <<POLICY
{
  "Statement": [
      {
          "Action": "*",
          "Effect": "Allow",
          "Resource": "*",
          "Principal": "*"
      }
   ]
}
POLICY
}

## RDS SUBNET 1 ##

resource "aws_subnet" "aze-rds1" {
   vpc_id = "${aws_vpc.aze-vpc.id}"
   cidr_block = "11.0.11.128/25"
   map_public_ip_on_launch = false
   availability_zone = "us-east-2a"

  tags {
         Name = "aze-rds1"
   }
}

## RDS SUBNET 2 ##

resource "aws_subnet" "aze-rds2" {
   vpc_id = "${aws_vpc.aze-vpc.id}"
   cidr_block = "11.0.12.128/25"
   map_public_ip_on_launch = false
   availability_zone = "us-east-2b"

   tags {
      Name = "aze-rds2"
   }
}

## RDS SUBNET 3 ##

resource "aws_subnet" "aze-rds3" {
   vpc_id = "${aws_vpc.aze-vpc.id}"
   cidr_block = "11.0.10.128/25"
   map_public_ip_on_launch = false
   availability_zone = "us-east-2b"

   tags {
      Name = "aze-rds3"
   }
}


#################################
#####  SUBNET ASSOCIATIONS  #####
#################################


resource "aws_route_table_association" "aze-pubassoc" {
   subnet_id = "${aws_subnet.aze-public.id}"
   route_table_id = "${aws_route_table.aze-public.id}"
}

resource "aws_route_table_association" "aze-priv1assoc" {
   subnet_id = "${aws_subnet.aze-private1.id}"
   route_table_id = "${aws_route_table.aze-public.id}"
}

resource "aws_route_table_association" "aze-priv2assoc" {
   subnet_id = "${aws_subnet.aze-private2.id}"
   route_table_id = "${aws_route_table.aze-public.id}"
}

resource "aws_db_subnet_group" "aze_rdssnetgrp" {
   name = "aze_rdssnetgrp"
   subnet_ids = ["${aws_subnet.aze-rds1.id}", "${aws_subnet.aze-rds2.id}", "${aws_subnet.aze-rds3.id}"]
   tags {
      Name = "aze-rdssng"
   }
}

################################
########   CREATE VPC   ########
################################

resource "aws_vpc" "VPC" {
   cidr_block = "11.0.0.0/16"
   tags {
       Name = "${var.VPC}"
   }
}

#################################
###  CREATE INTERNET GATEWAY  ###
#################################

resource "aws_internet_gateway" "IGW" {
   vpc_id = "${aws_vpc.VPC.id}"
   tags {
       Name = "${var.IGW}"
   }
}

#################################
#####  CREATE  ROUTE TABLE  #####
#################################

## PUBLIC ##

resource "aws_route_table" "RT_PUBLIC" {
   vpc_id = "${aws_vpc.VPC.id}"
   route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.IGW.id}"
      }
   tags {
      Name = "${var.RT_PUBLIC}"
   }
}

## PRIVATE ##
resource "aws_route_table" "RT_PRIVATE" {
   vpc_id = "${aws_vpc.VPC.id}"
   route {
      cidr_block = "0.0.0.0/0"
      instance_id = "${aws_instance.INS_NAT.id}"
      }
   tags {
      Name = "${var.RT_PRIVATE}"
   }
}

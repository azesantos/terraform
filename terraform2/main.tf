provider "aws" {
   region     = "${var.AWS_REGION}"
   profile    = "${var.AWS_PROFILE}"
}

################################
########   CREATE VPC   ########
################################

resource "aws_vpc" "aze-vpc" {
   cidr_block = "11.0.0.0/16"
   tags {
       Name = "aze-vpc"
   }
}

#################################
###  CREATE INTERNET GATEWAY  ###
#################################

resource "aws_internet_gateway" "aze-igw" {
   vpc_id = "${aws_vpc.aze-vpc.id}"
   tags {
       Name = "aze-igw"
   }
}

#################################
#####  CREATE  ROUTE TABLE  #####
#################################

## PUBLIC ##

resource "aws_route_table" "aze-public" {
   vpc_id = "${aws_vpc.aze-vpc.id}"
   route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.aze-igw.id}"
      }
   tags {
      Name = "aze-public"
   }
}

## PRIVATE ##
resource "aws_default_route_table" "aze-private" {
   default_route_table_id = "${aws_vpc.aze-vpc.default_route_table_id}"
   tags {
      Name = "aze-private"
   }
}

#################################
##########  KEY PAIR  ###########
#################################

resource "aws_key_pair" "aze-auth" {
   key_name = "${var.KEY_NAME}"
   public_key = "${file("${var.PUBLIC_KEY_PATH}")}"
}

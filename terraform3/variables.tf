################################
###########    VPC   ###########
################################

variable "AWS_REGION" {
  default = "us-east-2"
}
variable "AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-6057e21a"
    us-east-2 = "ami-aa1b34cf"
    us-west-1 = "ami-1a033c7a"
  }
}

variable "AWS_PROFILE" {}
variable "VPC" {}
variable "IGW" {}
variable "RT_PUBLIC" {}
variable "RT_PRIVATE" {}

variable "LOCALIP" {}
variable "SSH_KEYNAME" {}
variable "SSH_PUBLICPATH" {}

################################
#########   SUBNETS   ##########
################################

variable "SN_PUBLIC1" {}
variable "SN_PUBLIC2" {}
variable "SN_PRIVATE1" {}
variable "SN_PRIVATE2" {}
variable "SN_RDS1" {}
variable "SN_RDS2" {}
variable "RTA_PUBLIC1" {}
variable "RTA_PUBLIC2" {}
variable "SNG_RDS" {}

################################
######  SECURITY GROUPS  #######
################################

variable "SG_BASTION" {}
variable "SG_PUBLIC" {}
variable "SG_RDS" {}
variable "SG_SSH" {}
variable "SG_WEB" {}

################################
#########  INSTANCES  ##########
################################

variable "INS_TYPE" {}
variable "INS_NAT" {}
variable "INS_BASTION" {}

################################
############  RDS  #############
################################

variable "RDS" {}
variable "DB_INSTANCE_CLASS" {}
variable "DB_NAME" {}
variable "DB_USER" {}
variable "DB_PASSWD" {}

################################
############  ELB  #############
################################

variable "ELB" {}
variable "ELB_HEALTHY_THRESHOLD" {}
variable "ELB_UNHEALTHY_THRESHOLD" {}
variable "ELB_TIMEOUT" {}
variable "ELB_INTERVAL" {}

################################
############  ASG  #############
################################

variable "ASG_INS" {}
variable "ASG_MAX" {}
variable "ASG_MIN" {}
variable "ASG_GRACE" {}
variable "ASG_HCT" {}
variable "ASG_CAP" {}

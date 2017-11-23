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
variable "LOCALIP" {}
variable "DB_INSTANCE_CLASS" {}
variable "DB_NAME" {}
variable "DB_USER" {}
variable "DB_PASSWD" {}
variable "KEY_NAME" {}
variable "PUBLIC_KEY_PATH" {}
variable "DEV_INSTANCE_TYPE" {}
variable "DEV_AMI" {}
variable "INSTANCE_USERNAME" {}
variable "DOMAIN_NAME" {}
variable "ELB_HEALTHY_THRESHOLD" {}
variable "ELB_UNHEALTHY_THRESHOLD" {}
variable "ELB_TIMEOUT" {}
variable "ELB_INTERVAL" {}
variable "ASG_MAX" {}
variable "ASG_MIN" {}
variable "ASG_GRACE" {}
variable "ASG_HCT" {}
variable "ASG_CAP" {}
variable "LC_INSTANCE_TYPE" {}

#################################
#############  RDS  #############
#################################

resource "aws_db_instance" "db" {
   allocated_storage    = 10
   engine               = "mysql"
   engine_version       = "5.6.37"
   instance_class       = "${var.DB_INSTANCE_CLASS}"
   name                 = "${var.DB_NAME}"
   username             = "${var.DB_USER}"
   password             = "${var.DB_PASSWD}"
   db_subnet_group_name = "${aws_db_subnet_group.aze_rdssnetgrp.name}"
   vpc_security_group_ids = ["${aws_security_group.aze-rds.id}"]
   skip_final_snapshot  = true
}

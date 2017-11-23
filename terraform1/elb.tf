resource "aws_elb" "ELB" {
   name = "ELB"
   subnets = ["${aws_subnet.SN_PRIVATE1.id}", "${aws_subnet.SN_PRIVATE2.id}"]
   security_groups = ["${aws_security_group.SG_WEB.id}"]
   listener {
      instance_port = 80
      instance_protocol = "http"
      lb_port = 80
      lb_protocol = "http"
   }

   health_check {
      healthy_threshold = "${var.ELB_HEALTHY_THRESHOLD}"
      unhealthy_threshold = "${var.ELB_UNHEALTHY_THRESHOLD}"
      timeout = "${var.ELB_TIMEOUT}"
      target = "HTTP:80/"
      interval = "${var.ELB_INTERVAL}"
   }

   cross_zone_load_balancing = true
   idle_timeout = 400
   connection_draining = true
   connection_draining_timeout = 400
   
   tags {
       Name = "${var.ELB}"
   }
}



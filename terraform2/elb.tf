resource "aws_elb" "prod" {
   name = "${var.DOMAIN_NAME}-prod-elb"
   subnets = ["${aws_subnet.aze-private1.id}", "${aws_subnet.aze-private2.id}"]
   security_groups = ["${aws_security_group.aze-public.id}"]
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
       Name = "${var.DOMAIN_NAME}-prod-elb"
   }
}



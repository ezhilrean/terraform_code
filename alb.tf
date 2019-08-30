#create a basic Alb 

resource "aws_lb" "infra-alb" {
   name = "infra-alb"
   internal           = false
   load_balancer_type = "application"
   security_groups    = ["${aws_security_group.instance.id}"]
   subnets            = ["${aws_subnet.public-subnet1.id}","${aws_subnet.public-subnet2.id}"]
   enable_deletion_protection = false

  }

#create target group with health check  

resource "aws_lb_target_group" "target-group-1" {
   name = "target-group-1"
   port = 80
   vpc_id   = "${aws_vpc.infra_vpc.id}"
   protocol = "HTTP"
   
   lifecycle { create_before_destroy=true }
   
   health_check {
      path = "/index.php"
 port = 80
 healthy_threshold = 6
 unhealthy_threshold = 2
 timeout = 2 
 interval =5 
 matcher = "302"
}

  }

#create a listener 

resource "aws_lb_listener" "infra-alb-listener" {
   default_action {
      target_group_arn = "${aws_lb_target_group.target-group-1.arn}"
      type = "forward"
     }

   load_balancer_arn = "${aws_lb.infra-alb.arn}"	
   port = 80
   protocol = "HTTP"

  }


#create Listener rule 

resource "aws_lb_listener_rule" "rule-1" {
   action {
      target_group_arn = "${aws_lb_target_group.target-group-1.arn}"
      type = "forward"
   }

   condition { 
       field="path-pattern"
       values=["/var/www/html/index.php"] 
     }
   listener_arn = "${aws_lb_listener.infra-alb-listener.id}"
   priority = 100
   
 }

#resource "aws_autoscaling_attachment" "alb_autoscale" {
#  alb_target_group_arn   = "${aws_lb_target_group.target-group-1.arn}"
#  autoscaling_group_name = "${aws_autoscaling_group.tcl-autoscaling.id}"
#}

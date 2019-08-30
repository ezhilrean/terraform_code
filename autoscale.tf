resource "aws_launch_configuration" "tcl-launchconfig" {
  name_prefix          = "tcl-launchconfig"
  image_id             = "${var.ami_id}"
  instance_type        = "t2.micro"
  key_name             = "${var.key_name}"
  security_groups      = ["${aws_security_group.instance.id}"]
  iam_instance_profile = "ec2_iam_profile"
  lifecycle              { create_before_destroy = true }
}

resource "aws_autoscaling_group" "tcl-autoscaling" {
  name                 = "tcl-autoscaling"
  vpc_zone_identifier  = ["${aws_subnet.public-subnet1.id}", "${aws_subnet.public-subnet2.id}"]
  launch_configuration = "${aws_launch_configuration.tcl-launchconfig.id}"
  min_size             = 2
  max_size             = 4
  health_check_grace_period = 300
  health_check_type = "ELB"
  target_group_arns = ["${aws_lb_target_group.target-group-1.arn}"]
  force_delete = true

  tag {
      key = "Name"
      value = "ec2 instance"
      propagate_at_launch = true
  }
}



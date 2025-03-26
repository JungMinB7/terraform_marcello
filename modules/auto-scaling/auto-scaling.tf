resource "aws_launch_template" "launch_template" {
  name_prefix   = "${var.launch_template_name}-lt"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [var.security_group_id]
  user_data              = base64encode(var.user_data)

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.launch_template_name}-ec2"
    }
  }
}

resource "aws_autoscaling_group" "autoscaling_group" {
  name                      = "${var.autoscaling_group_name}-asg"
  vpc_zone_identifier       = var.subnet_ids
  desired_capacity          = var.desired_capacity
  max_size                  = var.max_size
  min_size                  = var.min_size
  target_group_arns         = var.target_group_arns
  health_check_type         = "ELB"
  health_check_grace_period = 30
  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.autoscaling_group_name}-ec2"
    propagate_at_launch = true
  }
}

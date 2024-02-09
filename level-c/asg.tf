resource "aws_launch_template" "worker_nodes" {

  name          = "${local.node_name}-lt"
  key_name      = local.node_name
  description   = "TF stacks demo launch template"
  instance_type = "t3.micro"
  image_id      =  data.aws_ami.amazon2.id

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      delete_on_termination = true
      volume_size           = 10
      volume_type           = "gp3"
    }
  }
  
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [data.aws_security_group.https.id]
    delete_on_termination       = true
  }

  tags = local.tags

}

resource "aws_autoscaling_group" "default" {

  name                = local.node_name
  max_size            = 5
  min_size            = 1
  desired_capacity    = 1
  force_delete        = true
  vpc_zone_identifier = [data.aws_subnet.main1.id, data.aws_subnet.main2.id]

  launch_template {
    id      = aws_launch_template.worker_nodes.id
    version = "$Latest"
  }

  tag {
    key                 = "terraform_state"
    value               = "level-c"
    propagate_at_launch = true
  }

  tag {
    key                 = "terraform_workspace"
    value               = var.environment_code
    propagate_at_launch = true
  }
}

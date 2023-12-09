resource "aws_instance" "k8s" {
  count                  = 3
  ami                    = var.ami_id
  instance_type          = var.instance_type
  //subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.rancher_k8s.id]
  key_name               = var.key_name
  ebs_optimized          = true

  user_data = data.template_cloudinit_config.rancher_k8s_just_docker_install.rendered
  lifecycle {
    ignore_changes = [user_data]
  }
  root_block_device {
    volume_size = 30
    volume_type = "standard"
    tags = merge(
      local.common_tags,
      {
        Name = "Rancher K8s ${count.index + 1}"
      }
    )
  }

  tags = merge(
    local.common_tags,
    {
      Name = "Rancher K8s ${count.index + 1}"
    }
  )
}

resource "aws_instance" "rancher_server" {
  count                  = 1
  ami                    = var.ami_id
  instance_type          = var.instance_type
 // subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.rancher_k8s.id]
  key_name               = var.key_name
  ebs_optimized          = true

  user_data = data.template_cloudinit_config.rancher_k8s_install.rendered
  lifecycle {
    ignore_changes = [user_data]
  }
  root_block_device {
    volume_size = 30
    volume_type = "standard"
    tags = merge(
      local.common_tags,
      {
        Name = "Rancher Server"
      }
    )
  }

  tags = merge(
    local.common_tags,
    {
      Name = "Rancher Server"
    }
  )
}

resource "aws_security_group" "rancher_k8s" {
  name        = "Rancher K8s"
  description = "Security group to Rancher K8s Instances"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "All"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
    local.common_tags,
    {
      Name = "rancher-k8s"
    }
  )
}

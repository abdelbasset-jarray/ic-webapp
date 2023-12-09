resource "aws_instance" "DC_Server_Dev-ec2" {
  ami               = "ami-033b95fb8079dc481"
  instance_type     = var.instance_type
  key_name          = var.ssh_key
  availability_zone = var.AZ
  security_groups   = ["${var.sg_name}"]
  tags = {
    Name = "${var.server_name}-ec2"
  }

  root_block_device {
    delete_on_termination = true
  }

  provisioner "local-exec" {
    command = "echo IP: ${var.public_ip} > /var/lib/jenkins/workspace/${var.projet_name}/public_ip.txt"
  }

}


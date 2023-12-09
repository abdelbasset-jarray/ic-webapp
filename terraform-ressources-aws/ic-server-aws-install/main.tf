resource "aws_iam_role" "example_role" {
  name = "IC_server-terraform"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "example_attachment" {
  role       = aws_iam_role.example_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "example_profile" {
  name = "IC_server-terraform"
  role = aws_iam_role.example_role.name
}


resource "aws_security_group" "IC_server-sg" {
  name        = "IC_server-Security Group"
  description = "Open 22,443,80,8080,9000"

  # Définir une règle d'entrée unique pour autoriser le trafic sur tous les ports spécifiés
  ingress = [
    for port in [22, 80, 443, 8080, 9000] : {
      description      = "TLS from VPC"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "IC_server-sg"
  }
}
resource "aws_instance" "IC_server" {
  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = "t2.large"
  key_name               = "devops"
  vpc_security_group_ids = [aws_security_group.IC_server-sg.id]
  user_data              = templatefile("./ic_server_install.sh", {})
  iam_instance_profile   = aws_iam_instance_profile.example_profile.name

  tags = {
    Name = "IC_server"
  }

  root_block_device {
    volume_size = 30
  }
}
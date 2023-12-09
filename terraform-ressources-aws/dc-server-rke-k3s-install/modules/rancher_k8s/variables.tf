variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AWS instance ami id"
  default     = "ami-0fc5d935ebf8bc3bc"
}

variable "instance_type" {
  description = "AWS instance type"
  default     = "t3.medium"
}

variable "subnet_id" {
  description = "AWS subnet id"
  default     = "subnet-"
}

variable "vpc_id" {
  description = "AWS VCP id"
  default     = "vpc-00e4b14c1c803d8fb"
}

variable "key_name" {
  type        = string
  description = "ssh key name"
  default     = "devops"
}

output "output_ec2_id" {
  value = aws_instance.DC_Server_Dev-ec2.id
}

output "output_ec2_AZ" {
  value = aws_instance.DC_Server_Dev-ec2.availability_zone
}

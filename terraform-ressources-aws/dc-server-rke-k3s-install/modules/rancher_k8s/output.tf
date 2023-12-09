output "k8s_security_group_ingress" {
  value = aws_security_group.rancher_k8s[*].ingress
}

output "k8s_aws_ec2_name" {
  value = aws_instance.k8s[*].tags.Name
}

output "k8s_aws_ec2_type" {
  value = aws_instance.k8s[*].instance_type
}

output "k8s_public_ip" {
  value = aws_instance.k8s[*].public_ip
}

output "k8s_security_group_all_tags" {
  value = aws_security_group.rancher_k8s[*].tags_all
}

output "rancher_aws_ec2_name" {
  value = aws_instance.rancher_server[*].tags.Name
}

output "rancher_aws_ec2_type" {
  value = aws_instance.rancher_server[*].instance_type
}

output "rancher_public_ip" {
  value = aws_instance.rancher_server[*].public_ip
}

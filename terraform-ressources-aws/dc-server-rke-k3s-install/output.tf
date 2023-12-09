output "rancher_aws_ec2_name" {
  value = module.rancher_k8s.rancher_aws_ec2_name
}

output "rancher_aws_ec2_type" {
  value = module.rancher_k8s.rancher_aws_ec2_type
}

output "rancher_public_ip" {
  value = module.rancher_k8s.rancher_public_ip
}

output "k8s_aws_ec2_name" {
  value = module.rancher_k8s.k8s_aws_ec2_name
}

output "k8s_aws_ec2_type" {
  value = module.rancher_k8s.k8s_aws_ec2_type
}

output "k8s_public_ip" {
  value = module.rancher_k8s.k8s_public_ip
}

output "k8s_security_group" {
  value = module.rancher_k8s.k8s_security_group_all_tags
}

output "k8s_security_group_rules" {
  value = module.rancher_k8s.k8s_security_group_ingress
}

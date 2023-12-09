variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "Cluster_name" {
  description = "Cluster Name"
  type        = string
  default     = "DC_Server-Cluster-K8S-Prod"
}

variable "VPC_name" {
  description = "VPC Name"
  type        = string
  default     = "DC_Server-Cluster-K8S-Prod"
}

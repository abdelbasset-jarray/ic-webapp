terraform {
  backend "s3" {
    bucket = "mpwin-terrafom-awsbucket" 
    key    = "EKS/terraform.tfstate"
    region = "us-east-1"
  }
}
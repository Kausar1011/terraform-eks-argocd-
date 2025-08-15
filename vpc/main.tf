module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = ">= 5.0"

  name = "${var.cluster_name}-vpc"
  cidr = var.vpc_cidr

  azs            = ["${var.aws_region}a", "${var.aws_region}b"]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Project = var.cluster_name
  }
}


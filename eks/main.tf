# Get VPC outputs from step1
data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../step1-vpc/terraform.tfstate"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = ">= 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.vpc.outputs.public_subnets

  eks_managed_node_groups = {
    default = {
      desired_size  = 2
      min_size      = 2
      max_size      = 3
      instance_types = ["t3.medium"]
    }
  }

  tags = {
    Project = var.cluster_name
  }
}


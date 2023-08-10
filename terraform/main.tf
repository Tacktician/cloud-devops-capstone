provider "aws" {
  region = "us-west-2"  # Set your desired region here
}

module "network" {
  source            = "./network"  # Path to the network module
}

module "eks" {
  source            = "./eks"  # Path to the EKS module
  depends_on        = [module.network]
  generated_vpc_id  = module.network.stack_vpc
  public_subnet1_id = module.network.stack_public_subnet_1
  public_subnet2_id = module.network.stack_public_subnet_2
  cluster_role_arn  = module.network.cluster_role_arn
  node_group_arn    = module.network.node_group_arn

}
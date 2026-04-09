provider "aws" {
  region = var.aws_region
}

module "networking" {
  source   = "./modules/networking"
  #app_name = var.app_name
}

module "security" {
  source = "./modules/security"
  vpc_id = module.networking.vpc_id
}

module "iam" {
  source = "./modules/iam"

  keystore_secret_arn   = var.keystore_secret_arn
  truststore_secret_arn = var.truststore_secret_arn
}

module "cloudwatch" {
  source   = "./modules/cloudwatch"
  app_name = var.app_name
}

module "nlb" {
  source         = "./modules/nlb"
  vpc_id         = module.networking.vpc_id
  public_subnets = module.networking.public_subnets
}

module "ecs" {
  source             = "./modules/ecs"
  app_name           = var.app_name
  subnets            = module.networking.private_subnets
  security_group     = module.security.ecs_sg
  target_group_arn   = module.nlb.target_group_arn
  execution_role_arn = module.iam.execution_role_arn
  task_role_arn      = module.iam.task_role_arn
  log_group_name     = module.cloudwatch.log_group_name

  ecr_image             = var.ecr_image
  keystore_secret_arn   = var.keystore_secret_arn
  truststore_secret_arn = var.truststore_secret_arn
}

module "route53" {
  source      = "./modules/route53"
  domain_name = var.domain_name
  nlb_dns     = module.nlb.nlb_dns
}

module "autoscaling" {
  source           = "./modules/autoscaling"
  cluster_name     = module.ecs.cluster_name
  ecs_service_name = module.ecs.service_name
}

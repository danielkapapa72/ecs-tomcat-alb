output "private_subnets" {
  value = module.networking.private_subnets
}

output "public_subnets" {
  value = module.networking.public_subnets
}

output "vpc_id" {
  value = module.networking.vpc_id
}

output "ecs_sg" {
  value = module.security.ecs_sg
}

output "nlb_dns" {
  value = module.nlb.nlb_dns
}
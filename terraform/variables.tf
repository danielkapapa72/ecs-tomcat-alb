variable "aws_region" {
  default = "us-east-1"
}

variable "app_name" {
  default = "tomcat-mtls"
}

variable "ecr_image" {
  description = "ECR image URI"
}

variable "keystore_secret_arn" {
  description = "Secrets Manager ARN for keystore"
}

variable "truststore_secret_arn" {
  description = "Secrets Manager ARN for truststore"
}

variable "domain_name" {
  description = "Route53 domain"
}

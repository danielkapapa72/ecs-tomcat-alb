variable "app_name" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "security_group" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "execution_role_arn" {
  type = string
}

variable "task_role_arn" {
  type = string
}

variable "log_group_name" {
  type = string
}

variable "ecr_image" {
  type = string
}

variable "keystore_secret_arn" {
  type = string
}

variable "truststore_secret_arn" {
  type = string
}
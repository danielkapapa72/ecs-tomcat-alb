terraform {
  backend "s3" {
    bucket         = "dankaptfstate54"
    key            = "ecs-nlb-project/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}
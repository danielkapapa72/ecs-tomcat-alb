resource "aws_security_group" "ecs" {
  name        = "ecs-sg"
  description = "Allow HTTPS traffic to ECS"
  vpc_id      = var.vpc_id

  # 🔐 Allow inbound HTTPS (mTLS traffic from NLB)
  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # 🌍 Allow outbound (required for ECS to work)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecs-security-group"
  }
}

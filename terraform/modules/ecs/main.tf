resource "aws_ecs_cluster" "this" {
  name = "${var.app_name}-cluster"
}

resource "aws_ecs_task_definition" "this" {
  family                   = var.app_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"

  execution_role_arn = var.execution_role_arn
  task_role_arn      = var.task_role_arn

  container_definitions = jsonencode([
    {
      name  = "tomcat"
      image = var.ecr_image

      portMappings = [{
        containerPort = 8443
      }]

      secrets = [
        {
          name      = "KEYSTORE_B64"
          valueFrom = var.keystore_secret_arn
        },
        {
          name      = "TRUSTSTORE_B64"
          valueFrom = var.truststore_secret_arn
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.log_group_name
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "this" {
  name            = var.app_name
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  launch_type     = "FARGATE"

  desired_count = 1

  network_configuration {
    subnets         = var.subnets
    security_groups = [var.security_group]
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "tomcat"
    container_port   = 8443
  }
}

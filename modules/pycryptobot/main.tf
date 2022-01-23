# ECS CLUSTER DECLARATION

resource "aws_ecs_cluster" "pycryptobot_cluster" {
  name               = "pycryptobot_cluster"
  capacity_providers = ["FARGATE"]
}

# ECR REPO DECLARATION

resource "aws_ecr_repository" "main" {
  name = "giacomo.rognoni/pycryptobot/${var.name}"
}

# ECR LIFECYCLE INGESTION POLICY

resource "aws_ecr_lifecycle_policy" "main" {
  repository = aws_ecr_repository.main.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 10 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 10
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

# ECS SERVICE DECLARATION

resource "aws_ecs_service" "pycryptobot1" {
  name            = var.name
  cluster         = aws_ecs_cluster.pycryptobot_cluster.id
  task_definition = aws_ecs_task_definition.service.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  lifecycle {
    ignore_changes = [task_definition]
  }

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id, var.aws_alb_security_group]
    subnets          = var.subnets.*.id
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.aws_alb_target_group_arn
    container_name   = "${var.name}-container-${var.environment}"
    container_port   = 0
  }

}

# ECS TASK DEFINTIION
resource "aws_ecs_task_definition" "service" {
  family                   = var.name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = aws_iam_role.ecs_role.arn
  task_role_arn            = aws_iam_role.ecs_task.arn
  container_definitions = jsonencode([
    {
      name      = "${var.name}"
      image     = "public.ecr.aws/ubuntu/redis:latest"
      essential = true
  }])

}

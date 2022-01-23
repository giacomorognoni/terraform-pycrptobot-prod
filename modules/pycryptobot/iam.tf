## ECS task execution role

resource "aws_iam_role" "ecs_role" {
  name = "${var.name}-ecs-role"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
	{
	  "Sid": "",
	  "Effect": "Allow",
	  "Principal": {
		"Service": "ecs.amazonaws.com"
	  },
	  "Action": "sts:AssumeRole"
	}
  ]
}
EOF
}

data "aws_iam_policy_document" "ecs_task_execution_policy" {
  statement {
    actions = [
      "s3:*",
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_role_policy" "ecs_execution" {
  name   = "ecs_task_execution_policy"
  policy = data.aws_iam_policy_document.ecs_task_execution_policy.json
  role   = aws_iam_role.ecs_role.id
}

resource "aws_iam_role_policy_attachment" "ecs_execution" {
  role       = aws_iam_role.ecs_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

## ECS task execution role


resource "aws_iam_role" "ecs_task" {
  name               = "${var.name}-ecs-task"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assumption.json
}

data "aws_iam_policy_document" "ecs_task_assumption" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com", "ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ecs_task_permissions" {
  statement {
    effect = "Allow"
    actions = [
    "s3:*"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ecs_task" {
  name   = "${var.name}-ecs-task-policy"
  policy = data.aws_iam_policy_document.ecs_task_permissions.json
}


resource "aws_iam_role_policy_attachment" "ecs_task" {
  role       = aws_iam_role.ecs_task.name
  policy_arn = aws_iam_policy.ecs_task.arn
}

# Configure security group for task
resource "aws_security_group" "ecs_tasks" {
  name   = "${var.name}-sg-task-${var.environment}"
  vpc_id = var.vpc_id

  ingress {
    protocol         = "tcp"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
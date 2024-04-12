resource "aws_ecs_task_definition" "app" {
  family = "app"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu = "256"  // Define 'cpu' at the task level
  memory = "512"  // Define 'memory' at the task level
  execution_role_arn = data.aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn = data.aws_iam_role.ecsTaskExecutionRole.arn
  container_definitions = jsonencode([
    {
      name = "app"
      image = "${aws_ecr_repository.my_first_ecr_repo.repository_url}:latest"
      essential = true
      portMappings = [
        {
          containerPort = 5000
          hostPort = 5000
          protocol = "tcp"
        }
      ]
    }
  ])
  volume {
    name = "app-volume"
  }
}
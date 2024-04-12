resource "aws_ecs_service" "my_service" {
  name              = "my-service"
  cluster           = aws_ecs_cluster.my_cluster.id
  task_definition   = aws_ecs_task_definition.app.arn
  launch_type       = "FARGATE"
  scheduling_strategy = "REPLICA"
  desired_count     = 1

  network_configuration {
    subnets          = [aws_subnet.private_az1.id, aws_subnet.private_az2.id]
    
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.example.arn
    container_name   = "app"
    container_port   = 5000
  }
}
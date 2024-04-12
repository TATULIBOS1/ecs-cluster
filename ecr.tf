resource "aws_ecr_repository" "my_first_ecr_repo" {
  name = "my-first-ecr-repo"
  tags = {
    Name="latest_ecr"
  }
}

data "aws_caller_identity" "current" {}

resource "null_resource" "push_image" {
  depends_on = [ aws_ecr_repository.my_first_ecr_repo ]

  provisioner "local-exec" {
  interpreter = ["C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe", "-Command"]
  command = <<EOF
  cd C:\\Users\\user\\Desktop\\backend
  echo "Logging into AWS ECR..."
  $LOGIN_COMMAND = aws ecr get-login-password --region us-east-1
  echo $LOGIN_COMMAND
  docker login -u AWS -p $LOGIN_COMMAND ${aws_ecr_repository.my_first_ecr_repo.repository_url}
  echo "Building Docker image..."
  docker build -t ${aws_ecr_repository.my_first_ecr_repo.repository_url} .
  echo "Pushing Docker image..."
  docker push ${aws_ecr_repository.my_first_ecr_repo.repository_url}
  EOF
}
}
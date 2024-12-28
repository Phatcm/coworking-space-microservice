#Create role that allow code bui;
resource "aws_iam_role" "codebuild" {
  name = "codebuild-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
      }
    ]
  })
}

#Add EKS cluster policy to the iam role
resource "aws_iam_role_policy_attachment" "codebuild-AmazonEC2ContainerRegistryFullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
  role = aws_iam_role.codebuild.name
}

resource "aws_iam_role_policy_attachment" "codebuild-AWSCodeBuildDeveloperAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
  role = aws_iam_role.codebuild.name
}

resource "aws_iam_role_policy_attachment" "codebuild-AmazonS3FullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role = aws_iam_role.codebuild.name
}

resource "aws_iam_role_policy_attachment" "codebuild-CloudWatchLogsFullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  role       = aws_iam_role.codebuild.name
}

#Codebuild
resource "aws_codebuild_project" "codebuild" {
  name           = "${var.repository_name}-build"
  service_role   = aws_iam_role.codebuild.arn
  source {
    type            = "GITHUB"
    location        = var.github_repo_url
    buildspec       = var.buildspec_path
    git_clone_depth = 1
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:6.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
    environment_variable {
      name  = "AWS_REGION"
      value = var.aws_region
    }
    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = var.account_id
    }
    environment_variable {
      name  = "ECR_REPO_NAME"
      value = var.repository_name
    }
  }

  tags = {
    Terraform = "true"
    Project = "${var.project}"
    Name = "${var.project}-vpc"
    Environment = "${var.env}"
  }
}


resource "aws_codebuild_webhook" "codebuild" {
  project_name = aws_codebuild_project.codebuild.name
  build_type   = "BUILD"
  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PUSH"
    }

    filter {
      type    = "HEAD_REF"
      pattern = "refs/heads/master"
    }
  }
}
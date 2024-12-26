variable "project" {
  description = "Project name"
  type = string
}

variable "env" {
  description = "Environment name"
  type = string
}

variable "account_id" {
  type = string
}

variable "repository_name" {
  description = "Codebuild repo name"
  type = string
}

variable "github_repo_url" {
  description = "Endpoint to the github project"
  type = string
}

variable "buildspec_path" {
  description = "Buildspec path"
  type = string
}

variable "aws_region" {
  type = string
}
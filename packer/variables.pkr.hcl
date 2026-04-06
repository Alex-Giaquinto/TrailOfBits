variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "t3.medium"
}

variable "ecr_registry" {
  type        = string
  description = "ECR registry URL (e.g. 123456789012.dkr.ecr.us-east-1.amazonaws.com)"
}

variable "ecr_repository" {
  type    = string
  default = "alex/app"
}

variable "image_tag" {
  type    = string
  default = "latest"
}

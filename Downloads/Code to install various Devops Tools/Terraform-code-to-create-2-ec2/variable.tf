variable "aws_region" {
  type    = string
  default = "eu-north-1"
}

variable "instance_type" {
  type    = string
  default = "t3.medium"
}

variable "windows_user" {
  description = "Windows profile folder name under C:/Users (Terraform runs in WSL)"
  type        = string
  default     = "USER"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

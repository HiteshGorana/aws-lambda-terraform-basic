# -*- coding: utf-8 -*-
# @Date    : 06-10-2021
# @Author  : Hitesh Gorana
# @Link    : None
# @Version : 0.0
terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source="hashicorp/aws"
      version = ">= 3.26"
    }
  }
}
variable "aws_region" {
  type = string
  default = "us-east-1"
}

provider "aws" {
  region = var.aws_region
}

data "archive_file" "main_zip" {
  type        = "zip"
  source_file = "main.py"
  output_path = "main.zip"
}

resource "aws_lambda_function" "lambda_v" {
  filename = "main.zip"
  function_name = "lambda_v_test"
  role          = aws_iam_role.lambda_v_role
  handler = "main.lambda_handler"
  runtime = "python3.8"
  source_code_hash = "data.archive.main_zip.output_base64sha256"
}

resource "aws_iam_role" "lambda_v_role" {
  name = "lambda_v_role"

  assume_role_policy = <<EOF
{
  "Version" : "2012-10-17",
  "Statement":[
    {
      "Actions" : "sts.AssumeRole",
      "Principal":{
        "Service":"lambda.amazonaws.com"
      },
      "Effect":"Allow",
      "Sid":""
    }
  ]
}
EOF
}
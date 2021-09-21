variable "path_source_code" {
  default = "lambda_function"
}

variable "function_name" {
  default = "aws_lambda_touchbistro"
}

variable "runtime" {
  default = "python3.8"
}

variable "output_path" {
  default = "lambda_function.zip"
}

variable "distribution_pkg_folder" {
  default = "lambda_pkg_tb"
}

variable "s3bucket" {
  default = "aws-lambda-touchbistro-challenge2021"
}
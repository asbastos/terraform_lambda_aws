resource "null_resource" "install_python_dependencies" {
  provisioner "local-exec" {
    command = "bash ${path.module}/scripts/create_pkg_tb.sh"

    environment = {
      source_code_path = var.path_source_code
      function_name = var.function_name
      path_module = path.module
      runtime = var.runtime
      path_cwd = path.cwd
    }
  }
}

data "archive_file" "create_pkg_tb" {
  depends_on = [null_resource.install_python_dependencies]
  source_dir = "${path.cwd}/lambda_pkg_tb/"
  output_path = var.output_path
  type = "zip"
}

resource "aws_lambda_function" "aws_lambda_touchbistro" {
  function_name = var.function_name
  handler = "lambda_function.lambda.lambda_handler"
  runtime = var.runtime

  role = aws_iam_role.lambda_role.arn
  memory_size = 128
  timeout = 300

  depends_on = [null_resource.install_python_dependencies]
  source_code_hash = data.archive_file.create_pkg_tb.output_base64sha256
  filename = data.archive_file.create_pkg_tb.output_path
}

resource "aws_lambda_permission" "allow_bucket" {
  function_name = aws_lambda_function.aws_lambda_touchbistro.arn
  source_arn = aws_s3_bucket.bucket_touchbistro.arn
  statement_id = "AllowExecutionFromS3Bucket"
  action = "lambda:InvokeFunction"
  principal = "s3.amazonaws.com"
}
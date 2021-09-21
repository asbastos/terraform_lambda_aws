resource "aws_s3_bucket" "bucket_touchbistro" {
  bucket = var.s3bucket
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.bucket_touchbistro.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.aws_lambda_touchbistro.arn
    events = ["s3:ObjectCreated:*"]
  }
}
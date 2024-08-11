resource "aws_lambda_layer_version" "object_migration_layer" {
  s3_bucket = "testasdawf4115154"
  s3_key    = "my_lambda_function.zip"

  layer_name          = "objectMigrationLayer"
  compatible_runtimes = ["python3.12"]
}

resource "aws_lambda_function" "lambda_to_invoke_SSM" {
  function_name    = "invoke_SSM"
  s3_bucket        = "testasdawf4115154"
  s3_key           = "my_lambda_function.zip"
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.12"
  role             = aws_iam_role.iam_role_ssm_full_access.arn
  layers           = [aws_lambda_layer_version.object_migration_layer.arn]

  environment {
    variables = {
      SSM_DOCUMENT_NAME = aws_ssm_document.ssm_document.name
      EC2_INSTANCE_ID   = aws_instance.ec2_SSM.id
    }
  }
  tags = {
    Environment = "${var.environment}"
  }
}



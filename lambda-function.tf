

data "archive_file" "lambda-greet" {
  type        = "zip"
  source_file = "greet_lambda.py"
  output_path = "${local.lambda_zip_location}"
}


resource "aws_lambda_function" "test_lambda" {
  filename      = "${local.lambda_zip_location}"
  function_name = "lambda-greet"
  role          = aws_iam_role.lambda_role.arn
  handler       = "greet_lambda.lambda_handler"


  source_code_hash = "${filebase64sha256(local.lambda_zip_location)}"

  runtime = "python3.6"

  environment {
    variables = {
      greeting = "UDACITY ROCKS"
    }
  }
}
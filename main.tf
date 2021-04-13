data "archive_file" "ebs_volumes_zip" {
  type        = "zip"
  source_file = "${path.module}/source/ebs_volumes.py"
  output_path = "${path.module}/source/ebs_volumes.zip"
}

resource "aws_lambda_function" "ebs_volumes_cleanup" {
  filename         = "${path.module}/source/ebs_volumes.zip"
  function_name    = "${var.function_prefix}ebs_volumes_cleanup"
  role             = aws_iam_role.iam_role_for_ebs_cleanup.arn
  handler          = "ebs_volumes.lambda_handler"
  source_code_hash = data.archive_file.ebs_volumes_zip.output_base64sha256
  runtime          = "python3.6"
  memory_size      = "512"
  timeout          = "150"

  environment {
    variables = {
      DAYS = var.days
      DRYRUN = var.dryrun
    }
  }
}

resource "aws_lambda_permission" "allow_cloudwatch_ebs_volumes_cleanup" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ebs_volumes_cleanup.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.ebs_volumes_cleanup_cloudwatch_rule.arn
}

resource "aws_cloudwatch_event_rule" "ebs_volumes_cleanup_cloudwatch_rule" {
  name                = "ebs_volumes_cleanup_lambda_trigger"
  schedule_expression = var.ebs_volumes_cleanup_cron
}

resource "aws_cloudwatch_event_target" "ebs_volumes_cleanup_lambda" {
  rule      = aws_cloudwatch_event_rule.ebs_volumes_cleanup_cloudwatch_rule.name
  target_id = "ebs_volumes_cleanup_lambda_target"
  arn       = aws_lambda_function.ebs_volumes_cleanup.arn
}


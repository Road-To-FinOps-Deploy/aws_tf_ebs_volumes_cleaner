resource "aws_iam_role" "iam_role_for_ebs_cleanup" {
  name               = "${var.function_prefix}role_for_ebs_cleanup"
  assume_role_policy = file("${path.module}/policies/LambdaAssume.pol")
}

resource "aws_iam_role_policy" "iam_role_policy_for_ebs_cleanup" {
  name   = "${var.function_prefix}policy_for_ebs_cleanup"
  role   = aws_iam_role.iam_role_for_ebs_cleanup.id
  policy = file("${path.module}/policies/LambdaExecution.pol")
}

resource "aws_iam_policy" "owner_tag_policy" {
  name        = "${var.function_prefix}owner_tag_policy_ebs"
  path        = "/"
  description = "Policy to force owner to add tag to EC2"

  policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
{
"Sid": "VisualEditor0",
"Effect": "Deny",
"Action": [
"ec2:RunInstances",
"ec2:CreateVolume"
],
"Resource": "arn:aws:ec2:::instance/*",
"Condition": {
"ForAllValues:StringNotEquals":

{ "aws:TagKeys": "Owner" }
}
}
]
}
EOF

}


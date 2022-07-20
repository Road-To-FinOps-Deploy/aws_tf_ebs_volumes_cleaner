resource "aws_iam_role" "iam_role_for_ebs_cleanup" {
  name               = "role_for_ebs_cleanup_${var.function_prefix}"
  assume_role_policy = "${file("${path.module}/policies/LambdaAssume.pol")}"
}

resource "aws_iam_role_policy" "iam_role_policy_for_ebs_cleanup" {
  name   = "policy_for_ebs_cleanup_${var.function_prefix}"
  role   = "${aws_iam_role.iam_role_for_ebs_cleanup.id}"
  policy = "${file("${path.module}/policies/LambdaExecution.pol")}"
}

resource "aws_iam_policy" "owner_tag_policy" {
  name        = "owner_tag_policy_ebs_${var.function_prefix}"
  path        = "/"
  description = "Policy to force owner to add tag to EC2"

  policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
      {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
        "Action": [
        "ec2:Describe*",
        "ec2:DeleteVolume",
        "ec2:CreateSnapshot",
        "ec2:CreateSnapshots",
        "ec2:CreateTags"
          ],
        "Resource": "arn:aws:ec2:::*"
      }
    ]
}
EOF
}

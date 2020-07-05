# EBS Cleanup of unattached volumes delete

## Summary


This module provides the following:
 - lambda
 - IAM

## Usage


module "aws_tf_ebs_volumes_cleaner" {
  source = "/aws_tf_ebs_volumes_cleaner"
  name               = "aws_tf_ebs_volumes_cleaner"
}
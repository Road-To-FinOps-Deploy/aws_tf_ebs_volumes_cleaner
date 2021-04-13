# Lambda Preventer
```
The script schedules the review of any ebs volumes that have been unattached for X days (deafult 7). 
This reviews all regions in your account
```



## Usage


module "aws_tf_ebs_volumes_cleaner" {
  source = "/aws_tf_ebs_volumes_cleaner"
}

## Optional Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| ebs\_volumes\_cleanup\_cron | Rate expression for when to run the review of volumes| string | `"cron(0 7 ? * MON-FRI *)"` | no 
| function\_prefix | Prefix for the name of the lambda created | string | `""` | no |
| dats| how many days a volumes needs to be unattached to delete| string | `"7"` | no |
| dryrun| If this is a dry run or a real test. By default it will not be a dry run so will action| string | `"False"` | no |


## Tags
If you do not want it to be deleted then Tag
Protection = True

It will run and tag volumes that need to be reviewed and will delete in a week
## Testing 

Configure your AWS credentials using one of the [supported methods for AWS CLI
   tools](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html), such as setting the
   `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables. If you're using the `~/.aws/config` file for profiles then export `AWS_SDK_LOAD_CONFIG` as "True".
1. Install [Terraform](https://www.terraform.io/) and make sure it's on your `PATH`.
1. Install [Golang](https://golang.org/) and make sure this code is checked out into your `GOPATH`.
cd test
go mod init github.com/sg/sch
go test -v -run TestTerraformAwsExample
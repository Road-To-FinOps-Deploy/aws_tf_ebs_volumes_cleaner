variable "ebs_volumes_cleanup_cron" {
  description = "interval of time to trigger lambda function"
  default     = "cron(0 6 ? * MON *)"
}

variable "function_prefix" {
  default = ""
}


variable "days" {
  default = "7"
}

variable "dryrun" {
  default = "False"
}
variable "ebs_volumes_cleanup_cron" {
  description = "interval of time to trigger lambda function"
  default     = "cron(0 6 ? * MON *)"
}

variable "name" {
}


variable "name" {
  type = string
}

variable "bucket_regional_domain_name" {
  type        = string
  description = "Regional domain name of the S3 bucket origin"
}

variable "domain" {
  type    = string
  default = ""
}

variable "acm_certificate_arn" {
  type    = string
  default = ""
}

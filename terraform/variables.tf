variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "name" {
  type        = string
  description = "Base name used to prefix all resources"
  default     = "alex-homelab"
}

# --- VPC ---

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "az" {
  type    = string
  default = "us-east-1a"
}

# --- Nextcloud EC2 ---

variable "nextcloud_ami_id" {
  type        = string
  description = "AMI ID to use for the Nextcloud instance (use the output from Packer)"
}

variable "nextcloud_instance_type" {
  type    = string
  default = "t3.small"
}

variable "key_name" {
  type        = string
  description = "Name of the EC2 key pair for SSH access"
}

variable "nextcloud_data_volume_size" {
  type        = number
  description = "Size in GB of the Nextcloud data EBS volume"
  default     = 100
}

# --- HairByGabrielaC ---

variable "hairbygabrielac_bucket_name" {
  type    = string
  default = "hairbygabrielac"
}

variable "hairbygabrielac_domain" {
  type        = string
  description = "Custom domain for HairByGabrielaC (leave empty to use the CloudFront domain)"
  default     = ""
}

# --- Logan Kicking Academy ---

variable "logan_kicking_academy_bucket_name" {
  type    = string
  default = "logan-kicking-academy"
}

variable "logan_kicking_academy_domain" {
  type        = string
  description = "Custom domain for Logan Kicking Academy (leave empty to use the CloudFront domain)"
  default     = ""
}

aws_region = "us-east-1"
name       = "alex-homelab"

# VPC
vpc_cidr           = "10.0.0.0/16"
public_subnet_cidr = "10.0.1.0/24"
az                 = "us-east-1a"

# Nextcloud — swap in the AMI ID output from Packer
nextcloud_ami_id           = "ami-xxxxxxxxxxxxxxxxx"
nextcloud_instance_type    = "t3.small"
key_name                   = "alex-homelab"
nextcloud_data_volume_size = 100

# Static sites
hairbygabrielac_bucket_name       = "hairbygabrielac"
hairbygabrielac_domain            = ""

logan_kicking_academy_bucket_name = "logan-kicking-academy"
logan_kicking_academy_domain      = ""

terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"

  name               = var.name
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  az                 = var.az
}

module "nextcloud" {
  source = "./modules/ec2"

  name             = "${var.name}-nextcloud"
  ami_id           = var.nextcloud_ami_id
  instance_type    = var.nextcloud_instance_type
  subnet_id        = module.vpc.public_subnet_id
  vpc_id           = module.vpc.vpc_id
  key_name         = var.key_name
  data_volume_size = var.nextcloud_data_volume_size
}

# --- HairByGabrielaC ---

module "hairbygabrielac_bucket" {
  source      = "./modules/s3"
  bucket_name = var.hairbygabrielac_bucket_name
}

module "hairbygabrielac_cdn" {
  source                      = "./modules/cloudfront"
  name                        = var.hairbygabrielac_bucket_name
  bucket_regional_domain_name = module.hairbygabrielac_bucket.bucket_regional_domain_name
  domain                      = var.hairbygabrielac_domain
}

resource "aws_s3_bucket_policy" "hairbygabrielac" {
  bucket = module.hairbygabrielac_bucket.bucket_id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "AllowCloudFront"
      Effect    = "Allow"
      Principal = { Service = "cloudfront.amazonaws.com" }
      Action    = "s3:GetObject"
      Resource  = "${module.hairbygabrielac_bucket.bucket_arn}/*"
      Condition = {
        StringEquals = {
          "AWS:SourceArn" = module.hairbygabrielac_cdn.distribution_arn
        }
      }
    }]
  })
}

# --- Logan Kicking Academy ---

module "logan_kicking_academy_bucket" {
  source      = "./modules/s3"
  bucket_name = var.logan_kicking_academy_bucket_name
}

module "logan_kicking_academy_cdn" {
  source                      = "./modules/cloudfront"
  name                        = var.logan_kicking_academy_bucket_name
  bucket_regional_domain_name = module.logan_kicking_academy_bucket.bucket_regional_domain_name
  domain                      = var.logan_kicking_academy_domain
}

resource "aws_s3_bucket_policy" "logan_kicking_academy" {
  bucket = module.logan_kicking_academy_bucket.bucket_id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "AllowCloudFront"
      Effect    = "Allow"
      Principal = { Service = "cloudfront.amazonaws.com" }
      Action    = "s3:GetObject"
      Resource  = "${module.logan_kicking_academy_bucket.bucket_arn}/*"
      Condition = {
        StringEquals = {
          "AWS:SourceArn" = module.logan_kicking_academy_cdn.distribution_arn
        }
      }
    }]
  })
}

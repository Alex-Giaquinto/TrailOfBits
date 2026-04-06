output "vpc_id" {
  value = module.vpc.vpc_id
}

output "nextcloud_public_ip" {
  value = module.nextcloud.public_ip
}

output "hairbygabrielac_url" {
  value = module.hairbygabrielac_cdn.url
}

output "logan_kicking_academy_url" {
  value = module.logan_kicking_academy_cdn.url
}

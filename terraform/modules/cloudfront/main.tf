resource "aws_cloudfront_origin_access_control" "this" {
  name                              = var.name
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "this" {
  enabled             = true
  default_root_object = "index.html"
  aliases             = var.domain != "" ? [var.domain] : []

  origin {
    domain_name              = var.bucket_regional_domain_name
    origin_id                = var.name
    origin_access_control_id = aws_cloudfront_origin_access_control.this.id
  }

  default_cache_behavior {
    target_origin_id       = var.name
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies { forward = "none" }
    }
  }

  custom_error_response {
    error_code         = 404
    response_code      = 200
    response_page_path = "/index.html"
  }

  restrictions {
    geo_restriction { restriction_type = "none" }
  }

  viewer_certificate {
    cloudfront_default_certificate = var.domain == "" ? true : false
    acm_certificate_arn            = var.domain != "" ? var.acm_certificate_arn : null
    ssl_support_method             = var.domain != "" ? "sni-only" : null
    minimum_protocol_version       = var.domain != "" ? "TLSv1.2_2021" : null
  }
}

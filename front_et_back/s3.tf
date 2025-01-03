resource "aws_s3_bucket" "practice_bucket" {
  bucket = "s3-backend-${random_string.unique_suffix.result}"
}

resource "aws_s3_bucket_website_configuration" "endpoint" {
  bucket = aws_s3_bucket.practice_bucket.id
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.practice_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

}

resource "random_string" "unique_suffix" {
  length  = 7
  special = false
  upper   = false
}

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.practice_bucket.id
  key    = "index.html"
  source = "./index.html"
  content_type = "text/html"

  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_policy" "site_policy" {
  bucket = aws_s3_bucket.practice_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::s3-backend-y54euc9/*"
      }
    ]
  })
}




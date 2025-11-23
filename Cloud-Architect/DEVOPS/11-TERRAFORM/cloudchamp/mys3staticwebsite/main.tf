# create s3 bucket

resource "aws_s3_bucket" "mybucket" {
  bucket = var.bucketname
}


resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.mybucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.mybucket.id
  acl    = "public-read"
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.mybucket.id
  key = "index.html"
  source = "index.html"
  acl = "public-read"
  content_type = "text/html"
}


resource "aws_s3_bucket_object" "images" {
  for_each = fileset("C:\\Users\\Narendra\\OneDrive\\Desktop\\mys3staticwebsite\\assets", "*")  # Upload all files from the assets_folder
  bucket   = aws_s3_bucket.mybucket.id
  key      = "images/${each.value}"  # Upload assets to the "assets" folder in S3
  source   = "C:\\Users\\Narendra\\OneDrive\\Desktop\\mys3staticwebsite\\assets\\${each.value}"
  acl      = "public-read"  # Adjust permissions as needed
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.mybucket.id
  key = "error.html"
  source = "error.html"
  acl = "public-read"
  content_type = "text/html"
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.mybucket.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
  depends_on = [ aws_s3_bucket_acl.example ]
}

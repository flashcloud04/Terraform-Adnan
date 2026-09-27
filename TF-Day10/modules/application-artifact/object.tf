data "archive_file" "application" {
  type        = "zip"
  source_dir  = "${path.root}/../../../application"
  output_path = "${path.root}/../../../application.zip"
}

resource "aws_s3_object" "application" {
  bucket = aws_s3_bucket.application.id
  key    = "releases/application.zip"

  source = data.archive_file.application.output_path
  etag   = data.archive_file.application.output_md5

  server_side_encryption = "AES256"
}
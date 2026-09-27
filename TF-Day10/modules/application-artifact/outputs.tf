output "bucket_name" {
  value = aws_s3_bucket.application.id
}

output "bucket_arn" {
  value = aws_s3_bucket.application.arn
}

output "object_key" {
  value = aws_s3_object.application.key
}
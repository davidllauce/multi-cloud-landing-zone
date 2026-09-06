output "gcs_bucket_name" {
  value = google_storage_bucket.state.name
}

output "s3_bucket_name" {
  value = aws_s3_bucket.state.id
}

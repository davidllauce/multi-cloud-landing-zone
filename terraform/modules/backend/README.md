# backend

Remote state buckets for both clouds, provisioned once (bootstrap) and then
referenced by the `terraform { backend }` block of each environment.

- **GCS**: versioning, lifecycle (delete old versions), uniform bucket-level
  access, public access prevention.
- **S3**: versioning, server-side encryption (AES256), block all public access,
  noncurrent version expiration.

State is never stored locally in production.

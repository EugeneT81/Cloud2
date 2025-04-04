

resource "yandex_storage_bucket" "s3" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "teugene-23-03-2025"
  anonymous_access_flags {
    read        = true
    list        = true
    config_read = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.bucket.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "yandex_storage_object" "picture" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = yandex_storage_bucket.s3.bucket
  key    = "picture.png"
  source = "./images/picture.png"
  acl = "public-read"
  depends_on = [yandex_storage_bucket.s3]
}

resource "yandex_kms_symmetric_key" "bucket" {
  name              = "bucket-symetric-key"
  description       = "key for bucket"
}


1. Конфигурационные файлы Terraform:


[Object Storage](object-storage.tf)

[Service Account](sa.tf)

[Compute instance](compute-instance-group.tf)


2. resource "yandex_kms_symmetric_key":

![kms_symmetric_key](54.png)

![KMS](50.png)



3. resource "yandex_storage_bucket" с блоком server_side_encryption_configuration:

![server_side_encryption_configuration](53.png)

4. Object Storage Bucket:

![bucket](51.png)

![alt text](52.png)

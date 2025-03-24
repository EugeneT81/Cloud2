1. Конфигурационные файлы Terraform:

[text](private-vm.tf)

[text](public-vm.tf)

[text](network_loadbalancer.tf)

[text](object-storage.tf)

[text](sa.tf)

[text](compute-instance-group.tf)

[text](sa.tf)

2. Результат выполнения terraform apply:

![alt text](40.png)

![alt text](44.png)

3. Группа виртуальных машин:

![alt text](41.png)

![alt text](43.png)

4. Object Storage Bucket:

![alt text](45.png)

5. Фото из object storage отображается на публичном ip адресе одной из ВМ:

![alt text](42.png)

6. Network Load Balancer:

![alt text](46.png)

7. Фото из object storage отображается на публичном ip адресе Network Load Balancer:

![alt text](47.png)

8. Одна из ВМ выключена. Фото по прежнему доступно по ip адресу Network Load Balancer:

![alt text](48.png)

![alt text](49.png)
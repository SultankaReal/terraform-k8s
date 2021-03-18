****Практикум 11.4****

**Установка Terraform**:
https://learn.hashicorp.com/tutorials/terraform/install-cli

**Установка kubectl**:
https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/

Файл **yandex.tf** описывает создание двух виртуальных машин:

- Master


  Имя машины: terraform1
  Количество CPU: 4
  RAM: 4

- Slave (Worker)


  Имя машины: terraform2
  Количество CPU: 4
  RAM: 4
  
  
**IP-адреса ВМ**:


external_ip_address_vm_1 = "178.154.213.25"


external_ip_address_vm_2 = "178.154.208.169"


internal_ip_address_vm_1 = "192.168.10.11"


internal_ip_address_vm_2 = "192.168.10.12"


**Отключение swap**:


sudo swapoff -a![image](https://user-images.githubusercontent.com/77805226/111617144-d24d0e00-87f3-11eb-84fe-f2ad67f611f5.png)



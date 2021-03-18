# Практикум 11.4

## Установка Terraform
[link](https://learn.hashicorp.com/tutorials/terraform/install-cli)

## Установка kubectl
[link](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/)

## Файл **yandex.tf** описывает создание двух виртуальных машин:

- Master


  Имя машины: terraform1
  
  
  Количество CPU: 4
  
  
  RAM: 4
  

- Slave (Worker)


  Имя машины: terraform2
  
  
  Количество CPU: 4
  
  
  RAM: 4
  
  
## IP-адреса ВМ


external_ip_address_vm_1 = "178.154.213.25"


external_ip_address_vm_2 = "178.154.208.169"


internal_ip_address_vm_1 = "192.168.10.11"


internal_ip_address_vm_2 = "192.168.10.12"


![image](https://user-images.githubusercontent.com/77805226/111641288-0f25fe80-880e-11eb-8e7d-0038e7b1a319.png)


##  Master Node

### Отключение swap

sudo swapoff -a

### Установка Docker на Master-а

sudo apt update


sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    
    
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -


sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
   
   
sudo apt update


sudo apt install docker-ce docker-ce-cli containerd.io


sudo systemctl enable docker


sudo systemctl start docker

### Установка kubelet, kubadm, kubectl


sudo modprobe br_netfilter


cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf br_netfilter EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF


sudo sysctl --system

sudo apt update && sudo apt install -y apt-transport-https curl


curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -


cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list deb https://apt.kubernetes.io/ kubernetes-xenial main EOF


sudo apt update


sudo apt install -y kubelet kubeadm kubectl


sudo apt-mark hold kubelet kubeadm kubectl


sudo systemctl enable kubelet


sudo systemctl start kubelet


###  Инициализация кластера 


sudo kubeadm init –-apiserver-advertise-address=192.168.10.11 --pod-network-cidr 10.244.0.0/16


mkdir -p $HOME/.kube


sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config


sudo chown $(id -u):$(id -g) $HOME/.kube/config


### Установка сети для pods


sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml


## Worker Node


### Отключение swap

sudo swapoff -a


### Установка Docker на Worker-e

sudo apt update


sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    
    
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -


sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
   
   
sudo apt update


sudo apt install docker-ce docker-ce-cli containerd.io


sudo systemctl enable docker


sudo systemctl start docker


### Установка kubelet, kubadm, kubectl


sudo modprobe br_netfilter


cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf br_netfilter EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF


sudo sysctl --system

sudo apt update && sudo apt install -y apt-transport-https curl


curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -


cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list deb https://apt.kubernetes.io/ kubernetes-xenial main EOF


sudo apt update


sudo apt install -y kubelet kubeadm kubectl


sudo apt-mark hold kubelet kubeadm kubectl


sudo systemctl enable kubelet


sudo systemctl start kubelet


### Подключение Worker Node к Master Node


kubeadm join 192.168.10.11:6443 --token [TOKEN] --discovery-token-ca-cert-hash sha256:[SHA256]



![image](https://user-images.githubusercontent.com/77805226/111620313-99af3380-87f7-11eb-94b0-7ea6df2540d8.png)



##  Просмотр Nodes


kubectl get nodes


![image](https://user-images.githubusercontent.com/77805226/111620393-b51a3e80-87f7-11eb-8e9f-b9c3ffbd81ed.png)



##  Установка Kubernetes Dashboard


kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml


##  Включение Kubernetes Proxy


sudo kubectl proxy


![image](https://user-images.githubusercontent.com/77805226/111620419-bcd9e300-87f7-11eb-8608-61343729684b.png)



## Аутентификация по токену в Kubernetes Dashboard


[link](https://www.replex.io/blog/how-to-install-access-and-add-heapster-metrics-to-the-kubernetes-dashboard)



![image](https://user-images.githubusercontent.com/77805226/111620434-c4998780-87f7-11eb-81c9-826c5b2b65e0.png)



![image](https://user-images.githubusercontent.com/77805226/111620659-117d5e00-87f8-11eb-84ef-8099d43af59b.png)




















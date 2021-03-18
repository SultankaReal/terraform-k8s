# Практикум 11.4

## Установка Terraform
https://learn.hashicorp.com/tutorials/terraform/install-cli

## Установка kubectl
https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/

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


## Отключение swap

sudo swapoff -a

## Установка Docker на Master-а

sudo apt update


sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    
    
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -


sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
   
   
sudo apt update


sudo apt install docker-ce docker-ce-cli containerd.io


sudo systemctl enable docker


sudo systemctl start docker

## Установка kubelet, kubadm, kubectl



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


##  Инициализация кластера 


sudo kubeadm init –-apiserver-advertise-address=192.168.10.11 --pod-network-cidr 10.244.0.0/16


mkdir -p $HOME/.kube


sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config


sudo chown $(id -u):$(id -g) $HOME/.kube/config


## Установка Kubernetes Dashboard



sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml




1. sudo kubeadm init --apiserver-advertise-address=192.168.0.20  --ignore-preflight-errors=NumCPU

# fails so just did this without knowing the issues
[vagrant@kube-master ~]$ sudo rm /etc/containerd/config.toml
[vagrant@kube-master ~]$ systemctl restart containerd

> sudo kubeadm init

## copy the token etc 
kubeadm join 192.168.0.20:6443 --token 4qn55u.z6wov76zejew1oi1 \
        --discovery-token-ca-cert-hash sha256:96edd8bc8fba619a728136d0275aff5730bb46f2369da58060154c743662f98a

mkdir -p ~/.kube

sudo cp -i /etc/kubernetes/admin.conf ~/.kube/config

sudo chown $(id -u):$(id -g) ~/.kube/config


kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml


scp -r ~/.kube  vagrant@192.168.0.21:/home/vagrant

1. above wont work , 
   ssh-keygen   and copy the public key 
   cat id_rsa.pub
   then go to the other node and copy this in  vim ~/.ssh/authorized_keys



ssh vagrant@192.168.0.21

add node now 
# fails so just did this without knowing the issues
[vagrant@kube-master ~]$ sudo rm /etc/containerd/config.toml
[vagrant@kube-master ~]$ systemctl restart containerdexit

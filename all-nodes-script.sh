1. vagrant ssh kube-master

2. sudo -i

#for the api  - used by all
firewall-cmd --permanent --add-port=6443/tcp

# used bt etcd  - used by api/etcd
firewall-cmd --permanent --add-port=2379-2380/tcp

#scheduler - used by self
firewall-cmd --permanent --add-port=10251/tcp

#used by controller manager 
firewall-cmd --permanent --add-port=10252/tcp

#used by kubelet  this is secure port
firewall-cmd --permanent --add-port=10250/tcp

#used by kubelet  this is unsecure  port
firewall-cmd --permanent --add-port=10255/tcp


#### open dynamic ports 30000 to 32767 for Nodeport Access
firewall-cmd --permanent --add-port=30000-32767/tcp


## add the source ips from which access is allowed , use a subnet cos we know
firewall-cmd --zone=trusted  --permanent --add-source=192.168.0.0/24

# this acts as a nat
firewall-cmd --add-masquerade --permanent

# modprobe - program to add modules
# netfilter is a module that offers various functions for packetfiltering , nat , port transalation
modprobe br_netfilter

# after making all the above changes 
systemctl restart firewalld

#check 
firewall-cmd --list-all


# since we do not have dns , we add entires to the host file for lookups

vim /etc/hosts

192.168.0.20    kube-master
192.168.0.21    kube-node1
192.168.0.22    kube-node2


# add docker repos on centos
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo

# install docker
sudo dnf install docker-ce --nobest -y --allowerasing

# start docker
sudo systemctl enable --now docker

# add the current user to docker group 

sudo usermod -aG docker $USER

#### exit and relogin to test the following commands 

docker --version
docker run hello-world


# now add kubernetes repo to yum

vim /etc/yum.repos.d/kubernetes.repo

[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg



# install kubernetes
sudo dnf install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

# modify the kubelet file
sudo vim /etc/sysconfig/kubelet

KUBELET_EXTRA_ARGS= --runtime-cgroups=/systemd/system.slice --kubelet-cgroups=/systemd/system.slice


# start the kubernetes service 
sudo systemctl enable --now kubelet

# now we are going to configure ip tables
sudo -i

vim /etc/sysctl.d/k8s.config

net.bridge.bridge-nf-call-ip6tables=1
net.bridge.bridge-nf-call-iptables=1

# reload the above configuration
sysctl --system

# disable swap
sudo swapoff -a

# add permanently 
vim /etc/fstab
 comment out /dev/mapper line

 # create a docker daemon file for systemd

 vim /etc/docker/daemon.json

 {
   "exec-opts" :["native.cgroupdriver=systemd"],
   "log-driver":["json-file"],
   "log-opts": { "max-size" : "100m" },
   "storage-driver" : "overlay2",
   "storage-opts" : [
     "overlay2.override_kernel_check=true"
   ]
 }

mkdir -p /etc/systemd/system/docker.service.d

systemctl daemon-reload




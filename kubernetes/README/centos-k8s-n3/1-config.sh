for node_ip in ${NODE_IPS[@]}
  do
    echo ">>> ${node_ip}"
    ssh root@${node_ip} "systemctl stop firewalld"
	ssh root@${node_ip} "systemctl disable firewalld"
	ssh root@${node_ip} "iptables -F && iptables -X && iptables -F -t nat && iptables -X -t nat"
	ssh root@${node_ip} "iptables -P FORWARD ACCEPT"
	ssh root@${node_ip} "swapoff -a"
	ssh root@${node_ip} "sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab"
	ssh root@${node_ip} "setenforce 0"
	ssh root@${node_ip} "sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config"
	ssh root@${node_ip} "timedatectl set-timezone Asia/Shanghai"
	ssh root@${node_ip} "systemctl enable chronyd"
	ssh root@${node_ip} "systemctl start chronyd"
	ssh root@${node_ip} "systemctl stop postfix && systemctl disable postfix"
	ssh root@${node_ip} "mkdir -p /opt/k8s/{bin,work} /etc/{kubernetes,etcd}/cert"
done

for node_ip in ${NODE_IPS[@]}
  do
    echo ">>> ${node_ip}"
    ssh root@${node_ip} "cp /home/shares/share/k8s-vmware-3/kubernetes.conf  /etc/sysctl.d/kubernetes.conf"
	ssh root@${node_ip} "sysctl -p /etc/sysctl.d/kubernetes.conf"
done
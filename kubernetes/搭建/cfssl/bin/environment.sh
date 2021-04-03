#!/usr/bin/bash

# 集群各机器 IP 数组
export NODE_IPS=(192.168.41.31 192.168.41.32 192.168.41.33 192.168.41.34 192.168.41.35)

# cfssl
# cfssl >> 执行权限
chmod +x /opt/n5/cfssl/bin/*
# cfssl >> PATH
export PATH=/opt/n5/cfssl/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

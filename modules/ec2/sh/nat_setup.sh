#!/bin/bash

# refs: https://docs.aws.amazon.com/ja_jp/vpc/latest/userguide/VPC_NAT_Instance.html

yum install -y iptables-services
iptables -F
echo 1 > /proc/sys/net/ipv4/ip_forward
echo net.ipv4.ip_forward=1 >> /etc/sysctl.d/custom-ip-forwarding.conf
iptables -t nat -A POSTROUTING -o enX0 -j MASQUERADE
service iptables save
systemctl start iptables
systemctl enable iptables

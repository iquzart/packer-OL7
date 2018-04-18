#!/bin/bash

# Install Yum Utils 
yum -y install yum-utils
#yum -y update

# Install Cloud-Init
#yum-config-manager --enable ol7_optional_latest
yum install -y cloud-init

echo "==> Deleting cloud-user"
userdel cloud-user

echo "==> Updating OL7"
yum update -y

echo "==> Remove the traces of the template MAC address and UUIDs"
sed -i '/^\(HWADDR\|UUID\)=/d' /etc/sysconfig/network-scripts/ifcfg-e*
cat /etc/sysconfig/network-scripts/ifcfg-eth0

echo "==> list devices"
ls -l /etc/sysconfig/network-scripts/

# rm -rf /etc/sysconfig/network-scripts/ifcfg-e*

# cat >/etc/sysconfig/network-scripts/ifcfg-eth0 <<-EOF
# NAME="eth0"
# DEVICE="eth0"
# BOOTPROTO=dhcp
# ONBOOT=yes
# NETBOOT=yes
# TYPE=Ethernet
# NM_CONTROLLED="no"
# EOF

echo "==> Cleaning up udev rules"
rm -f /etc/udev/rules.d/70*

echo "==> Disabling kdump and NetworkManager service"
systemctl disable kdump.service
systemctl disable NetworkManager.service

#cat /etc/oracle-release



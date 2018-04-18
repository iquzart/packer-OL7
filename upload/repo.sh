#!/bin/bash

cat > /etc/yum.repos.d/epel.repo <<-EOF
[ol7_developer_EPEL]
name=Oracle Linux x86_64 Devlopement Packages (x86_64)
baseurl=http://yum.oracle.com/repo/OracleLinux/OL7/developer_EPEL/x86_64/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
gpgcheck=1
enabled=1
EOF


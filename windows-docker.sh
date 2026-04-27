#!/bin/bash
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update -y
sudo apt install docker-ce -y
sudo systemctl start docker
sudo systemctl enable docker
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker -v
docker-compose -v
sudo chmod +x cai-dat-docker-tu-dong.sh
sudo bash cai-dat-docker-tu-dong.sh

# kiểm tra guest đã thấy VT-x chưa
grep -m1 -o 'vmx' /proc/cpuinfo || echo "NO_VMX"

# Cài gói và bật module KVM/TUN
sudo apt update

sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils linux-modules-extra-$(uname -r)

sudo modprobe kvm
sudo modprobe tun

lsmod | grep -E 'kvm|kvm_intel|tun'
ls -l /dev/kvm /dev/net/tun

# Cấp quyền cho người dùng hiện tại để sử dụng KVM
sudo chgrp kvm /dev/kvm
sudo chmod 660 /dev/kvm

# Tải windows.iso về thư mục hiện tại
curl -L -o windows11.iso https://download1589.mediafire.com/cl0vojyjdm7gZUHrhJBIJs-fYimKbqviKW0t4q76nsmQHE-AKfsLUpcKRInZ6BhbxT73QBPExtwTZSjTIkhOMJkmDd5pN-itszJAQ8IiZSuVYj75XGI3ZhdRoilRkxVJpLteQKrnE_tpzjFSGfl_NFDXMpuCaAL3FgfzqRFKD6g/qzs3a9gp05bxkv4/Win11_Pro_25H2.iso
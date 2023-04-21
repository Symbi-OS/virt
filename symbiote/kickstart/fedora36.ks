#version=DEVEL
# System authorization information
# auth --enableshadow --passalgo=sha512

# Use the Fedora 36 installation media
url --url="https://download.fedoraproject.org/pub/fedora/linux/releases/36/Everything/x86_64/os/"

# Run the setup agent on first boot
firstboot --enable

# Use network installation
network --bootproto=dhcp --device=link --onboot=on --activate

# Set the hostname
# hostname --static=myfedora36.localdomain

# Set the timezone
timezone --utc America/New_York

# Set the bootloader options
bootloader --append="crashkernel=auto" --location=mbr

# Clear the Master Boot Record
zerombr

# Partition layout
clearpart --all --initlabel
autopart --type=lvm

# Set the root password
rootpw --plaintext root

# Enable firewall
firewall --enabled --service=ssh

# Enable SELinux
selinux --enforcing

# Do not configure X Window System
skipx

# System services
services --enabled="chronyd"

# System language
lang en_US.UTF-8

# Keyboard layout
keyboard --vckeymap=us --xlayouts='us'

# System timezone
timezone America/New_York --utc

user --name=kele --password=kele --gecos="kele" --groups=wheel

# Reboot after installation
reboot

# Add your desired packages
%packages
git
make
%end

%post
# Add any post-installation scripts here
%end

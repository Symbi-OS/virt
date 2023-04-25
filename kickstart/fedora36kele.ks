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

# clearpart --all --initlabel
# autopart --type=lvm --fstype="ext4" --lvmpvopts="--metadatasize=128M" --lvmlvopts="--thinpool --metadatasize=128M" --grow

# clearpart --all --initlabel
# part /boot --fstype=xfs --size=1024
# part pv.01 --size=1 --grow
# volgroup myvg pv.01
# logvol / --fstype=ext4 --vgname=myvg --size=1 --grow --thin --name=lv_root
# logvol /home --fstype=ext4 --vgname=myvg --size=1 --grow --thin --name=lv_home


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

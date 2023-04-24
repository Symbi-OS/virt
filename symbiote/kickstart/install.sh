total_memory=$(free -m | awk '/^Mem:/{print $2}')
ram_allocation=$((total_memory * 3 / 4))
total_cores=$(nproc)

virt-install \
  --name fedora36kele \
  --ram $ram_allocation \
  --disk path="$(pwd)/disk/fedora36.qcow2,size=200,format=qcow2" \
  --check disk_size=off \
  --vcpus $total_cores \
  --network bridge=virbr0 \
  --graphics none \
  --console pty,target_type=serial \
  --location 'https://download.fedoraproject.org/pub/fedora/linux/releases/36/Everything/x86_64/os/' \
  --initrd-inject="$(pwd)/fedora36.ks" \
  --extra-args "inst.ks=file:/fedora36.ks console=ttyS0,115200n8" \
  --wait -1

#  --os-variant fedora36 \

#--cdrom path="$(pwd)/fedora36-ks.iso",device=cdrom \

# --initrd-inject /home/admin/middleware/stack/kickstartfiles/ks.cfg \
# --extra-args "inst.ks=file:/ks.cfg console=tty0 console=ttyS0,115200n8"
total_memory=$(free -m | awk '/^Mem:/{print $2}')
ram_allocation=$((total_memory * 3 / 4))
total_cores=$(nproc)
DOMAIN=fedora36kele
LOCATION='https://download.fedoraproject.org/pub/fedora/linux/releases/36/Everything/x86_64/os/' 

virt-install \
  --name $DOMAIN \
  --ram $ram_allocation \
  --disk path="$(pwd)/disk/$DOMAIN.qcow2,size=200,format=qcow2" \
  --check disk_size=off \
  --vcpus $total_cores \
  --network bridge=virbr0 \
  --graphics none \
  --console pty,target_type=serial \
  --location $LOCATION \
  --initrd-inject="$(pwd)/$DOMAIN.ks" \
  --extra-args "inst.ks=file:/$DOMAIN.ks console=ttyS0,115200n8" \
  --wait -1

set -x

total_memory=$(free -m | awk '/^Mem:/{print $2}')
ram_allocation=$((total_memory * 3 / 4))
total_cores=$(nproc)
DOMAIN=ubuntu_focal
LOCATION='http://us.archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/'
FILE_SUFFIX=preseed
START_FILE=$DOMAIN.$FILE_SUFFIX
ARGS='auto=true prioirty=critical '

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
  --initrd-inject="$(pwd)/$START_FILE" \
  --extra-args "$ARGS preseed/url=file:///$START_FILE console=ttyS0,115200n8" \
  --wait -1

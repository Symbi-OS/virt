virt-install \
  --name fedora36kele \
  --ram 200000 \
  --disk path="$(pwd)/disk/fedora36.qcow2,size=20,format=qcow2" \
  --vcpus 79 \
  --os-variant fedora36 \
  --network bridge=virbr0 \
  --graphics none \
  --console pty,target_type=serial \
  --location 'https://download.fedoraproject.org/pub/fedora/linux/releases/36/Everything/x86_64/os/' \
  --initrd-inject="$(pwd)/fedora36.ks" \
  --extra-args "inst.ks=file:/fedora36.ks console=ttyS0,115200n8" \
  --wait -1

#--cdrom path="$(pwd)/fedora36-ks.iso",device=cdrom \

# --initrd-inject /home/admin/middleware/stack/kickstartfiles/ks.cfg \
# --extra-args "inst.ks=file:/ks.cfg console=tty0 console=ttyS0,115200n8"
virt-install --name Fedora33 \
--description 'Fedora 33 Workstation' \
--ram 8192 \
--vcpus 8 \
--disk path=guest_disk.img \
--os-type linux \
--os-variant fedora33 \
--network bridge=virbr0 \
--graphics none \
--extra-args='console=ttyS0' \
--location ./Fedora-Server-dvd-x86_64-33-1.2.iso


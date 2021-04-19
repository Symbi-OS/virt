virt-install --name Fedora33Sym \
--description 'Fedora 33 Workstation' \
--ram 65536 \
--vcpus 46 \
--disk path=guest_disk.img \
--os-type linux \
--os-variant fedora33 \
--network bridge=virbr0 \
--graphics none \
--extra-args='console=ttyS0' \
--location ./Fedora-Server-dvd-x86_64-33-1.2.iso


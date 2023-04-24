help:

kelevate_vm: disk
	./install.sh

fedora_prereqs:
	sudo dnf install -y virt-manager libvirt libvirt-daemon libvirt-daemon-config-network qemu-kvm
	sudo dnf install -y @virtualization
	sudo systemctl start libvirtd
	sudo systemctl enable libvirtd

# TODO: Test on Ubuntu.
ubuntu_prereqs:
	echo THIS IS UNTESTED ON UBUNTU!
	sudo apt-get update
	sudo apt-get install -y virtinst qemu-kvm libvirt-daemon libvirt-daemon-system libvirt-clients bridge-utils
	sudo systemctl start libvirtd
	sudo systemctl enable libvirtd

disk:
	mkdir disk

destroy:
	virsh destroy fedora36kele

undefine:
	virsh undefine fedora36kele

disk_rm:
	rm disk/fedora36.qcow2

clean:
	$(MAKE) destroy
	$(MAKE) undefine
	$(MAKE) disk_rm
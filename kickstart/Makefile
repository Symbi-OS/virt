.PHONY: kelevate_vm fedora_prereqs ubuntu_prereqs disk destroy undefine disk_rm clean help
DOMAIN=fedora36kele

help:
	@echo "Available targets:"
	@echo "  *kelevate_vm*    - Create the virtual machine"
	@echo "  fedora_prereqs   - Install lib virt prerequisites on Fedora"
	@echo "  ubuntu_prereqs   - Install lib virt prerequisites on Ubuntu (untested)"
	@echo "  disk             - Create the disk directory"
	@echo "  *clean*          - Destroy the virtual machine and disk image"

# Create the virtual machine
kelevate_vm: disk
	./install.sh

# Install prerequisites on Fedora
fedora_prereqs:
	sudo dnf install -y virt-manager libvirt libvirt-daemon libvirt-daemon-config-network qemu-kvm
	sudo dnf install -y @virtualization
	sudo systemctl start libvirtd
	sudo systemctl enable libvirtd

# Install prerequisites on Ubuntu (untested)
ubuntu_prereqs:
	echo THIS IS UNTESTED ON UBUNTU!
	sudo apt-get update
	sudo apt-get install -y virtinst qemu-kvm libvirt-daemon libvirt-daemon-system libvirt-clients bridge-utils
	sudo systemctl start libvirtd
	sudo systemctl enable libvirtd

# Create the disk dir
disk:
	mkdir -p disk

# Clean up the vm and disk
# This destroys everything
# XXX removing the kickstart file is better than nothing, but will prob cause a problem down the line.
clean:
	rm -rf fedora36kele.ks
	virsh destroy $(DOMAIN)
	virsh undefine $(DOMAIN)
	rm disk/$(DOMAIN).qcow2
fedora36-ks.iso: fedora36.ks
	genisoimage -o fedora36-ks.iso -r -J -V "KICKSTART" fedora36.ks

prereqs:
	sudo dnf install genisoimage -y

destroy:
	virsh destroy fedora36kele
undefine:
	virsh undefine fedora36kele
disk_rm:
	rm disk/fedora36.qcow2
virsh_install:
	./install.sh
clean:
	$(MAKE) destroy
	$(MAKE) undefine
	$(MAKE) disk_rm
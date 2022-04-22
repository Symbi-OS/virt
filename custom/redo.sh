# Running this from my host. 122.77 is the guest.

# Revert image to working fedora33 state
cp ../host/guest_disk.img ./guest_disk.img

# Start the vm
virsh create vm_spec.config

# Copy in my custom bzImage (based on linux 5.7 not 5.8).
scp /home/tommyu/Symbi-OS/linux/arch/x86/boot/bzImage root@192.168.122.77:/boot/vmlinuz-5.7.0.x86_64

# Copy in the module directory from my build of linux. Basically empty.
rsync --progress -avhe ssh /tmp/kmods/lib/modules/5.7.0+/  root@192.168.122.77:/lib/modules/5.7.0.x86_64

# Remove old fedora modules there are a whole bunch of them.
ssh root@192.168.122.77 rm -rf /lib/modules/5.8.15-301.fc33.x86_64

# Register my kernel with grubby.
ssh root@192.168.122.77 grubby --grub2 --add-kernel=/boot/vmlinuz-5.7.0.x86_64 --title="Linux Symbiote" --initrd=/boot/initramfs-5.8.15-301.fc33.x86_64.img  --copy-default

# Set my kernel as the default
ssh root@192.168.122.77  grubby --set-default /boot/vmlinuz-5.7.0.x86_64

ssh root@192.168.122.77  reboot

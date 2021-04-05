# Downlaod fedora iso image, make disk for the vm, and install the OS on the VM
./create_vm.sh

# choose configuration
# see INSTALLATION_README.txt in this directory for details.

# Get the xml dump from the vm, so we can use this to boot later.
./get_vm_config.sh

# Shut down the original vm
./destroy_vm.sh

# Re-boot the VM
./boot_vm.sh

# Connect to the console
./get_console.sh

# It might be better to connect with ssh
# ssh root@xxx.xxx.xxx.xxx

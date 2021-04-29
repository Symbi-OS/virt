vm_spec.config is the first thing I got working with 46 cores.
solo_vm_spec.config is the exact same as above, but 1 vcpu.
debug_vm_spec.conf is the same as above, but allows for connection to port 1111 via gdb.
debug_virtiofs_vm_spec.conf is the same as above, but enables virtiofs which (apparently) must be run as sudo. The disk image is moved somewhere root can access.
debug_virtio_multicore.conf is the same as above, but has 46 cores instead of 1.


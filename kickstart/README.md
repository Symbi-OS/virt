

# Fedora 36 Virtual Machine Installation (install.sh) Script Documentation

This script, named `install.sh`, is designed to automatically install a Fedora 36 virtual machine (VM) using the `virt-install` command and kickstart files for configuration.

## Prerequisites
You need `wget`, `free`, `nproc`, and `virt-install` installed on your machine and have adequate memory and processor cores available.

## Key Features

1. **System Resources Allocation**: The script calculates and reserves system resources for the VM, using 75% of available RAM and all available CPU cores.

2. **Automated Configuration**: It uses a kickstart file (`.ks`) to automate the VM's configuration. If the kickstart file doesn't already exist, the script generates one with preset configurations like disk partitioning, timezone, system language, user creation, etc.

3. **VM Installation**: The script installs the VM using `virt-install` with the settings defined in the kickstart file and system resources calculated earlier. It creates a qcow2 virtual disk for the VM in the current working directory.

## Usage

The script is expected to be run with a Makefile. Here's how to use the provided Makefile:

1. Run the target `kelevate_vm` to create the virtual machine:

```bash
make kelevate_vm
```

The `kelevate_vm` target first ensures that the disk directory is created (`disk` target) and then runs the `install.sh` script.

If you're on Fedora and you need to install libvirt prerequisites, run:

```bash
make fedora_prereqs
```

2. To destroy the virtual machine and disk image, use the `clean` target:

```bash
make clean
```

**Note**: Make sure you have the necessary permissions to run these make commands. You might need to prepend `sudo` to the commands depending on your system's configuration.

## Customization

Review and adjust the script and Makefile as necessary for your context, particularly the resource allocation, password settings, and prerequisites.

## Caution

Running this script will create a new VM on your system. Be aware that this might consume significant system resources. 

We allocate 3/4 of your system memory and the full count of cpus to the VM, check if you're happy with those properties.

We allocate a 200G disk lazily. You do not need that much space up front.

The disk lives in the ./disk directory which will be created here,
but is a degree of freedom for you to mount another disk if you want.

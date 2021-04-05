# Once you get the vm up and running with ./create_vm.sh, you can follow these steps to 
# do your installation of the dvd image onto the disk.


# Select use text mode
2 enter

# installation choose dvd
3 
1
# ! doesn't update until refresh
r

# Software, choose none
4
# select fedora
1
c
c
r

# Installation dest hard drive
5 
# r hiccup
c
# no cahnge use al free spcae
c
# partition for LVM (I guess)
c

# root password
7
make pw
accept

# Start installation
b

# when done in a few mins reboot
enter 

# should come up with a network connection, can ping www.google.com

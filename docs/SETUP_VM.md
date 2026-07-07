# Virtual Machine Setup Instructions

## Why?
Idk, sometimes you just want to test your setup without actually fucking up your setup even if you have the way to rollback it. The ultimate way to feel safe is to do it in a virtual machine - just like we used to do it in the old days.

For this setup, we'll utilize the fun QEMU-KVM combo.
If you work on a machine that doesn't support KVM: womp womp. Use a virtual box then.

## Instructions:
1. Download the Arch Linux `qcow2` image from [here](https://gitlab.archlinux.org/archlinux/arch-boxes/-/packages)
2. Install [QEMU](https://wiki.archlinux.org/title/QEMU)
3. Install [Libvirt](https://wiki.archlinux.org/title/Libvirt)
4. Install [virt-manager GUI](https://wiki.archlinux.org/title/Virt-manager)
5. Start & enable default network
5. Launch virt-manager and spin up a new VM using the image
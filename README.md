## Usage
You can donwload and start the installer script as such:
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Miautawn/ansible-quicktest/master/bin/miautawn-setup)"
```

Optionally you can specify only specific tags to install as such:
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Miautawn/ansible-quicktest/master/bin/miautawn-setup)" -- --tags core,common,utils
```

## BTRF Layout
Here are the subvolumes that I use for my installs

| Subvolume    | Mountpoint       |
| ------------ | ---------------- |
| @            | /                |
| @home        | /home            |
| @var_log     | /var/log         |
| @var_cache   | /var/cache       |
| @var_tmp     | /var/tmp         |
| @snapshots   | /.snapshots      |
| @games       | /home/$USER/Games|

`EFI` partition ought to be mounted on `/efi` ([source](https://wiki.archlinux.org/title/EFI_system_partition#Typical_mount_points))

**NOTE**: when using `archinstall` you can create the @games subvolume directly by specifying fully rendered mountpoint e.g. `/home/miautawn/Games`. This however, will leave your /home/$USER directory created by root and owned by root - not a good time xD. To fix this, simply run this in your home directory:
```
sudo chown -R $USER: ~
```

### Bootloader Funtime
Since we wish to use LUKS disk encryption, we kinda need to use `GRUB` because of it's abiliity to actually decrypt the encrypted `/boot`

**NOTE**: In this setup, we adopt "independent bootloaders" approach, whreby all OS'es will have their own bootloaders but we will have a primary one from which we will boot all others. This means that GRUB runtime files will be kept separately in each `/boot` of each OS install. This will allows us to keep bootloader itself part of snapshots together will linux bootfiles.

Our setup assumes this partition layout after fresh install:
```
EFI
└── LinuxOS_Gaming
    └── grubx64.efi
└── LinuxOS_Work
    └── grubx64.efi

LinuxOS_Gaming
├── /efi (mounted EFI)
└── /boot
    ├── initramfs-linux.img
    ├── vmlinuz-linux
    └── grub
        ├── grub.cfg
        └── ...

LinuxOS_Work (LUKS)
├── /efi (mounted EFI)
└── /boot
    ├── initramfs-linux.img
    ├── vmlinuz-linux
    └── grub
        ├── grub.cfg
        └── ...
```

#### Archinstall
When using `archinstall` scipt do the following steps:
1. Do the setup and partitioning as usual - explicitly making an EFI partition (mounted on `/efi`) + the BTRFS partition with desired volumes.
2. Mark the BTRFS partition to be encrypted with LUKS
3. Choose GRUB bootloader. DO NOT choose the `removable` option. Disable UKI (unified kernel image). UKI's kinda go against of having bootfiles part of the snapshots.
4. Prooceed
5. **chroot** into the new environment (DO NOT REBOOT YET!)
6. If used LUKS: tell grub to be able to decode the encrypted partition:
```
In: /etc/default/grub
GRUB_ENABLE_CRYPTODISK=y
```
7. By default, archinstall will install GRUB to `/efi` itself. Tell it to install it to `/boot` with a unique name in EFI:
```
grub-install --target=x86_64-efi --bootloader-id=YOUR_NAME --efi-directory=/efi --boot-directory=/boot
```
8. Remove the `/efi` grub install:
```
rm -rf /efi/grub
```
9. Regenerate the GRUB config file in `/boot`:
```
grub-mkconfig -o /boot/grub/grub.cfg
```

#### LUKS
If you ever need to mount LUKS encrypted OS from outside, here are the steps:

```
sudo cryptsetup open /dev/XXX other_os
sudo mount -t btrfs -o subvol=@ /dev/mapper/other_os /mnt

sudo umount /mnt
sudo cryptsetup close other_os
```

### Subvolume Options
`@`, `@home`, `@var*`, `@snapshot`
- **noatime**: stops the system from writing a new timestamp every time you open a file. This prevents unnecessary background writes. It significantly speeds up read-intensive tasks and reduces wear on your drive.
- **compress=zstd:3**: enables zstd compression on level 3 (default). Provides a great balance of speed and storage.
- **ssd**: enables autodetection of SSD optimizations.
- **space_cache=v2**: The free space cache greatly improves performance when reading block group free space into memory.

`@games`
- **noatime**: stops the system from writing a new timestamp every time you open a file. This prevents unnecessary background writes. It significantly speeds up read-intensive tasks and reduces wear on your drive.
- **nodatacow**: explicitly disabled CoW and ZSTD Compression to reduce fragmentation induced by game updates.
- **ssd**: enables autodetection of SSD optimizations.
- **space_cache=v2**: The free space cache greatly improves performance when reading block group free space into memory.

## Tests
Run tests from the top-level project directory for the corresponding OS:
```bash
>> ./tests/arch-linux/run_tests.sh
```

```
xdpyinfo | grep -B2 resolution
xrdb -query | grep dpi
``` 
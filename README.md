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

**NOTE**: In this setup, we write the GRUB directly to EFI, meaning that the EFI partition contains all the themes/configs for GRUB. We make this choice to allow our /boot files to be part of BTRFS snapshots (as otherwise you will have incomplete snapshots in the case of broken bootfiles). And because we will be using LUKS, we can't just have GRUB files be in the encrypted partition.

Our setup assumes this partition layout after fresh install:
```
EFI
└── grub
    ├── grub.cfg
    ├── themes
    └── fonts

LinuxOS_Gaming
├── /efi (mounted EFI)
└── /boot
    ├── initramfs-linux.img
    └── vmlinuz-linux

LinuxOS_Work (LUKS)
├── /efi (mounted EFI)
└── /boot
    ├── initramfs-linux.img
    └── vmlinuz-linux
```

Because of this layout + encryption, GRUB won't be able to automatically detect and chain different Arch installs, so we have to put some elbow greese to connect them.

#### LUKS Compatability
By default, `archinstall` scipt uses `` for LUKS encryption. GRUB does not support it at the time, making 

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
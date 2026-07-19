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
Bootloader: GRUB (because of independent LUKS decryption support + themes!)

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
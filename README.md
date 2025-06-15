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
| Subvolume    | Mountpoint |
| ------------ | ---------- |
| @            | /          |
| @home        | /home      |
| @var_log     | /var/log   |
| @var_cache   | /var/cache |
| @var_tmp     | /var/tmp   |
| @snapshots   | /.shapshots (will be created manually through snapper)  |



## Tests
Run tests from the top-level project directory for the corresponding OS:
```bash
>> ./tests/arch-linux/run_tests.sh
```


```
xdpyinfo | grep -B2 resolution
xrdb -query | grep dpi
``` 
## Usage
You can donwload and start the installer script as such:
```
curl -L https://raw.githubusercontent.com/Miautawn/ansible-quicktest/refs/heads/master/bin/miautawn-setup | bash -s
```

Optionally you can specify only specific tags to install as such:
```
curl -L https://raw.githubusercontent.com/Miautawn/ansible-quicktest/refs/heads/master/bin/miautawn-setup | bash -s -- --tags=desktop
```

## Tests
Run tests from the top-level project directory for the corresponding OS:
```bash
>> ./tests/arch-linux/run_tests.sh
```
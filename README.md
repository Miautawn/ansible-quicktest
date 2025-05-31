## Usage
You can donwload and start the installer script as such:
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Miautawn/ansible-quicktest/master/bin/miautawn-setup)"
```

Optionally you can specify only specific tags to install as such:
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Miautawn/ansible-quicktest/master/bin/miautawn-setup)" -- --tags core,common,utils
```

## Tests
Run tests from the top-level project directory for the corresponding OS:
```bash
>> ./tests/arch-linux/run_tests.sh
```
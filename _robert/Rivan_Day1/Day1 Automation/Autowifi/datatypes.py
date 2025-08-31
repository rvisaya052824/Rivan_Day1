import netmiko
from netmiko import ConnectHandler

device_info = {
    'device_type': 'cisco_ios_telnet',
    'host': '10.91.1.4',
    'password': 'pass',
    'secret': 'pass'
}

config = [
    'interface loopback 1',
    'ip address 1.1.1.1 255.255.255.255',
    'end'
]

accesscli = ConnectHandler(**device_info)
accesscli.enable()

output = accesscli.send_config_set(config)
print(output)
siib = accesscli.send_command('show ip int br')
print(siib)

accesscli.send_config_set(config)

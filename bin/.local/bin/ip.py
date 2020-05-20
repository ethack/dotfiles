#!/usr/bin/env python3

import re
import sys
from collections import defaultdict
from copy import deepcopy

# sample output from `ip addr` to use as input to this script
'''
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: enp0s31f6: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast state DOWN group default qlen 1000
    link/ether 48:2a:e3:1f:94:f3 brd ff:ff:ff:ff:ff:ff
3: wlp0s20f3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether 64:5d:86:a0:16:da brd ff:ff:ff:ff:ff:ff
    inet 10.201.34.66/20 brd 10.201.47.255 scope global dynamic wlp0s20f3
       valid_lft 3358sec preferred_lft 3358sec
    inet6 fe80::df0:6020:d33:f09a/64 scope link
       valid_lft forever preferred_lft forever
4: virbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
    link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
    inet 192.168.122.1/24 brd 192.168.122.255 scope global virbr0
       valid_lft forever preferred_lft forever
5: virbr0-nic: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN group default qlen 1000
    link/ether 52:54:00:e5:e5:19 brd ff:ff:ff:ff:ff:ff
7: br-0a4dadd05c1d: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default
    link/ether 02:42:8e:8c:84:65 brd ff:ff:ff:ff:ff:ff
    inet 192.168.48.1/20 brd 192.168.63.255 scope global br-0a4dadd05c1d
       valid_lft forever preferred_lft forever
8: br-77ed4c942e31: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default
    link/ether 02:42:64:1b:a4:de brd ff:ff:ff:ff:ff:ff
    inet 172.18.0.1/16 brd 172.18.255.255 scope global br-77ed4c942e31
       valid_lft forever preferred_lft forever
9: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default
    link/ether 02:42:63:c1:b9:f6 brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever
    inet6 fe80::42:63ff:fec1:b9f6/64 scope link
       valid_lft forever preferred_lft forever
23: wg0: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1420 qdisc noqueue state UNKNOWN group default qlen 1000
    link/none
    inet 10.32.99.5/24 scope global wg0
       valid_lft forever preferred_lft forever
'''

DEBUG = False
IFWIDTH = 16

def print_interface(interface, ipv4, ipv6):
    if interface and (ipv4 or ipv6):
        msg = '{interface:>' + str(IFWIDTH) + '}: {ipv4:<16} {ipv6}'
        print(msg.format(
            interface=interface,
            ipv4=ipv4 if ipv4 else '<no IPv4>',
            ipv6=ipv6
        ))

# exclude these interfaces from the output
excludes = ('lo', 'br-[0-9a-f]+', 'docker0', 'virbr0.*')

interface = ''
ipv4 = ipv6 = ''
exclude = False

interfaces = []

for line in sys.stdin.readlines():
    if DEBUG: print('Processing line:\n' + line)

    # read interface name
    match = re.match(r'\d+: (.+):', line)
    if match:
        if DEBUG: print(f'Matched interface {match[1]} on {line}')
        # done with interface, print previous interface details
        if not exclude:
            interfaces.append((interface, ipv4, ipv6))
            # keep track of the longest name so we can format nicely
            if len(interface) > IFWIDTH:
                IFWIDTH = len(interface)

        interface = match[1]
        ipv4 = ipv6 = ''
        exclude = False

    # skip to the next non-excluded interface
    match = re.match('|'.join(excludes), interface)
    if match:
        if DEBUG: print(f'Excluding interface {interface}')
        exclude = True
        continue

    # read IPv4 address
    match = re.match('    inet ([0-9./]+)', line)
    if match:
        if DEBUG: print(f'Matched ipv4 {match[1]} on {line}')
        ipv4 = match[1]

    # read IPv6 address
    match = re.match('    inet6 ([0-9./a-f:]+)', line)
    if match:
        if DEBUG: print(f'Matched ipv6 {match[1]} on {line}')
        ipv6 = match[1]

# done with interface, print previous interface details
if not exclude:
    interfaces.append((interface, ipv4, ipv6))
    # keep track of the longest name so we can format nicely
    if len(interface) > IFWIDTH:
        IFWIDTH = len(interface)

# print all the interfaces
for interface in interfaces:
    print_interface(*interface)

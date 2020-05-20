#!/bin/bash

# apt install linux-headers-$(uname -r)

wg-quick down wg0
wg-quick up wg0

# https://www.wireguard.com/netns/
#route add -net default gw 10.32.99.1 netmask 0.0.0.0 dev wg0 metric 0
# TODO remove other default routes
# TODO verify all traffic is going through wireguard, activate Wireguard firewall profile

# WireGuard already ships with the wg-quick@.service unit, which is ± exactly what you have in here. Thus, rather than instructing users to create a new unit, you may simple instruct them to systemctl enable wg-quick@wg0 and systemctl start wg-quick@wg0. The Ubuntu packages should be installing this automatically, and if you're compiling and installing manually, make install will automatically install this unit file too.

#!/bin/bash

alias update='apt-get update'
alias upgrade='apt-get -y upgrade'
alias install='apt-get -y install'

update && upgrade

install \
htop \
ripgrep \
stow \
wireguard \
vim \
zsh

# Set ZSH as default shell
chsh -s $(which zsh)

# cli/gui integration
install \
xclip \
xdg-utils

# development
install \
docker.io \
docker-compose \
golang-1.14 \
lua5.3 \
python3 \
python3-pip \

ln -s /usr/lib/go-1.14/bin/go /usr/lib/bin/go
ln -s /usr/lib/go-1.14/bin/gofmt /usr/lib/bin/gofmt

wget -O /tmp/exa.zip https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip
unzip -j -d /usr/local/bin/ /tmp/exa.zip
mv /usr/local/bin/exa-linux-x86_64 /usr/local/bin/exa
rm /tmp/exa.zip

pip3 install thefuck

# graphical programs
# TODO: chrome
install \
code \
flameshot \
peek \
tilix
# add-apt-repository ppa:webupd8team/terminix

# kitty - gpu accelerated terminal editor
#curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
# alacritty

# resilio
echo "deb http://linux-packages.resilio.com/resilio-sync/deb resilio-sync non-free" | sudo tee /etc/apt/sources.list.d/resilio-sync.list
curl -LO http://linux-packages.resilio.com/resilio-sync/key.asc && sudo apt-key add ./key.asc
update && install \
resilio-sync

# kvm
install \
qemu-kvm \
virt-manager
mkdir -p ~/VirtualMachines/images
(cd ~/VirtualMachines/ && wget https://www.spice-space.org/download/windows/spice-guest-tools/spice-guest-tools-latest.exe)

# vscode
# I'm not sure if piping to stdout will work like this
# wget -qO - https://go.microsoft.com/fwlink/?LinkID=760868 | sudo dpkg -i -
# code --install-extension ms-vscode.go
# # debugger
# go get -u github.com/go-delve/delve/cmd/dlv
# # linter
# go get -u github.com/golangci/golangci-lint/cmd/golangci-lint

EDITOR=vim

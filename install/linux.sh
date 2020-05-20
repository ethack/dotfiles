#!/bin/bash

alias update='apt-get update'
alias upgrade='apt-get -y upgrade'
alias install='apt-get -y install'

update && upgrade

# TODO: inline comments don't work here
install \
git \
gnome-sushi \   # quick look preview for files
gufw \          # GUI for UFW
htop \
python3 \
python3-pip \
stow \          # dotfile manager
variety \       # wallpaper manager
vim \
xcape           # hyper/capslock to escape

# Note: doesn't work on 16.04
# https://www.omgubuntu.co.uk/2019/06/install-regolith-linux-i3-gaps-ubuntu
add-apt-repository ppa:kgilmer/regolith-stable
update && install \
regolith-desktop

# autokey
install \
libdbus-1-dev \
libglib2.0-de \
xclip
add-apt-repository ppa:sporkwitch/autokey
update && install \
autokey
pip3 install pyautogui

# kitty - gpu accelerated terminal editor
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# resilio
echo "deb http://linux-packages.resilio.com/resilio-sync/deb resilio-sync non-free" | sudo tee /etc/apt/sources.list.d/resilio-sync.list
curl -LO http://linux-packages.resilio.com/resilio-sync/key.asc && sudo apt-key add ./key.asc
update && install \
resilio-sync

# sublime
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
update && install \
apt-transport-https \
sublime-text

# typora - markdown editor
# add Typora's repository
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE
add-apt-repository 'deb https://typora.io/linux ./'
update && install typora

# ukuu
apt-add-repository -y ppa:teejee2008/ppa
update && install ukuu

# docker
curl -fsSL https://test.docker.com | sh

# kvm
install \
qemu-system \
virt-manager
mkdir -p ~/Documents/vm/shared
(cd ~/Documents/vm/shared && wget https://www.spice-space.org/download/windows/spice-guest-tools/spice-guest-tools-latest.exe)

# Linux brew
curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh | sh
echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> ~/.profile
echo 'PATH=/home/linuxbrew/.linuxbrew/bin:$PATH' >> ~/.profile
source ~/.profile

# brew tap homebrew/cask

brew install
bat \
byobu \			# terminal multiplexer a-la screen or tmux
docker \
keychain \		# frontend for ssh-agent and gpg-agent
ripgrep \
#sift
# or https://sift-tool.org/downloads/sift/sift_0.9.0_linux_amd64.tar.gz
# or go get github.com/svent/sift
zsh

# Install ruby gems
brew install ruby
gem install colorls
# put in ~/.zshrc: source $(dirname $(gem which colorls))/tab_complete.sh

# Set ZSH as default shell
command -v zsh >> /etc/shells
chsh -s =zsh

# Install Tilix terminal emulator
add-apt-repository ppa:webupd8team/terminix
update && install tilix

# go
# download go bin
# extract
# create go workspace
# add bins to path
# set env variables
curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

# vscode
# I'm not sure if piping to stdout will work like this
wget -qO - https://go.microsoft.com/fwlink/?LinkID=760868 | sudo dpkg -i -
code --install-extension ms-vscode.go
# debugger
go get -u github.com/go-delve/delve/cmd/dlv
# linter
go get -u github.com/golangci/golangci-lint/cmd/golangci-lint

EDITOR=vim

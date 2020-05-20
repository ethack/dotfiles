
```bash
git clone --recursive https://github.com/ethack/dotfiles.git
cd dotfiles

apt install stow
stow bin
stow editor
stow git
stow shell
stow zsh

apt install zsh
chsh -s $(which zsh)
```

No need to do anything special with zsh. Plugins will be downloaded on first run.

`zgen update` to update plugins
`zgen selfupdate` to update zgen


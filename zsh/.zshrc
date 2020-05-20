
# environment variables
[[ -s "$HOME/.shellenv.sh" ]] && source "$HOME/.shellenv.sh"

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

# zsh options
setopt complete_aliases # Treat aliases as distinct commands.
setopt menu_complete # Expand first match and use the interactive menu.
setopt glob # Enable globbing (i.e. the use of the '*' operator).
setopt clobber # Allow '>' to clober files
setopt append_create # Allow '>>' to create a file.
setopt interactive_comments # Allow comments in interactive shells.
setopt short_loops # Enable short loop syntax: `for <var> in <seq>; <command>`.

# not sure what this does
autoload -Uz promptinit
promptinit

# plugins
if [ -s "$HOME/.zgen/zgen.zsh" ]; then
    source "$HOME/.zgen/zgen.zsh"

    # if the init script doesn't exist
    if ! zgen saved; then

        # specify plugins here
        zgen oh-my-zsh
        zgen oh-my-zsh plugins/colored-man-pages
        zgen oh-my-zsh plugins/docker
        zgen oh-my-zsh plugins/docker-compose
        zgen oh-my-zsh plugins/ripgrep
        # zgen oh-my-zsh plugins/sudo
        zgen oh-my-zsh plugins/thefuck
        zgen oh-my-zsh themes/steeef
        # themes: agnoster (additional setup), arrow, bira, blinks, steeef

        zgen load zsh-users/zsh-syntax-highlighting
        zgen load zsh-users/zsh-autosuggestions
        zgen load zsh-users/zsh-history-substring-search
        zgen load zsh-users/zsh-completions
        # requires lua, faster fasd or z
        # zgen load skywind3000/z.lua
        # directory listings with git features
        zgen load supercrabtree/k
        # enables zsh's cdr features; must be before zaw
        zgen load willghatch/zsh-cdr
        zgen load zsh-users/zaw

        # https://github.com/ohmyzsh/ohmyzsh/wiki/External-themes
        # external themes: zsh2000, powerlevel10k, Bullet Train, Gitster, Spaceship ZSH, Nodeys
        # zgen load romkatv/powerlevel10k powerlevel10k
        # zgen load danihodovic/steeef
        # requires font install
        # zgen load arialdomartini/oh-my-git
        # zgen load arialdomartini/oh-my-git-themes oppa-lana-style
        # zgen load denysdovhan/spaceship-prompt spaceship

        # generate the init script from plugins above
        zgen save
    fi
fi

# aliases
[[ -s "$HOME/.aliases.sh" ]] && source "$HOME/.aliases.sh"

# custom functions
if [ -s "$HOME/.zsh/functions" ]; then
    fpath=( $HOME/.zsh/functions $fpath )
    autoload -z g
    autoload -Uz vpn
    # autoload -Uz ~/.zsh/functions/*(:t)
fi

# zsh auto-completion (look into this if there are performance issues)
#zstyle :compinstall filename '/home/ethan/.zshrc'
autoload -Uz compinit
compinit
# autocompletion with an arrow-key driven interface
zstyle ':completion:*' menu select
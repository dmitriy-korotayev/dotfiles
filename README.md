My dotfiles
============

## Unobvious prerequisites

Vim: `gvim` for Python3 compatibility (UltiSnips)
i3: `pulseaudio-ctl` for volume control
debian: `apt-get install fortune cowsay fzf tmux vim-gtk3`
*and anything else I forgot*

## Installation

```zsh
cd ~
mkdir -p .config .local/share/fonts
git clone https://github.com/dmitriy-korotayev/dotfiles.git
cd dotfiles
git submodule init
git submodule update
stow -vt ~ [packages]
ln -s dotfiles/git/.gitignore ~/.gitignore
source ~/.zshrc
zplug install
```
* we're symlinking .gitignore because it's ignored by default in stow

Vim:

```vim
:BundleInstall
```

Environment variables:

```zsh
cd ~
cp .zshenv.local{.sample,}
vim .zshenv.local
```

## Known issues

- Backspace works weird on `zsh` when using `ssh` (adds spaces, doesn't remove visually): 

Install `urxvt` or whatever terminal you're using

## Uninstallation

```zsh
cd [path to dotfiles directory]
stow -Dt ~ [packages]
```

## TODO

- Add some sugar to README
- Don't set the language in `.zshrc` if it doesn't exist
- Make vim check if :BundleInstall is done
- Use local colorscheme in vim

My dotfiles
=========================

# Unobvious prerequisites

Vim: `make`, `cmake`, `gcc` for `YouCompleteMe` plugin compiling

# Installation

```
git clone https://github.com/dmitriy-korotayev/dotfiles.git
cd dotfiles
git submodule init
git submodule update
stow -vt ~ [packages]
```

Vim:

```
:BundleInstall
```

# Known issues

- Backspace works weird on `zsh` when using `ssh` (adds spaces, doesn't remove visually): 

Install `urxvt` or whatever terminal you're using

# Uninstallation

```
cd [path to dotfiles directory]
stow -Dt ~ [packages]
```

# TODO

- Don't set the language in `.zshrc` if it doesn't exist
- Make vim check if :BundleInstall is done
- Use local colorscheme in vim

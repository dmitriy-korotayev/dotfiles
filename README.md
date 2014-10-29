My dotfiles
============

## Unobvious prerequisites

Vim: `make`, `cmake`, `gcc` for `YouCompleteMe` plugin compiling

## Installation

```zsh
git clone https://github.com/dmitriy-korotayev/dotfiles.git
cd dotfiles
git submodule init
git submodule update
stow -vt ~ [packages]
```

Vim:

```vim
:BundleInstall
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
